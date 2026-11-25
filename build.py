import hashlib
import io
import os
from pathlib import Path
import shutil
import urllib.request
import zipfile

import typst

ROOT = Path(__file__).parent
WEB_DIR = ROOT / "web"
DIST_DIR = ROOT / "dist"
FONT_CACHE_DIR = (
    Path(os.environ.get("XDG_CACHE_HOME") or Path.home() / ".cache")
    / "omkar-resume"
    / "fonts"
)

FONT_ARCHIVES = [
    (
        "https://github.com/rsms/inter/releases/download/v4.1/Inter-4.1.zip",
        {
            "InterVariable.ttf": "InterVariable.ttf",
            "InterVariable-Italic.ttf": "InterVariable-Italic.ttf",
        },
    ),
    (
        "https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304/JetBrainsMono-2.304.zip",
        {
            "fonts/variable/JetBrainsMono[wght].ttf": "JetBrainsMono[wght].ttf",
            "fonts/variable/JetBrainsMono-Italic[wght].ttf": "JetBrainsMono-Italic[wght].ttf",
        },
    ),
]


def ensure_fonts() -> Path:
    FONT_CACHE_DIR.mkdir(parents=True, exist_ok=True)
    for url, members in FONT_ARCHIVES:
        missing = [
            (src, FONT_CACHE_DIR / dest)
            for src, dest in members.items()
            if not (FONT_CACHE_DIR / dest).exists()
        ]
        if not missing:
            continue
        print(f"Fetching external fonts from {url}...")
        with urllib.request.urlopen(url, timeout=120) as resp:
            archive_bytes = resp.read()
        with zipfile.ZipFile(io.BytesIO(archive_bytes)) as zf:
            for src, dest_path in missing:
                dest_path.write_bytes(zf.read(src))
    return FONT_CACHE_DIR


def bust_asset_cache() -> None:
    index = DIST_DIR / "index.html"
    html = index.read_text(encoding="utf-8")
    for attr, name in (("href", "styles.css"), ("src", "app.js")):
        digest = hashlib.sha256((DIST_DIR / name).read_bytes()).hexdigest()[:8]
        old = f'{attr}="{name}"'
        count = html.count(old)
        if count != 1:
            raise RuntimeError(f"Expected one {old} in {index}, found {count}")
        html = html.replace(old, f'{attr}="{name}?v={digest}"')
    index.write_text(html, encoding="utf-8")


def build() -> None:
    font_dir = ensure_fonts()
    if DIST_DIR.exists():
        shutil.rmtree(DIST_DIR)
    shutil.copytree(WEB_DIR, DIST_DIR)
    bust_asset_cache()

    typst.compile(
        ROOT / "resume.typ",
        output=DIST_DIR / "Omkar_Chandorkar.pdf",
        root=ROOT,
        font_paths=[font_dir],
        ignore_system_fonts=True,
        timestamp=0,
    )
    print(f"Build complete: {DIST_DIR} generated successfully.")


if __name__ == "__main__":
    build()

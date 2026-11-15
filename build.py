import io
import os
from pathlib import Path
import re
import urllib.request
import zipfile

import typst

ROOT = Path(__file__).parent
FONT_CACHE_DIR = (
    Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache"))
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


FONT_DIR = ensure_fonts()

# 1. Compile PDF
typst.compile(
    ROOT / "resume.typ",
    output=ROOT / "Omkar_Chandorkar.pdf",
    root=ROOT,
    font_paths=[FONT_DIR, ROOT / "fonts"],
    ignore_system_fonts=True,
    timestamp=0,
)

# 2. Compile SVG
svg_output = typst.compile(
    ROOT / "resume.typ",
    root=ROOT,
    font_paths=[FONT_DIR, ROOT / "fonts"],
    ignore_system_fonts=True,
    format="svg",
    timestamp=0,
)
svg_bytes = svg_output[0] if isinstance(svg_output, list) else svg_output
svg = re.sub(
    r'(<svg\b[^>]*?)width="[^"]*" height="[^"]*"',
    r'\1width="100%" height="100%"',
    svg_bytes.decode("utf-8"),
    count=1,
)
# Standalone SVG links navigate the top-level page.
(ROOT / "resume.svg").write_text(
    svg.replace("<a ", '<a target="_top" '), encoding="utf-8"
)
inline_svg = svg.replace(
    'width="100%" height="100%"',
    'width="100%" height="auto" style="display: block"',
    1,
)
inline_svg = re.sub(
    r'<a (?=[^>]*\bhref="https?://)',
    '<a target="_blank" rel="noopener noreferrer" ',
    inline_svg,
)

# 3. Generate index.html with inline SVG and a sticky action bar
html_content = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Omkar Chandorkar — Resume</title>
  <meta name="description" content="Resume of Omkar Chandorkar — Software Engineer (AI Tooling, Backend & Systems)">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --bg: #0f172a;
      --card-bg: #ffffff;
      --bar-bg: rgba(15, 23, 42, 0.85);
      --border: #334155;
      --text: #f8fafc;
      --muted: #94a3b8;
      --accent: #3b82f6;
      --accent-hover: #2563eb;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      background-color: var(--bg);
      color: var(--text);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    /* Fixed top navigation bar */
    .top-bar {
      position: sticky;
      top: 0;
      width: 100%;
      background: var(--bar-bg);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--border);
      z-index: 100;
      padding: 0.75rem 1.5rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 0.75rem;
      flex-wrap: wrap;
    }

    .brand {
      font-size: 1.05rem;
      font-weight: 700;
      color: var(--text);
      letter-spacing: -0.01em;
    }

    .actions {
      display: flex;
      gap: 0.75rem;
      align-items: center;
      flex-wrap: wrap;
    }

    .btn {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      background-color: var(--accent);
      color: #ffffff;
      font-weight: 600;
      font-size: 0.875rem;
      padding: 0.5rem 1rem;
      border-radius: 0.375rem;
      text-decoration: none;
      transition: background-color 0.15s ease, transform 0.1s ease;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
    }

    .btn:hover {
      background-color: var(--accent-hover);
      transform: translateY(-1px);
    }

    .btn-secondary {
      background-color: transparent;
      box-shadow: none;
      padding: 0.5rem 0.6rem;
      color: var(--text);
    }

    .btn-secondary:hover {
      background-color: var(--border);
    }

    .btn svg {
      width: 16px;
      height: 16px;
      fill: currentColor;
    }

    /* Resume container */
    .container {
      width: 100%;
      max-width: clamp(860px, 60vw, 1040px);
      padding: 2rem 1rem 3rem 1rem;
      display: flex;
      justify-content: center;
    }

    .card {
      background-color: var(--card-bg);
      border-radius: 0.5rem;
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5), 0 8px 10px -6px rgba(0, 0, 0, 0.5);
      width: 100%;
      overflow: hidden;
      line-height: 0;
    }

    .card svg {
      width: 100%;
      height: auto;
      display: block;
    }

    @media (max-width: 640px) {
      .top-bar {
        padding: 0.6rem 1rem;
      }
      .brand {
        font-size: 0.95rem;
      }
      .btn {
        padding: 0.4rem 0.75rem;
        font-size: 0.8rem;
      }
      .actions {
        gap: 0.35rem;
      }
      .btn-secondary {
        padding: 0.4rem 0.5rem;
      }
      .container {
        padding: 1rem 0.5rem 2rem 0.5rem;
      }
    }

    @media print {
      @page {
        size: A4;
        margin: 0;
      }
      body {
        background: white;
        color: black;
        min-height: 0;
      }
      .top-bar {
        display: none;
      }
      .container {
        max-width: none;
        padding: 0;
      }
      .card {
        box-shadow: none;
        border-radius: 0;
      }
    }
  </style>
</head>
<body>

  <header class="top-bar">
    <div class="brand">Omkar Chandorkar</div>
    <div class="actions">
      <a href="Omkar_Chandorkar.pdf" download="Omkar_Chandorkar.pdf" class="btn">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v7.586l1.293-1.293a1 1 0 011.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 111.414-1.414L9 11.586V4a1 1 0 011-1z" clip-rule="evenodd" />
          <path fill-rule="evenodd" d="M3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
        </svg>
        Download PDF
      </a>
      <a href="https://github.com/gotenksIN" target="_blank" rel="noopener noreferrer" class="btn btn-secondary">GitHub</a>
      <a href="mailto:omkar0926@gmail.com" class="btn btn-secondary">Email</a>
    </div>
  </header>

  <main class="container">
    <div class="card">
      <!-- RESUME_SVG -->
    </div>
  </main>

</body>
</html>
"""
html_content = html_content.replace("<!-- RESUME_SVG -->", inline_svg)

(ROOT / "index.html").write_text(html_content, encoding="utf-8")
print("Build complete: Omkar_Chandorkar.pdf, resume.svg, index.html generated successfully.")

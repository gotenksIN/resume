from pathlib import Path

import typst


ROOT = Path(__file__).parent

typst.compile(
    ROOT / "resume.typ",
    output=ROOT / "Omkar_Chandorkar.pdf",
    root=ROOT,
    font_paths=[ROOT / "fonts"],
    ignore_system_fonts=True,
    timestamp=0,
)

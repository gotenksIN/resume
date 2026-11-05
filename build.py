from pathlib import Path
import typst

ROOT = Path(__file__).parent

# 1. Compile PDF
typst.compile(
    ROOT / "resume.typ",
    output=ROOT / "Omkar_Chandorkar.pdf",
    root=ROOT,
    font_paths=[ROOT / "fonts"],
    ignore_system_fonts=True,
    timestamp=0,
)

# 2. Compile SVG
svg_output = typst.compile(
    ROOT / "resume.typ",
    root=ROOT,
    font_paths=[ROOT / "fonts"],
    ignore_system_fonts=True,
    format="svg",
    timestamp=0,
)
svg_bytes = svg_output[0] if isinstance(svg_output, list) else svg_output
(ROOT / "resume.svg").write_bytes(svg_bytes)

# 3. Generate index.html wrapper with sticky top bar and Download PDF button
html_content = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Omkar Chandorkar — Resume</title>
  <meta name="description" content="Resume of Omkar Chandorkar — AI Agent Tooling Developer & Android Engineer">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;600;700&display=swap" rel="stylesheet">
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
      font-family: 'Manrope', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
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
      border-bottom: 1pt solid var(--border);
      z-index: 100;
      padding: 0.75rem 1.5rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
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

    .btn svg {
      width: 16px;
      height: 16px;
      fill: currentColor;
    }

    /* Resume container */
    .container {
      width: 100%;
      max-width: 860px;
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

    .resume-object {
      width: 100%;
      height: auto;
      aspect-ratio: 595.28 / 841.89;
      border: none;
      display: block;
    }

    @media (max-width: 640px) {
      .top-bar {
        padding: 0.6em 1rem;
      }
      .brand {
        font-size: 0.95rem;
      }
      .btn {
        padding: 0.4rem 0.75rem;
        font-size: 0.8rem;
      }
      .container {
        padding: 1rem 0.5rem 2rem 0.5rem;
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
    </div>
  </header>

  <main class="container">
    <div class="card">
      <object data="resume.svg" type="image/svg+xml" class="resume-object" title="Omkar Chandorkar Resume">
        <p>Your browser does not support vector SVG rendering. You can <a href="Omkar_Chandorkar.pdf">download the PDF resume here</a>.</p>
      </object>
    </div>
  </main>

</body>
</html>
"""

(ROOT / "index.html").write_text(html_content, encoding="utf-8")
print("Build complete: Omkar_Chandorkar.pdf, resume.svg, index.html generated successfully.")

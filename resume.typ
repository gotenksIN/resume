#let highlight = rgb("2563eb")
#let ink = rgb("0f172a")
#let secondary = rgb("334155")
#let muted = rgb("526071")
#let rule = rgb("cbd5e1")

// --- CENTRAL TYPOGRAPHY CONFIGURATION (+5% over 8a baseline) ---
#let font-name = 25.2pt
#let font-headline = 10.8pt
#let font-location = 9.55pt
#let font-contact-key = 8.6pt
#let font-contact-val = 9.25pt
#let font-section-index = 9.25pt
#let font-section-title = 9.55pt
#let font-entry-title = 11.0pt
#let font-entry-role = 9.85pt
#let font-entry-date = 9.55pt
#let font-body = 10.1pt
#let font-raw = 9.2pt
#let font-arrow = 8.7pt

#set page(
  paper: "a4",
  margin: (x: 1.3cm, y: 1.4cm),
)
#set text(font: "Inter", size: font-body, weight: 420, tracking: 0.004em, fill: ink, hyphenate: false)
#show raw: set text(font: "JetBrains Mono", size: font-raw, weight: 470, tracking: 0em)
#set par(leading: 0.76em, spacing: 0pt)
#set block(spacing: 0pt)
#set list(indent: 0pt, body-indent: 0.65em, spacing: 0.96em, marker: text(fill: muted)[–])

#let mono = "JetBrains Mono"
#let ext-arrow = text(size: font-arrow, weight: 450, baseline: -0.25pt, fill: muted)[↗]

// --- AIRY SPEC MASTHEAD ---
#grid(
  columns: (1fr, auto),
  column-gutter: 18pt,
  align: top,
  [
    #text(size: font-name, weight: 680, tracking: -0.01em, fill: ink)[Omkar Chandorkar]
    #v(7.5pt)
    #text(size: font-headline, weight: 500, tracking: 0.005em, fill: secondary)[Software Engineer — AI Tooling, Backend & Systems]
    #v(7.5pt)
    #text(size: font-location, weight: 430, fill: muted)[Mumbai, India · Open to Remote]
  ],
  grid(
    columns: (auto, auto),
    column-gutter: 11pt,
    row-gutter: 6pt,
    align: (right, left),
    text(font: mono, size: font-contact-key, weight: 500, fill: muted)[EMAIL],
    link("mailto:omkar0926@gmail.com")[#text(font: mono, size: font-contact-val, weight: 450, fill: secondary)[omkar0926\@gmail.com]],
    text(font: mono, size: font-contact-key, weight: 500, fill: muted)[WEBSITE],
    link("https://gotenksin.github.io/resume/")[#text(font: mono, size: font-contact-val, weight: 450, fill: secondary)[gotenksin.github.io/resume]],
    text(font: mono, size: font-contact-key, weight: 500, fill: muted)[GITHUB],
    link("https://github.com/gotenksIN")[#text(font: mono, size: font-contact-val, weight: 450, fill: secondary)[github.com/gotenksIN]],
    text(font: mono, size: font-contact-key, weight: 500, fill: muted)[LINKEDIN],
    link("https://www.linkedin.com/in/omkarch")[#text(font: mono, size: font-contact-val, weight: 450, fill: secondary)[linkedin.com/in/omkarch]],
    text(font: mono, size: font-contact-key, weight: 500, fill: muted)[TELEGRAM],
    link("https://t.me/gotenksIN")[#text(font: mono, size: font-contact-val, weight: 450, fill: secondary)[t.me/gotenksIN]],
  ),
)
#v(12pt)
#line(length: 100%, stroke: 1.1pt + ink)

#let section(index, title, body) = block(
  width: 100%,
  above: 21pt,
  [
    #text(font: mono, size: font-section-index, weight: 600, fill: highlight)[#index]
    #h(6pt)
    #text(size: font-section-title, weight: 650, tracking: 0.08em, fill: ink)[#upper(title)]
    #v(5.5pt)
    #grid(
      columns: (30pt, 1fr),
      line(length: 100%, stroke: 1.3pt + highlight),
      line(length: 100%, stroke: 0.5pt + rule),
    )
    #v(10.5pt)
    #body
  ],
)

#let entry(title, role: none, subline: none, date: none, url: none, body: none) = block(
  width: 100%,
  below: 15pt,
  [
    #let left = [
      #if url != none [
        #link(url)[#text(size: font-entry-title, weight: 600, tracking: 0.005em, fill: ink)[#title]#h(3pt)#ext-arrow]
      ] else [
        #text(size: font-entry-title, weight: 600, tracking: 0.005em, fill: ink)[#title]
      ]
      #if role != none [
        #text(size: font-entry-role, weight: 440, fill: muted)[#h(5pt)·#h(5pt)]
        #text(size: font-entry-role, weight: 460, fill: secondary)[#role]
      ]
    ]
    #left #if date != none [#h(1fr) #box(text(size: font-entry-date, weight: 460, fill: muted, features: ("tnum",))[#date])]
    #if subline != none [
      #v(5pt)
      #text(size: font-entry-role, weight: 450, fill: secondary)[#subline]
    ]
    #if body != none [
      #v(7pt)
      #body
    ]
  ],
)

#section("01", "Technical Skills", [
  #grid(
    columns: (120pt, 1fr),
    column-gutter: 14pt,
    row-gutter: 7pt,
    text(size: font-entry-role, weight: 580, fill: secondary)[Languages],
    [TypeScript, Python, C, C++, Java, Kotlin, Bash],
    text(size: font-entry-role, weight: 580, fill: secondary)[Tools & Platforms],
    [AOSP, Bun, bwrap, Pydantic, FFmpeg, Git, GitHub Actions, Docker, systemd],
  )
])

#section("02", "Projects", [
  #entry(
    "OmkarSWE bench",
    role: "TypeScript · Bun · bwrap · oxc-parser",
    date: "2026",
    url: "https://github.com/gotenksIN/omkar-swe-bench",
    body: [
      - Built an OpenCode benchmark running 37 tasks (coder, reviewer, pair) across 421 sandboxed `bwrap` trials.
      - Graded outputs via behavioral probes, AST checks, Git invariants, and trace verification (`LSAS`/`ACI`).
    ],
  )
  #entry(
    "OpenCode Agent Plugins",
    role: "TypeScript · Bun · Gemini API · OpenAI API",
    date: "2026",
    body: [
      - #link("https://github.com/gotenksIN/opencode-websearch-addons")[`opencode-websearch-addons`#h(2.5pt)#ext-arrow] — OpenAI/Gemini search with SSE citation passages and fallback.
      - #link("https://github.com/gotenksIN/opencode-commit-guard")[`opencode-commit-guard`#h(2.5pt)#ext-arrow] — Pre-execution `git commit` guard enforcing message and signing baselines.
    ],
  )
  #entry(
    "Video Subtitler",
    role: "Python · Gemini API · FFmpeg · Pydantic",
    date: "2026",
    url: "https://github.com/gotenksIN/video-subtitler",
    body: [
      - Built a four-pass CLI generating English WebVTT subtitles with parallel grounding and Pydantic.
      - Added 7-worker chunking, `[boundary ± 10s]` audio repair, `fcntl.flock` retries, and atomic~writes.
    ],
  )
  #entry(
    "Telegram Translator",
    role: "Python · Gemini API · Pydantic · systemd",
    date: "2026",
    url: "https://github.com/gotenksIN/telegram-translator",
    body: [
      - Built a bot translating replies and X, YouTube (`yt-dlp`), and OpenGraph previews via Gemini JSON.
      - Enforced pinned-IP SSRF checks, sliding-window rate limits, concurrency caps, and `512M` `systemd` limits.
    ],
  )
])

#section("03", "Experience", [
  #entry(
    "Multiways",
    role: "Android Developer",
    date: "Nov 2023 – Oct 2025",
    url: "https://multiways.io/",
    body: [
      - Brought up the Daria Bond device on Android~14 and led kernel and device-tree upgrades to Android~15.
      - Resolved framework bugs and CTS/VTS release blockers while maintaining build, OTA, and CI pipelines.
    ],
  )
  #entry(
    "PearTree",
    role: "Android Developer",
    date: "Aug 2023 – Oct 2023",
    url: "https://peartree.to/",
    body: [
      - Ported ParallelSpace multi-profile app isolation to GrapheneOS.
      - Researched per-app VM isolation using `crosvm` on Google Pixel devices.
    ],
  )
  #entry(
    "Murena",
    role: "Android Embedded Engineer",
    date: "Oct 2022 – Apr 2023",
    url: "https://murena.com/",
    body: [
      - Upgraded Pixel 4/4 XL/5 to Android~12, maintained Galaxy S8/S9 device trees, and wrote platform tests.
    ],
  )
  #entry(
    "Teracube",
    role: "AOSP Development SDE Intern",
    date: "Jun 2022 – Sep 2022",
    url: "https://myteracube.com/",
    body: [
      - Brought up the Teracube 2e device on Android~12 and maintained LineageOS device trees.
    ],
  )
  #entry(
    "AOSPA (Paranoid Android)",
    role: "Software Engineering Lead (Open Source)",
    date: "Nov 2020 – Present",
    url: "https://aospa.co/",
    body: [
      - Lead Qualcomm common trees and framework patches, reviewing AOSP/CLO merges and releases.
      - Maintain Nothing Phone (2) and POCO F5 on CLO, and contribute regularly to LineageOS.
    ],
  )
])

#section("04", "Education", [
  #entry(
    "Indira Gandhi National Open University (IGNOU)",
    subline: "Bachelor of Computer Applications (BCA)",
    date: "Jul 2024 – Expected 2027",
  )
])

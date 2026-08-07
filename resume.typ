#let accent = rgb("262f99")
#let ink = rgb("131a28")
#let muted = rgb("5d5d5d")
#let divider = rgb("d1d5db")

#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 1.25cm),
)
#set text(font: "Manrope", size: 9.7pt, fill: ink)
#set par(leading: 0.68em, spacing: 0pt)
#set block(spacing: 0pt)
#set list(indent: 0pt, body-indent: 0.55em, spacing: 0.6em)

// --- HEADER BLOCK ---
#block(
  width: 100%,
  below: 1.35em,
  [
    #text(size: 28pt, fill: accent)[Omkar]#text(size: 28pt, weight: "bold", tracking: 0.0038em)[ Chandorkar]
    #v(12pt)
    #grid(
      columns: (auto, auto, auto, auto),
      column-gutter: 11pt,
      text(size: 9.2pt, fill: muted)[
        #link("https://github.com/gotenksIN")[
          #text(font: "Font Awesome 7 Brands", size: 9.2pt)[\u{f09b}] #h(2pt)gotenksIN
        ]
      ],
      text(size: 9.2pt, fill: muted)[
        #link("https://t.me/gotenksIN")[
          #text(font: "Font Awesome 7 Brands", size: 9.2pt)[\u{f2c6}] #h(2pt)\@gotenksIN
        ]
      ],
      text(size: 9.2pt, fill: muted)[
        #link("mailto:omkar0926@gmail.com")[
          #text(font: "Font Awesome 7 Free", size: 9.2pt)[\u{f0e0}] #h(2pt)omkar0926\@gmail.com
        ]
      ],
      text(size: 9.2pt, fill: muted)[
        #link("https://www.linkedin.com/in/omkarch")[
          #text(font: "Font Awesome 7 Brands", size: 9.2pt)[\u{f08c}] #h(2pt)Omkar Chandorkar
        ]
      ],
    )
  ]
)

// --- UNIFORM LAYOUT HELPER FUNCTIONS ---

// Unified section block controller for ALL 3 sections
#let section-block(title, body) = block(
  width: 100%,
  above: 18pt,
  below: 0pt,
  [
    #grid(
      columns: (auto, 1fr),
      column-gutter: 6.68pt,
      align: bottom,
      text(size: 13.5pt, weight: "bold", fill: accent, title),
      line(length: 100%, stroke: 0.6pt + divider),
    )
    #v(11pt)
    #body
  ]
)

// Unified entry block controller for ALL entries
#let github-icon = text(font: "Font Awesome 7 Brands", size: 10pt, fill: muted)[\u{f09b}]
#let browser-icon = text(font: "Font Awesome 7 Free", size: 9.5pt, fill: muted)[\u{f045}]

#let entry-block(
  title: none,
  destination: none,
  destinations: (),
  link-type: "github",
  subtitle: none,
  body: none,
  title-size: 10.8pt,
  body-size: 9.7pt,
) = block(
  width: 100%,
  below: 13pt,
  [
    #if title != none [
      #let dests = if destinations.len() > 0 { destinations } else if destination != none { (destination,) } else { () }
      #text(size: title-size, weight: "bold")[#title]
      #if dests.len() > 0 [
        #text(size: title-size, weight: "bold", fill: muted)[ : ]#h(2pt)
        #let icon = if link-type == "github" { github-icon } else { browser-icon }
        #let icon-links = dests.map(url => link(url)[#icon])
        #icon-links.join(h(7pt))
      ]
      #v(6.5pt)
    ]
    #if subtitle != none [
      #text(size: 9.2pt, fill: muted)[#subtitle]
      #v(6.5pt)
    ]
    #if body != none [
      #text(size: body-size)[#body]
    ]
  ]
)

// --- PROJECTS BLOCK ---
#section-block("Projects", [
  #entry-block(
    title: "Video Subtitler",
    destination: "https://github.com/gotenksIN/video-subtitler",
    link-type: "github",
    title-size: 11.9pt,
    body-size: 10.7pt,
    body: [
      - High-performance Gemini CLI generating syllable-accurate English VTT subtitles via parallel processing.
      - Implemented stream-chunking with codec-aware overlap context to bypass API payload limits and preserve boundary continuity across clips.
      - Built automated timestamp stitching with cue-overlap healing and a secondary global LLM pass for full-script context, grammar, and character refinement.
    ],
  )

  #entry-block(
    title: "OpenCode Agent Plugins",
    destinations: (
      "https://github.com/gotenksIN/opencode-websearch-cited-fork",
      "https://github.com/gotenksIN/opencode2-goal-plugin",
    ),
    link-type: "github",
    title-size: 11.9pt,
    body-size: 10.7pt,
    body: [
      - `opencode-websearch-cited-fork`: Grounded web search with inline citations and sources list.
      - `opencode2-goal-plugin`: Persistent goals, progress tracking, evidence capture, and auto-continuation.
    ],
  )

  #entry-block(
    title: "Pi Extensions",
    destination: "https://github.com/gotenksIN/pi-extensions",
    link-type: "github",
    title-size: 11.9pt,
    body-size: 10.7pt,
    body: [
      - `bwrap-sandbox`: Added a Bubblewrap security boundary and approval gate for Bash and file tools.
      - `websearch`: Added grounded web search with citations and provider fallback.
      - Built custom subagents with specialized capabilities, isolated tool access, and agent rules for autonomous task orchestration.
    ],
  )
])

// --- EXPERIENCE BLOCK ---
#section-block("Experience", [
  #entry-block(
    title: "MULTIWAYS",
    destination: "https://multiways.io/",
    link-type: "browser",
    subtitle: "Android Developer | Nov 2023 - Oct 2025",
    body: [
      - Brought up Daria Bond for Android 14 and Android 15.
      - Resolved user-reported bugs as needed.
      - Fixed xTS issues for Android 14 and Android 15 releases.
      - Fixed Android framework-related bugs.
    ],
  )

  #entry-block(
    title: "PearTree",
    destination: "https://peartree.to/",
    link-type: "browser",
    subtitle: "Android Developer | Aug 2023 - Oct 2023",
    body: [
      - Ported ParallelSpace functionality to GrapheneOS.
      - Researched per-app VM isolation using `crosvm` on Google Pixel devices.
    ],
  )

  #entry-block(
    title: "Murena",
    destination: "https://murena.com/",
    link-type: "browser",
    subtitle: "Android Embedded Engineer | Oct 2022 - Apr 2023",
    body: [
      - Upgraded Pixel 4 / 4 XL / 5 to Android 12, maintained Samsung S8 / S9 device trees, and authored comprehensive test cases.
    ],
  )

  #entry-block(
    title: "Teracube",
    destination: "https://myteracube.com/",
    link-type: "browser",
    subtitle: "AOSP Development SDE Intern | Jun 2022 - Sep 2022",
    body: [
      - Brought up Teracube 2e to Android 12 and maintained LineageOS device trees.
    ],
  )

  #entry-block(
    title: "AOSPA (Paranoid Android)",
    destination: "https://aospa.co/",
    link-type: "browser",
    subtitle: "Software Engineering Lead | Nov 2020 - Present",
    body: [
      - Maintain Qualcomm framework additions, review and merge upstream AOSP branches, and maintain Nothing Phone (2) and POCO F5 on CLO AOSP.
      - Frequent contributor to LineageOS.
    ],
  )
])

// --- SKILLS BLOCK ---
#section-block("Skills", [
  #entry-block(
    body: [
      - *DevOps:* CI/CD automation, release workflows, containers, and build systems.
      - *AI Agent Tooling:* Agent plugins, tool orchestration, sandboxing, and workflow automation.
      - *AOSP:* Platform bring-up, framework debugging, and device trees.
      - *Linux Systems & Administration:* Comprehensive Linux desktop and system administration experience: Git, Bash, package managers, XDG/Wayland, systemd, security, and troubleshooting.
    ],
  )
])

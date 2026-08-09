#let accent = rgb("262f99")
#let ink = rgb("131a28")
#let muted = rgb("5d5d5d")
#let divider = rgb("d1d5db")

// --- CENTRAL TYPOGRAPHY CONFIGURATION (Scaled +10%) ---
#let font-header-name = 30.8pt
#let font-header-contact = 10.12pt
#let font-section-title = 14.85pt
#let font-entry-title = 11.88pt
#let font-subtitle = 10.12pt
#let font-body = 10.67pt
#let font-raw-scale = 1em

#set page(
  paper: "a4",
  margin: (x: 1.35cm, y: 1.1cm),
)
#set text(font: "Manrope", size: font-body, fill: ink)
#show raw: set text(font: "JetBrains Mono", size: font-raw-scale)
#set par(leading: 0.68em, spacing: 0pt)
#set block(spacing: 0pt)
#set list(indent: 0pt, body-indent: 0.55em, spacing: 0.55em)

// --- HEADER BLOCK ---
#block(
  width: 100%,
  below: 1.25em,
  [
    #text(size: font-header-name, weight: "bold")[#text(fill: accent)[Omkar]#text(tracking: 0.0038em)[ Chandorkar]]
    #v(10pt)
    #grid(
      columns: (auto, auto, auto, auto),
      column-gutter: 11pt,
      text(size: font-header-contact, fill: muted)[
        #link("https://github.com/gotenksIN")[
          #text(font: "Font Awesome 7 Brands", size: font-header-contact)[\u{f09b}] #h(2pt)gotenksIN
        ]
      ],
      text(size: font-header-contact, fill: muted)[
        #link("https://t.me/gotenksIN")[
          #text(font: "Font Awesome 7 Brands", size: font-header-contact)[\u{f2c6}] #h(2pt)\@gotenksIN
        ]
      ],
      text(size: font-header-contact, fill: muted)[
        #link("mailto:omkar0926@gmail.com")[
          #text(font: "Font Awesome 7 Free", size: font-header-contact)[\u{f0e0}] #h(2pt)omkar0926\@gmail.com
        ]
      ],
      text(size: font-header-contact, fill: muted)[
        #link("https://www.linkedin.com/in/omkarch")[
          #text(font: "Font Awesome 7 Brands", size: font-header-contact)[\u{f08c}] #h(2pt)Omkar Chandorkar
        ]
      ],
    )
  ]
)

// --- UNIFORM LAYOUT HELPER FUNCTIONS ---

// Unified section block controller for ALL 3 sections
#let section-block(title, body) = block(
  width: 100%,
  above: 17pt,
  below: 0pt,
  [
    #grid(
      columns: (auto, 1fr),
      column-gutter: 6.68pt,
      align: bottom,
      text(size: font-section-title, weight: "bold", fill: accent, title),
      line(length: 100%, stroke: 0.6pt + divider),
    )
    #v(9.5pt)
    #body
  ]
)

// Unified entry block controller for ALL entries
#let github-icon = text(font: "Font Awesome 7 Brands", size: 10.5pt, fill: muted)[\u{f09b}]
#let browser-icon = text(font: "Font Awesome 7 Free", size: 10pt, fill: muted)[\u{f045}]

#let entry-block(
  title: none,
  destination: none,
  destinations: (),
  link-type: "github",
  subtitle: none,
  body: none,
  title-size: font-entry-title,
  body-size: font-body,
) = block(
  width: 100%,
  below: 11pt,
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
      #v(5pt)
    ]
    #if subtitle != none [
      #text(size: font-subtitle, fill: muted)[#subtitle]
      #v(5pt)
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
    body: [
      - Developed a Gemini CLI tool that generates syllable-accurate English VTT subtitles using parallel processing.
      - Implemented stream chunking with codec-aware overlap context to prevent API payload limits and preserve boundary continuity across clips.
      - Built automated timestamp stitching with cue-overlap healing and a secondary global LLM pass for full-script context, grammar, and character refinement.
    ],
  )

  #entry-block(
    title: "OpenCode Agent Plugins",
    destinations: (
      "https://github.com/gotenksIN/opencode-websearch-addons",
      "https://github.com/gotenksIN/opencode2-goal-plugin",
    ),
    link-type: "github",
    body: [
      - `opencode-websearch-addons`: Grounded web search using direct Google Gemini and OpenAI API integrations, with provider fallback.
      - `opencode2-goal-plugin`: Persistent goals, progress tracking, evidence capture, and auto-continuation.
    ],
  )

  #entry-block(
    title: "Pi Extensions",
    destination: "https://github.com/gotenksIN/pi-extensions",
    link-type: "github",
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
      - Brought up the Daria Bond device for Android 14 and Android 15.
      - Triaged and resolved user-reported bugs.
      - Resolved xTS test failures for Android 14 and Android 15 releases.
      - Fixed Android framework bugs.
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
      - Upgraded Pixel 4, 4 XL, and 5 devices to Android 12, maintained Samsung S8 and S9 device trees, and authored test cases.
    ],
  )

  #entry-block(
    title: "Teracube",
    destination: "https://myteracube.com/",
    link-type: "browser",
    subtitle: "AOSP Development SDE Intern | Jun 2022 - Sep 2022",
    body: [
      - Brought up the Teracube 2e device to Android 12 and maintained LineageOS device trees.
    ],
  )

  #entry-block(
    title: "AOSPA (Paranoid Android)",
    destination: "https://aospa.co/",
    link-type: "browser",
    subtitle: "Software Engineering Lead | Nov 2020 - Present",
    body: [
      - Maintain Qualcomm framework additions, review and merge upstream AOSP branches, and support Nothing Phone (2) and POCO F5 on CLO, Qualcomm's fork of AOSP.
      - Contribute regularly to LineageOS.
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
      - *Linux Systems & Administration:* System administration and desktop environment configuration using Bash scripting, systemd service management, package managers, security hardening, diagnostic troubleshooting, and an understanding of Wayland protocols and freedesktop standards.
    ],
  )
])

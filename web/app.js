const root = document.documentElement;
const toggleBtn = document.querySelector("[data-theme-toggle]");
const toggleLabel = document.querySelector("[data-theme-label]");
const toggleIcon = document.querySelector("[data-theme-icon]");

if (toggleBtn && toggleLabel && toggleIcon) {
  const darkQuery = window.matchMedia("(prefers-color-scheme: dark)");
  const labels = { system: "System", light: "Light", dark: "Dark" };
  const icons = { system: "#i-monitor", light: "#i-sun", dark: "#i-moon" };
  const themeColors = [...document.querySelectorAll('meta[name="theme-color"]')].map((meta) => ({
    meta,
    original: meta.getAttribute("content"),
  }));
  const colors = { light: "#fafafa", dark: "#09090b" };

  const currentMode = () => {
    const t = root.dataset.theme;
    return t === "light" || t === "dark" ? t : "system";
  };

  // Step away from System to the theme opposite the OS, so the first click always changes the page.
  const cycle = () =>
    darkQuery.matches ? ["system", "light", "dark"] : ["system", "dark", "light"];

  const applyMode = (mode) => {
    if (mode === "system") {
      delete root.dataset.theme;
      try {
        localStorage.removeItem("theme");
      } catch {}
    } else {
      root.dataset.theme = mode;
      try {
        localStorage.setItem("theme", mode);
      } catch {}
    }
    // Keep the browser toolbar in step with an explicit choice; System restores the media-based colors.
    for (const { meta, original } of themeColors) {
      meta.setAttribute("content", mode === "system" ? original : colors[mode]);
    }
    toggleLabel.textContent = labels[mode];
    toggleIcon.setAttribute("href", icons[mode]);
    toggleBtn.setAttribute("aria-label", `Color theme: ${labels[mode]}. Click to switch.`);
  };

  applyMode(currentMode());
  toggleBtn.addEventListener("click", () => {
    const modes = cycle();
    applyMode(modes[(modes.indexOf(currentMode()) + 1) % modes.length]);
  });
}

const navLinks = [...document.querySelectorAll(".site-nav a[href^='#']")];
const sections = navLinks
  .map((link) => document.querySelector(link.getAttribute("href")))
  .filter(Boolean);

if (sections.length === navLinks.length && sections.length > 0) {
  const ACTIVE_OFFSET = 120;
  const BOTTOM_SLACK = 24;
  let ticking = false;

  const setActive = (section) => {
    for (const link of navLinks) {
      const active = section !== null && link.getAttribute("href") === `#${section.id}`;
      link.classList.toggle("is-active", active);
      if (active) {
        link.setAttribute("aria-current", "location");
      } else {
        link.removeAttribute("aria-current");
      }
    }
  };

  const update = () => {
    ticking = false;
    if (sections[0].getBoundingClientRect().top > ACTIVE_OFFSET) {
      setActive(null);
      return;
    }
    const doc = document.documentElement;
    if (window.innerHeight + window.scrollY >= doc.scrollHeight - BOTTOM_SLACK) {
      setActive(sections[sections.length - 1]);
      return;
    }
    let current = sections[0];
    for (const section of sections) {
      if (section.getBoundingClientRect().top <= ACTIVE_OFFSET) current = section;
    }
    setActive(current);
  };

  const onScroll = () => {
    if (!ticking) {
      ticking = true;
      window.requestAnimationFrame(update);
    }
  };

  window.addEventListener("scroll", onScroll, { passive: true });
  window.addEventListener("resize", onScroll, { passive: true });
  update();
}

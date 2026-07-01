const SHELL_LABELS = {
  "git-bash": "Git Bash",
  zsh: "zsh",
  powershell: "PowerShell",
  bash: "bash",
  routeros: "RouterOS",
  "claude-code": "Claude Code",
  codex: "Codex CLI",
  grok: "Grok CLI"
};

function esc(s) {
  return String(s)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

function useLocalPaths() {
  return location.protocol === "file:"
    || location.hostname === "localhost"
    || location.hostname === "127.0.0.1";
}

function courseUrl(course, page) {
  const base = course.path.replace(/\/$/, "");
  const file = page === "trainer" ? "index.html" : `${page}.html`;
  return `${base}/${file}`;
}

function pagesUrl(course, page) {
  if (!course.pages_url) return null;
  const root = course.pages_url.replace(/\/$/, "/");
  const file = page === "trainer" ? "" : page + ".html";
  return root + file;
}

function linkUrl(course, page) {
  if (useLocalPaths()) return courseUrl(course, page);
  return pagesUrl(course, page) || courseUrl(course, page);
}

function renderCard(course) {
  const shell = SHELL_LABELS[course.shell] || course.shell;
  const pages = course.pages || {};
  const local = useLocalPaths();

  const links = [
    `<a class="btn btn-primary" href="${esc(linkUrl(course, "trainer"))}"${local ? "" : ' target="_blank" rel="noopener"'}>Тренажер</a>`
  ];

  if (pages.course) {
    links.push(`<a class="btn" href="${esc(linkUrl(course, "course"))}"${local ? "" : ' target="_blank" rel="noopener"'}>Уроки</a>`);
  }
  if (pages.cheatsheet) {
    links.push(`<a class="btn" href="${esc(linkUrl(course, "cheatsheet"))}"${local ? "" : ' target="_blank" rel="noopener"'}>Шпаргалка</a>`);
  }
  if (course.has_quiz || pages.quiz) {
    links.push(`<a class="btn" href="${esc(linkUrl(course, "quiz"))}"${local ? "" : ' target="_blank" rel="noopener"'}>Quiz</a>`);
  }

  const pagesLink = course.pages_url
    ? `<a class="card-pages" href="${esc(course.pages_url)}" target="_blank" rel="noopener">GitHub Pages ↗</a>`
    : "";

  const statusBadge = course.status === "active" || !course.status
    ? ""
    : `<span class="badge badge-muted">${esc(course.status)}</span>`;

  const newBadge = course.id === "grok-cli" ? `<span class="badge badge-new">новий</span>` : "";

  return `
    <article class="card" data-id="${esc(course.id)}">
      <div class="card-head">
        <h2>${esc(course.name)}</h2>
        <div class="badges">
          <span class="badge badge-shell">${esc(shell)}</span>
          ${newBadge}${statusBadge}
        </div>
      </div>
      <p class="card-desc">${esc(course.description || "")}</p>
      <div class="card-actions">${links.join("")}</div>
      ${pagesLink}
    </article>
  `;
}

async function initPortal() {
  const grid = document.getElementById("courseGrid");
  const countEl = document.getElementById("courseCount");
  const errEl = document.getElementById("loadError");

  try {
    const res = await fetch("courses.json");
    if (!res.ok) throw new Error(`courses.json — ${res.status}`);
    const data = await res.json();
    const courses = data.courses || [];

    grid.innerHTML = courses.map(renderCard).join("");
    countEl.textContent = `${courses.length} курсів`;

    document.getElementById("year").textContent = new Date().getFullYear();
  } catch (e) {
    errEl.hidden = false;
    errEl.textContent = `Не вдалося завантажити каталог: ${e.message}. Відкрий через локальний сервер або з кореня cli-course-hub.`;
    grid.innerHTML = "";
  }
}

initPortal();

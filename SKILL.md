---
name: cli-course-hub
description: >
  Central hub for interactive CLI command courses: manage existing courses,
  create new ones, deploy to GitHub Pages. HTML terminal emulator + Ukrainian
  Markdown lessons + cheatsheet. Use when working in cli-course-hub, creating
  command trainers, terminal tutorials, shell emulators, or says "створи курс
  команд", "тренажер terminal", "навчальний HTML курс CLI", "/cli-course-trainer".
  Always read this skill first — do not improvise structure from scratch.
metadata:
  short-description: "Hub for CLI course trainers"
---

# CLI Course Hub

Центральне робоче середовище для **інтерактивних курсів команд** (HTML-тренажер + Markdown-уроки + шпаргалка + GitHub Pages).

Корінь hub: `/Users/szubar/Projects/cli-course-hub`

## Перший запуск (обов'язково)

Якщо `courses/git/index.html` відсутній — виконай:

```bash
bash setup.sh
bash scripts/verify.sh
```

Це копіює 7 курсів з `~/Projects/` у `courses/` (кожен зберігає власний `.git`).

## Каталог курсів

Читай `courses.json` — там `id`, `path`, `repo`, `pages_url`, `format`.

| id | Тема | Шлях |
|----|------|------|
| git | Git / Git Bash | `courses/git` |
| mac-terminal | macOS zsh | `courses/mac-terminal` |
| windows-terminal | Windows PS/CMD/WSL | `courses/windows-terminal` |
| raspberry-pi | Raspberry Pi bash | `courses/raspberry-pi` |
| mikrotik | MikroTik RouterOS | `courses/mikrotik` |
| claude-code | Claude Code slash | `courses/claude-code` |
| codex-cli | Codex CLI | `courses/codex-cli` |
| grok-cli | Grok CLI / TUI | `courses/grok-cli` |

Референси: `references/` (project-structure, lesson-format, emulator-patterns, github-deploy, task-template).

Завдання: `_tasks/` (історичні task-файли).

## Коли застосовувати

- Редагування існуючого курсу → `cd courses/<id>/`
- Новий курс → створи `courses/<new-id>/`, додай запис у `courses.json`
- Деплой → окремий git у папці курсу (див. `references/github-deploy.md`)
- Референс UI/патернів → `courses/git` або `courses/mac-terminal`

## Workflow нового курсу

### Фаза 0 — Розвідка

1. Прочитай `_tasks/task_*.md` або створи новий за `references/task-template.md`
2. Обери референс з `courses.json` (найближчий shell/format)
3. Прочитай `references/project-structure.md`, `emulator-patterns.md`

### Фаза 1 — Markdown

Створи `<course-slug>/` з README, `01-…md` … `10-…md`, `cheatsheet.md`.
Формат: `references/lesson-format.md`.

### Фаза 2 — HTML-тренажер

Мінімум: `index.html`, `trainer.js` (або inline), `course.html`, `cheatsheet.html`.

```javascript
const MODULES = {
  moduleId: {
    id: "moduleId",
    title: "N. Назва",
    intro: "Сценарій.",
    commands: ["exact command"]
  }
};
```

- In-memory SIM, не реальний shell
- UK_HINTS українською
- Небезпечні команди → `danger`
- Обов'язкова фраза про мету курсу в кожному уроці

### Фаза 3 — Квіз (опційно)

`quiz_parts/gift/*.txt` + `scripts/build_quiz_html.py` → `quiz.html`

### Фаза 4 — Git і Pages

У папці курсу (`courses/<id>/`):

```bash
git add … && git commit -m "…" && git push
gh api repos/StsZu/<repo>/pages …
```

Деталі: `references/github-deploy.md`.

### Фаза 5 — Оновити hub

Додай запис у `courses.json` і рядок у кореневий `README.md`.

## Робота з існуючим курсом

1. `cd courses/<id>`
2. Локально: `open index.html`
3. Push змін у **репозиторій курсу** (не hub)
4. Перевір Pages URL з `courses.json`

## Чекліст якості

- [ ] Команди з task є в markdown і MODULES
- [ ] UK_HINTS для більшості commands[]
- [ ] Небезпечні команди з попередженням
- [ ] Nav: index / course / cheatsheet
- [ ] Pages HTTP 200
- [ ] Обов'язкова фраза про мету курсу

## Типові помилки

| Помилка | Виправлення |
|---------|-------------|
| `print()` відкриває діалог друку | Локальна `function print(html, cls)` у trainer.js |
| Команди не зараховуються | Точний match у `commands[]` |
| course.html 404 на Pages | Відносні шляхи fetch від кореня репо |
| gh Pages POST fail | JSON `--input -`, не bracket syntax |

## Комунікація

Після завершення надай: локальний шлях, GitHub repo, Pages URLs (trainer/course/cheatsheet), `open index.html`.

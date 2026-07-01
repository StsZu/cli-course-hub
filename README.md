# CLI Course Hub

Центральна папка для керування інтерактивними курсами команд: HTML-тренажер + Markdown-уроки + шпаргалка + GitHub Pages.

## ⚠️ Спочатку — один раз у Terminal.app

Курси **не копіюються автоматично** при створенні hub. Потрібна одна команда:

```bash
cd /Users/szubar/Projects/cli-course-hub
bash setup.sh
bash scripts/verify.sh
```

Має з'явитися 7 папок у `courses/` з `index.html` у кожній.  
Якщо `rsync` недоступний: `python3 scripts/setup.py`

Після цього — **File → Open Folder → cli-course-hub** у Cursor.

### Архів оригіналів (після setup)

Коли hub-копії перевірені, перенеси старі папки з `~/Projects/` у backup:

```bash
bash scripts/archive-originals.sh
```

Це створить `~/Projects/_archive/` і перемістить туди 7 оригінальних курсів.  
**Увага:** закрий workspace `git-course-emulator` перед архівацією (відкрий `cli-course-hub`).

## Портал (всі курси з однієї сторінки)

```bash
open index.html
```

Картки курсів завантажуються з `courses.json` — кнопки «Тренажер», «Уроки», «Шпаргалка», «Quiz», посилання на GitHub Pages.

## Швидкий старт (після setup)

```bash
open index.html                        # портал
open courses/mac-terminal/index.html   # один курс
```

Агент читає `SKILL.md` і `AGENTS.md`.

## GitHub

- Репозиторій: https://github.com/StsZu/cli-course-hub
- Портал (Pages): https://stszu.github.io/cli-course-hub/

На Pages кнопки ведуть на окремі репо курсів; локально — на `courses/<id>/`.

## Каталог курсів

| ID | Назва | Локально | GitHub Pages |
|----|-------|----------|--------------|
| git | Git / Git Bash | `courses/git/` | [git-course-emulator](https://stszu.github.io/git-course-emulator/) |
| mac-terminal | macOS zsh | `courses/mac-terminal/` | [mac-terminal-course](https://stszu.github.io/mac-terminal-course/) |
| windows-terminal | Windows PS/CMD/WSL | `courses/windows-terminal/` | [windows-cli-course](https://stszu.github.io/windows-cli-course/) |
| raspberry-pi | Raspberry Pi 5 | `courses/raspberry-pi/` | [raspberry-pi-terminal-course](https://stszu.github.io/raspberry-pi-terminal-course/) |
| mikrotik | MikroTik RouterOS | `courses/mikrotik/` | [mikrotik-course-CLI-tutorial](https://stszu.github.io/mikrotik-course-CLI-tutorial/) |
| claude-code | Claude Code | `courses/claude-code/` | [claude-cli-tutorial-command](https://stszu.github.io/claude-cli-tutorial-command/) |
| codex-cli | Codex CLI | `courses/codex-cli/` | [codex-cli-tutorial-5-emulator](https://stszu.github.io/codex-cli-tutorial-5-emulator/) |
| grok-cli | Grok CLI | `courses/grok-cli/` | [grok-cli-course](https://stszu.github.io/grok-cli-course/) |

Повний manifest: `courses.json`.

## Для агента

- **SKILL.md** — workflow створення/редагування курсів
- **references/** — формат уроків, патерни емулятора, деплой
- **_tasks/** — збережені завдання (task-файли)

## Новий курс

1. Створи task у `_tasks/task_YYYY-MM-DD.md` (шаблон: `references/task-template.md`)
2. Скажи агенту тему — він створить `courses/<new-id>/`
3. Додасть запис у `courses.json`

## Принцип усіх курсів

> Головна мета — не вивчити всі команди, а навчитися швидко знаходити потрібну команду, розуміти її ризик і застосовувати її в реальному сценарії.

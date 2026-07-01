# AGENTS.md — cli-course-hub

Це **центральний harness** для курсів інтерактивних CLI-тренажерів.

## Перший крок у новій сесії

1. Прочитай `SKILL.md`
2. Перевір наявність курсів: `bash scripts/verify.sh`
3. Якщо курси відсутні: `bash setup.sh`

## Структура

```
cli-course-hub/
├── SKILL.md           # Інструкції для агента (головний)
├── courses.json       # Каталог курсів
├── courses/           # 7 копій проєктів (кожен з власним .git)
├── references/        # Шаблони формату, деплой, емулятор
├── _tasks/            # Task-файли для нових/існуючих курсів
├── scripts/           # verify.sh, setup helpers
└── setup.sh           # Копіювання курсів з ~/Projects/
```

## Правила

- **Новий курс** → `courses/<id>/` + запис у `courses.json`
- **Деплой** → git push з папки курсу, не з кореня hub
- **Референс** → `courses/git` (Git Bash) або `courses/mac-terminal` (trainer.js)
- **Мова уроків** → українська
- **Емулятор** → in-memory SIM, без реального shell

## GitHub

Користувач: `StsZu`. Кожен курс — окремий репозиторій (див. `courses.json`).

## Тригери

- «Створи курс …»
- «Виправ тренажер …»
- «Задеплой на Pages»
- `/cli-course-trainer`

# Структура проєкту CLI-курсу

## Цільовий deliverable

```
<project-root>/
├── README.md                 # Огляд + посилання на GitHub Pages
├── index.html                # Інтерактивний тренажер (головна сторінка)
├── trainer.js                # Логіка емулятора (або inline у index.html)
├── course.html               # Переглядач Markdown-уроків
├── cheatsheet.html           # Шпаргалка (завантажує cheatsheet.md)
├── .gitignore                # .DS_Store, task_*.md
├── <course-slug>/            # Markdown-курс
│   ├── README.md
│   ├── 01-<topic>.md … 10-<topic>.md
│   └── cheatsheet.md
├── quiz.html                 # (опційно) квіз з GIFT
├── quiz_parts/               # (опційно) GIFT-файли для Moodle
│   ├── gift/*.txt
│   └── README.md
└── scripts/
    └── build_quiz_html.py    # (опційно) збірка quiz.html
```

## Мінімальний набір (без квізу)

Обов'язково: `README.md`, `index.html`, `course.html`, `cheatsheet.html`, `<course-slug>/` з уроками.

## Навігація між сторінками

Усі HTML-файли мають однаковий `top-nav`:

```html
<nav class="top-nav">
  <a href="index.html" class="active">Тренажер</a>
  <a href="course.html">Уроки</a>
  <a href="cheatsheet.html">Шпаргалка</a>
  <!-- <a href="quiz.html">Quiz</a> — якщо є -->
</nav>
```

## README.md (корінь)

Має містити:
- Назву курсу та 1-2 речення опису
- Обов'язкову фразу про мету (див. `lesson-format.md`)
- `open index.html` для локального запуску
- Placeholder або реальне посилання GitHub Pages
- Таблицю файлів/модулів
- MIT або іншу ліцензію

## Іменування репозиторію GitHub

- kebab-case, описове: `mac-terminal-course`, `git-course-emulator`, `mikrotik-course-CLI-tutorial`
- GitHub Pages URL: `https://<user>.github.io/<repo-name>/`

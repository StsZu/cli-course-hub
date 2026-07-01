# Патерни інтерактивного емулятора

Референсні проєкти: `git-course-emulator`, `mac-terminal-course`.

## Архітектура

Рекомендовано розділити:
- `index.html` — розмітка, CSS, навігація
- `trainer.js` — логіка емулятора (MODULES, UK_HINTS, handleCommand)

Альтернатива: один `index.html` з inline `<script>` (як git-course-emulator).

## Обов'язкові UI-елементи

| Елемент | Призначення |
|---------|-------------|
| Sidebar: прогрес-бар | % виконаних команд у модулі |
| Sidebar: module-nav | Перемикання між модулями + % |
| Sidebar: cmd-list | Клік = виконати команду |
| Terminal output | Результат + українські підказки (жовтий текст) |
| Input row | Prompt + поле вводу |
| Кнопки | Режим тестування, Обрати сценарій, Скинути стан |

## MODULES — структура модуля

```javascript
const MODULES = {
  basics: {
    id: "basics",
    title: "1. Назва модуля",
    intro: "Короткий опис сценарію.",
    commands: ["pwd", "ls", "cd .."]  // точні рядки для чеклісту
  }
};
```

Модулі = сценарії з task-файлу (напр. «Я відкрив Terminal», «Я працюю з GitHub»).

## UK_HINTS

Об'єкт `{ "exact command": "Українська підказка" }`.
Ключі мають збігатися з рядками в `commands[]` для тестового режиму.

## State

```javascript
const state = {
  currentModule: "basics",
  history: [], histIdx: -1,
  triedByModule: Object.fromEntries(Object.keys(MODULES).map(k => [k, new Set()])),
  testMode: { active: false, queue: [], index: 0, correct: 0, wrong: 0 }
};
```

## SIM — симульоване середовище

Залежить від теми курсу. Приклади:

| Курс | SIM містить |
|------|-------------|
| Git | repo: files, staged, commits, branches, remote |
| Mac Terminal | user, host, cwd, ip, gateway, files, clipboard |
| MikroTik | router IP, RouterOS prompt, interfaces |

## handleCommand — принципи

1. **Емуляція, не реальне виконання** — без API, без shell
2. **Реалістичний вивід** — імітувати справжній terminal output
3. **Підказки** — `UK_HINTS[listed]` після кожної команди
4. **Прогрес** — `markTried()` лише для команд поточного модуля
5. **Попередження** — небезпечні команди (`rm -rf`, `sudo`, `curl | bash`) → `type: "danger"`
6. **Невідомі команди** — підказати команди зліва або `man`/`apropos`

## Prompt стилізація

| Платформа | Prompt / title bar |
|-----------|-------------------|
| Git Bash | `MINGW64 ~/project (main)` |
| macOS zsh | `user@MacBook-Pro folder %` |
| MikroTik SSH | `user@MikroTik>` |

## Клавіатура

- `↑`/`↓` — history
- `Tab` — автодоповнення з commands поточного модуля
- `Enter` у modal сценарію — підтвердити

## course.html — Markdown viewer

```javascript
fetch("course-slug/01-lesson.md")
  .then(r => r.text())
  .then(md => { content.innerHTML = marked.parse(md); });
```

CDN: `https://cdn.jsdelivr.net/npm/marked/marked.min.js`

## Дизайн

- Темна тема, monospace для terminal
- macOS: `--cyan`, `--green` prompt; Git Bash: `--orange` prompt
- Responsive: sidebar під terminal на mobile

## Тестовий режим

1. `buildTestQueue()` — зібрати `{cmd, hint}` з UK_HINTS по всіх модулях
2. Показати hint → користувач вводить команду
3. Порівняти з `q.cmd` (точний match або findListedCommand)

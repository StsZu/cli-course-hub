# Деплой на GitHub Pages

## Передумови

- `gh` CLI авторизований (`gh auth status`)
- Проєкт у цільовій папці з git

## Кроки (виконувати самому, не давати інструкції користувачу)

```bash
cd <project-root>
git init   # якщо ще немає
git add README.md index.html trainer.js course.html cheatsheet.html <course-slug>/ .gitignore
# + quiz.html, scripts/ якщо є
git commit -m "Add <course-name>: trainer, lessons, cheatsheet"
gh repo create <repo-name> --public --source=. --remote=origin \
  --description "<short description>" --push
```

## Увімкнення GitHub Pages

zsh ламає `source[branch]=` — використовуй JSON:

```bash
gh api repos/<user>/<repo-name>/pages -X POST --input - <<'EOF'
{
  "build_type": "legacy",
  "source": { "branch": "main", "path": "/" }
}
EOF
```

Якщо Pages вже існує — `-X PUT` замість `POST`.

## Перевірка

```bash
gh api repos/<user>/<repo-name>/pages --jq '.html_url, .status'
curl -sI "https://<user>.github.io/<repo-name>/index.html" | head -3
```

Чекати `status: built` і HTTP 200 (може зайняти 1–2 хв).

## Оновити README

Після деплою замінити placeholder на реальне посилання:

```markdown
GitHub Pages: https://<user>.github.io/<repo-name>/
```

## .gitignore

```
.DS_Store
task_*.md
```

Task-файли залишаються локально, не в репозиторії.

#!/usr/bin/env bash
# Копіює 7 CLI-курсів у courses/ + references + task-файли
set -euo pipefail

HUB="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$HUB/courses" "$HUB/references" "$HUB/_tasks" "$HUB/scripts"

RSYNC_EXCLUDE=(--exclude '.DS_Store' --exclude 'quiz_parts copy' --exclude 'quiz_parts copy.zip' --exclude 'quiz_parts copy/' --exclude 'node_modules')

copy_course() {
  local src="$1" dest="$2"
  if [ ! -d "$src" ]; then
    echo "ERROR: source not found: $src" >&2
    exit 1
  fi
  rsync -a "${RSYNC_EXCLUDE[@]}" "$src/" "$HUB/courses/$dest/"
  echo "OK: $dest ($(du -sh "$HUB/courses/$dest" | cut -f1))"
}

echo "=== cli-course-hub setup ==="
echo "Hub: $HUB"
echo ""

copy_course "/Users/szubar/Projects/git-course-emulator" "git"
copy_course "/Users/szubar/Projects/Mac_Terminal_course_CLI_tutorial" "mac-terminal"
copy_course "/Users/szubar/Projects/Windows_Terminal_course_CLI_tutorial" "windows-terminal"
copy_course "/Users/szubar/Projects/Raspberry-PI_Terminal_course_CLI_tutorial" "raspberry-pi"
copy_course "/Users/szubar/Projects/mikrotik-course-CLI-tutorial" "mikrotik"
copy_course "/Users/szubar/Projects/claude-cli-tutorial-command" "claude-code"
copy_course "/Users/szubar/Projects/codex-cli-tutorial-5-emulator" "codex-cli"

SKILL_REFS="/Users/szubar/.grok/skills/cli-course-trainer/references"
if [ -d "$SKILL_REFS" ]; then
  cp -R "$SKILL_REFS"/* "$HUB/references/"
  echo "OK: references (from skill)"
else
  echo "SKIP: skill references not found (hub references/ already present)"
fi

for f in /Users/szubar/Projects/Mac_Terminal_course_CLI_tutorial/task_*.md \
         /Users/szubar/Projects/Windows_Terminal_course_CLI_tutorial/task_*.md \
         /Users/szubar/Projects/Raspberry-PI_Terminal_course_CLI_tutorial/task_*.md \
         /Users/szubar/Projects/git-course-emulator/TASK_*.md; do
  [ -f "$f" ] && cp "$f" "$HUB/_tasks/" && echo "OK: _tasks/$(basename "$f")"
done

echo ""
echo "=== index.html check ==="
MISSING=0
for d in git mac-terminal windows-terminal raspberry-pi mikrotik claude-code codex-cli; do
  if [ -f "$HUB/courses/$d/index.html" ]; then
    echo "OK: courses/$d/index.html"
  else
    echo "MISSING: courses/$d/index.html"
    MISSING=$((MISSING + 1))
  fi
done

echo ""
if [ "$MISSING" -eq 0 ]; then
  echo "Setup complete."
  du -sh "$HUB/courses"/* 2>/dev/null || true
else
  echo "Setup finished with $MISSING missing course(s)."
  exit 1
fi

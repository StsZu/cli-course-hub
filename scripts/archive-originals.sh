#!/usr/bin/env bash
# Переносить оригінальні папки курсів з ~/Projects/ у ~/Projects/_archive/
set -euo pipefail

ARCHIVE="/Users/szubar/Projects/_archive"
mkdir -p "$ARCHIVE"

move_if_needed() {
  local src="$1" dest="$2"
  if [ ! -e "$src" ]; then
    echo "SKIP (немає джерела): $src"
    return 0
  fi
  if [ -e "$dest" ]; then
    echo "SKIP (вже в архіві): $dest"
    return 0
  fi
  mv "$src" "$dest"
  echo "OK: $src → $dest"
}

echo "=== archive originals → $ARCHIVE ==="
echo ""

move_if_needed "/Users/szubar/Projects/git-course-emulator" \
               "$ARCHIVE/git-course-emulator"
move_if_needed "/Users/szubar/Projects/Mac_Terminal_course_CLI_tutorial" \
               "$ARCHIVE/mac-terminal-course"
move_if_needed "/Users/szubar/Projects/Windows_Terminal_course_CLI_tutorial" \
               "$ARCHIVE/windows-cli-course"
move_if_needed "/Users/szubar/Projects/Raspberry-PI_Terminal_course_CLI_tutorial" \
               "$ARCHIVE/raspberry-pi-terminal-course"
move_if_needed "/Users/szubar/Projects/mikrotik-course-CLI-tutorial" \
               "$ARCHIVE/mikrotik-course-CLI-tutorial"
move_if_needed "/Users/szubar/Projects/claude-cli-tutorial-command" \
               "$ARCHIVE/claude-cli-tutorial-command"
move_if_needed "/Users/szubar/Projects/codex-cli-tutorial-5-emulator" \
               "$ARCHIVE/codex-cli-tutorial-5-emulator"

echo ""
echo "=== _archive ==="
ls -la "$ARCHIVE"

echo ""
echo "=== ~/Projects (курси мають бути лише в cli-course-hub) ==="
ls -la /Users/szubar/Projects/ | grep -E 'course|emulator|mikrotik|claude|codex|Terminal|_archive|cli-course' || true

echo ""
echo "Готово. Робочі копії: cli-course-hub/courses/"

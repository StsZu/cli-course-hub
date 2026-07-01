#!/usr/bin/env bash
set -euo pipefail

HUB="$(cd "$(dirname "$0")/.." && pwd)"
MISSING=0

echo "=== cli-course-hub verify ==="
echo "Hub: $HUB"
echo ""

for d in git mac-terminal windows-terminal raspberry-pi mikrotik claude-code codex-cli; do
  if [ -f "$HUB/courses/$d/index.html" ]; then
    echo "OK  courses/$d/index.html"
  else
    echo "MISS courses/$d/index.html"
    MISSING=$((MISSING + 1))
  fi
done

echo ""
if [ "$MISSING" -eq 0 ]; then
  echo "All courses present."
  du -sh "$HUB/courses"/* 2>/dev/null || true
  exit 0
else
  echo "$MISSING course(s) missing. Run: bash setup.sh"
  exit 1
fi

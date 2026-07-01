#!/usr/bin/env python3
"""Fallback setup: copy courses when bash/rsync unavailable."""
import shutil
from pathlib import Path

HUB = Path(__file__).resolve().parent.parent
EXCLUDE = {".DS_Store", "node_modules", "quiz_parts copy", "quiz_parts copy.zip"}

COURSES = [
    ("/Users/szubar/Projects/git-course-emulator", "git"),
    ("/Users/szubar/Projects/Mac_Terminal_course_CLI_tutorial", "mac-terminal"),
    ("/Users/szubar/Projects/Windows_Terminal_course_CLI_tutorial", "windows-terminal"),
    ("/Users/szubar/Projects/Raspberry-PI_Terminal_course_CLI_tutorial", "raspberry-pi"),
    ("/Users/szubar/Projects/mikrotik-course-CLI-tutorial", "mikrotik"),
    ("/Users/szubar/Projects/claude-cli-tutorial-command", "claude-code"),
    ("/Users/szubar/Projects/codex-cli-tutorial-5-emulator", "codex-cli"),
]


def ignore(_dir: str, names: list[str]) -> list[str]:
    return [n for n in names if n in EXCLUDE or n.startswith("quiz_parts copy")]


def main() -> int:
    (HUB / "courses").mkdir(parents=True, exist_ok=True)
    missing = 0
    for src, dest in COURSES:
        src_path = Path(src)
        dst_path = HUB / "courses" / dest
        if not src_path.is_dir():
            print(f"ERROR: source not found: {src}")
            return 1
        if dst_path.exists():
            shutil.rmtree(dst_path)
        shutil.copytree(src_path, dst_path, ignore=ignore)
        print(f"OK: {dest}")
    print("\n=== index.html check ===")
    for _, dest in COURSES:
        idx = HUB / "courses" / dest / "index.html"
        if idx.is_file():
            print(f"OK: courses/{dest}/index.html")
        else:
            print(f"MISSING: courses/{dest}/index.html")
            missing += 1
    return 1 if missing else 0


if __name__ == "__main__":
    raise SystemExit(main())

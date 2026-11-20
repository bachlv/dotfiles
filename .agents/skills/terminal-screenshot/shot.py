#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
import html
import math
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

WIDTH = 1200
CHARS_PER_ROW = 140
ROW_PX = 19
CHROME_CANDIDATES = (
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
    "google-chrome",
    "chromium",
)
ANSI = re.compile(r"\x1b\[[0-9;]*[A-Za-z]")
PAGE = """<!doctype html><meta charset=utf-8><style>
body{{margin:0;background:#1e1f22;color:#d4d4d4;font:13px/1.45 ui-monospace,Menlo,monospace}}
.bar{{background:#2b2d31;color:#9a9ca1;padding:8px 14px;font-size:12px}}
pre{{margin:0;padding:14px;white-space:pre-wrap;word-break:break-word}}
.ok{{color:#5fd068}}.bad{{color:#ff6b6b}}.cmd{{color:#7cb7ff}}
</style><div class=bar>{title}</div><pre>{body}</pre>"""


def colour(line: str) -> str:
    escaped = html.escape(line)
    if line.startswith("ok "):
        return f'<span class="ok">ok</span>{escaped[2:]}'
    if " PASSED" in line:
        return escaped.replace("PASSED", '<span class="ok">PASSED</span>')
    if " FAILED" in line:
        return escaped.replace("FAILED", '<span class="bad">FAILED</span>')
    if line.startswith(("FAIL", "ERROR")):
        return f'<span class="bad">{escaped}</span>'
    if line.startswith("=") and re.search(r"\bfailed\b|\berror", line):
        return f'<span class="bad">{escaped}</span>'
    if line.startswith("=") and "passed" in line or line.startswith("E2E PASSED"):
        return f'<span class="ok">{escaped}</span>'
    if line.startswith(("$", "== ")):
        return f'<span class="cmd">{escaped}</span>'
    return escaped


def find_chrome() -> str:
    for candidate in CHROME_CANDIDATES:
        found = candidate if Path(candidate).is_file() else shutil.which(candidate)
        if found:
            return found
    sys.exit("shot.py: Chrome not found (tried " + ", ".join(CHROME_CANDIDATES) + ")")


def main() -> None:
    if len(sys.argv) not in (3, 4):
        sys.exit("usage: shot.py <output.txt> <out.png> [title]")
    source, target = Path(sys.argv[1]), Path(sys.argv[2]).resolve()
    title = sys.argv[3] if len(sys.argv) == 4 else source.name
    lines = ANSI.sub("", source.read_text()).splitlines()
    rows = sum(max(1, math.ceil(len(line) / CHARS_PER_ROW)) for line in lines)
    height = 70 + ROW_PX * rows
    page = PAGE.format(title=html.escape(title), body="\n".join(colour(line) for line in lines))
    with tempfile.TemporaryDirectory() as workdir:
        page_path = Path(workdir) / "page.html"
        page_path.write_text(page)
        subprocess.run(
            [
                find_chrome(),
                "--headless=new",
                "--disable-gpu",
                "--hide-scrollbars",
                "--force-device-scale-factor=2",
                f"--window-size={WIDTH},{height}",
                f"--screenshot={target}",
                page_path.as_uri(),
            ],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
    print(target)


main()

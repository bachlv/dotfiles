---
name: terminal-screenshot
description: Terminal screenshots for PR evidence. Renders captured CLI output (test runs, make targets, curl/jq) to a titled PNG and attaches it to a PR. Use when a PR needs screenshot evidence of command output.
---

Turns real command output into a dark-terminal PNG with a title bar, then attaches it to a PR with `gh`. Feeds the Evidence section of the `pr` skill's template.

## Steps

1. **Capture real output to a text file.** Run the command and save what it printed (`cmd > name.txt 2>&1`); never retype it. Trim only noise lines (setup, doctor, compose) with `grep`, and keep a note of what you cut. Done when each file holds output the command actually printed.
2. **Render each capture.** One screenshot per point (a journey, a JSON read-back, tests passing, tests failing, `make check`):

   ```bash
   uv run --script ~/.claude/skills/terminal-screenshot/shot.py name.txt name.png "What this output shows"
   ```

   Pass a title saying what the output shows; with none, the bar shows the file name. `uv run --script` uses its own isolated Python and ignores the project in the working directory, so it never touches the project's `.venv` or `uv.lock`. Chrome must be installed. Done when every PNG exists.
3. **Look at every PNG** with Read. Done when none is clipped, badly wrapped, or showing a secret or real data. Made-up data only.
4. **Attach.** Put `![alt](./name.png)` in the PR body where each image belongs, then from the folder holding the PNGs:

   ```bash
   gh pr edit <n> --repo <owner/repo> --body-file body.md --attach './name.png#alt' --attach './other.png#alt'
   ```

   gh uploads the files and rewrites the `./` references to `user-attachments` URLs. Keep the PNGs out of the repo. Done when `gh pr view <n> --json body -q .body` shows `user-attachments` URLs and no `./` references.
5. **Caption honestly.** Under each image say what it proves. Give the commit the output came from, what you trimmed, and what is not shown. For a failing run, break the behaviour on purpose, capture the red output, restore the code, and say so.

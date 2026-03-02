When editing dotfiles or config files, always check if they are managed by chezmoi first. Run `chezmoi source-path <file>` to check. If managed, edit the chezmoi source file instead of the target file directly.

Always search local files and the project codebase first before attempting to use external tools like Sourcegraph. Only use external search if local files are insufficient.

When unsure about user intent or missing context, ask the user directly rather than spending extended time on autonomous exploration. Prefer a quick clarifying question over 5+ minutes of searching.

When providing review output, code snippets, or any content the user will copy-paste, always format it as clean, copy-pastable markdown from the start.

All plans that I ask Claude Code to create and edit belong in the ~/dev/base/plans/ directory. Make sure the file has a descriptive name based on the title of the plan.

All cheat sheets that I ask Claude Code to create and edit belong in the ~/dev/base/cheat-sheets/ directory.

When creating documents in the ~/dev/base/ directory make sure the file has a descriptive name based on the title of the document.


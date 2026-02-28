# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Overview

| Config | Source | Target |
|--------|--------|--------|
| Zsh | `dot_zshrc.tmpl` | `~/.zshrc` |
| Zsh env | `dot_zshenv` | `~/.zshenv` |
| Git | `dot_gitconfig.tmpl` | `~/.gitconfig` |
| Tmux | `dot_tmux.conf` | `~/.tmux.conf` |
| Alacritty | `dot_alacritty.toml` | `~/.alacritty.toml` |
| Starship | `dot_config/starship.toml` | `~/.config/starship.toml` |
| Neovim | `dot_config/nvim/` | `~/.config/nvim/` |
| Vim | `dot_vimrc` | `~/.vimrc` |
| Tmuxinator | `dot_tmuxinator/` | `~/.tmuxinator/` |

---

## Shell — Zsh

**Source:** `dot_zshrc.tmpl` → `~/.zshrc`
**Source:** `dot_zshenv` → `~/.zshenv`

### Oh My Zsh
- Theme: none (Starship handles the prompt)
- Plugins: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`
- Startup optimizations: compfix and update prompt disabled

### PATH additions
- `~/.local/bin`
- `~/.rd/bin` (Rancher Desktop)
- `/opt/homebrew/opt/ruby/bin` + gem bin
- NVM default node (lazy-loaded for speed)
- jenv + JAVA_HOME

### Aliases
| Alias | Command |
|-------|---------|
| `c` | `chezmoi` |
| `mux` | `tmuxinator` |

### Shell functions

| Function | Description |
|----------|-------------|
| `go` | FZF picker to `cd` into a project under `~/dev` |
| `workspace <repo> <name> <branch>` | Create a git worktree + launch a tmuxinator workspace |
| `workspaces` | FZF picker across all worktree workspaces |
| `gbc` | FZF branch checkout sorted by recent activity |
| `ghb` | Open current branch on GitHub via `gh browse` |
| `gsf` | FZF stash manager (apply / pop / drop) |
| `tag <name>` | Recreate a git tag locally and remotely |
| `ds` | Stop and remove all running Docker containers |
| `clone <repo>` | Clone from `code.corp.creditkarma.com/ck-private/` |
| `idea` | Open path in IntelliJ IDEA |

### FZF configuration
- `Ctrl-R` — history search with `Ctrl-Y` to copy to clipboard
- `Ctrl-T` — file picker with `bat` preview
- `Alt-C` — directory picker with `tree` preview

### Tmux auto-start
New interactive shells (outside VS Code / integrated terminals) automatically attach to a new tmux session rooted at `~/dev`.

### Lazy-loaded runtimes
- **nvm** — loaded on first call to `nvm`, `node`, `npm`, or `npx` (~saves 900ms)
- **jenv** — loaded on first call to `jenv` (~saves 200ms)

### Zsh env (`dot_zshenv`)
- Sources `~/.cargo/env` (Rust toolchain)

---

## Git

**Source:** `dot_gitconfig.tmpl` → `~/.gitconfig`
Template variables: `{{ .name }}`, `{{ .email }}`

### Settings
| Key | Value |
|-----|-------|
| `core.editor` | `vim` |
| `init.defaultBranch` | `main` |
| `pull.rebase` | `true` |
| `push.autoSetupRemote` | `true` |

### Aliases

| Alias | Expands to |
|-------|-----------|
| `s` | `status` |
| `add` | `add .` |
| `unstage` | `reset HEAD --` |
| `cmd` | `!git add . && git commit -m "change"` |
| `ci` | `commit` |
| `amend` | `commit --amend --no-edit` |
| `co` | `checkout` |
| `br` | `branch` |
| `new` | `checkout -b` |
| `del` | `branch -d` |
| `pu` | `push` |
| `pl` | `pull` |
| `prune` | `remote prune origin` |
| `addp` | `add --patch` |
| `reb` | `rebase` |
| `rebi` | `rebase -i` |
| `stash-save` | `stash push -u` |
| `pop` | `stash pop` |
| `lg` | Compact graph log with colors |
| `log` | `log --oneline --decorate --graph --all` |
| `last` | `log -1 HEAD` |
| `ls` | `ls-files` |
| `untracked` | `ls-files -o --exclude-standard` |
| `alias` | List all aliases |
| `acm` | `!git add -A && git commit -m` |
| `ca` | `!git add . && git commit --amend --no-edit` |

---

## Tmux

**Source:** `dot_tmux.conf` → `~/.tmux.conf`

### Key bindings
| Key | Action |
|-----|--------|
| `prefix + -` | Horizontal split |
| `prefix + \|` | Vertical split |
| `prefix + r` | Reload config |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| Copy-mode `Enter` | Copy selection to clipboard via `pbcopy` |

### Settings
- Mouse: on (resize panes, click to select)
- Clipboard: on
- Scrollback buffer: 10,000 lines
- Copy mode: vi keybindings
- Extended keys: enabled (Shift+Enter passthrough for Claude Code)
- Terminal titles: passed through to iTerm2

### Theme
Tokyo Night color scheme applied to status bar, window tabs, pane borders, and copy mode.

---

## Alacritty

**Source:** `dot_alacritty.toml` → `~/.alacritty.toml`

- **Theme:** Tokyo Night (imported from `~/.config/alacritty/themes/themes/tokyo_night.toml`)
- **Font:** JetBrainsMono Nerd Font, size 14pt (Regular / Bold / Italic / Bold Italic)
- **Font offset:** y+1 for extra line spacing
- **Clickable links:** enabled via `Control+click` or `Control+Shift+O`

---

## Starship Prompt

**Source:** `dot_config/starship.toml` → `~/.config/starship.toml`

Tokyo Night palette. Prompt format:

```
<directory> on <git-branch> <git-status> took <duration>
❯
```

### Modules
| Module | Style |
|--------|-------|
| `directory` | Bold blue, truncated to 3 segments |
| `git_branch` | Bold purple with Nerd Font icon |
| `git_status` | Orange (↑↓ ahead/behind, ~modified, +staged, ?untracked) |
| `cmd_duration` | Dim (only shown when ≥ 2s) |
| `character` | Green `❯` on success, red on error |

Disabled: python, scala, java, nodejs, rust, docker_context, package.

---

## Neovim

**Source:** `dot_config/nvim/` → `~/.config/nvim/`

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

### Key files
| File | Purpose |
|------|---------|
| `init.lua` | Main entry point |
| `lua/custom/plugins/init.lua` | Custom plugin additions |
| `lua/kickstart/plugins/` | Kickstart plugin configs |
| `lazy-lock.json` | Locked plugin versions |

### Kickstart plugins
| Plugin | Purpose |
|--------|---------|
| `autopairs.lua` | Auto-close brackets/quotes |
| `debug.lua` | DAP debugging support |
| `gitsigns.lua` | Git diff signs in gutter |
| `indent_line.lua` | Indentation guides |
| `lint.lua` | Async linting |
| `neo-tree.lua` | File explorer sidebar |

---

## Tmuxinator Sessions

**Source:** `dot_tmuxinator/` → `~/.tmuxinator/`

| Session file | Name | Layout | Panes |
|-------------|------|--------|-------|
| `default.yml` | `default` | single | 1 pane at `~/dev` |
| `coding.yml` | `<dir-name>` | main-horizontal | 3 panes (main + 2 bottom) |
| `claude.yml` | `claude-<dir>` | main-horizontal | 3× `claude` panes |
| `workspace.yml` | `wt-<dir>` | main-horizontal | `nvim .`, `claude`, empty |

The `workspace` and `claude` sessions accept an optional path argument (used by the `workspace` shell function).

---

## Chezmoi Usage

```sh
# Edit a managed file (source)
chezmoi edit ~/.zshrc

# Apply changes to the home directory
chezmoi apply

# See what would change
chezmoi diff

# Add a new file to management
chezmoi add ~/.some-new-config

# Update from remote
chezmoi update
```

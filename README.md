# dotfiles

> An opinionated, cross-platform terminal coding environment — tmux · sesh ·
> Neovim · Claude Code · git worktrees — bootstrapped from scratch with
> [chezmoi](https://www.chezmoi.io/).

<!-- TODO: screenshot/gif of the sesh → nvim-over-claude layout -->

## Highlights

- **One-command bootstrap** on a fresh macOS or Linux box — packages, shell,
  toolchains, and editor plugins install themselves.
- **Signature loop**: a `sesh` session spins up a git worktree with Neovim and
  Claude Code side-by-side in one window.
- **Fast shell** — lazy-loaded `nvm`, skipped `compinit` verification, and
  fzf-driven pickers for branches, worktrees, and stashes.
- **Machine-aware configs** — templated git identity and a work/personal switch
  resolved at `init` time.
- **Per-machine escape hatch** so local tweaks never fight what's in the repo.

## Quick start

```sh
chezmoi init --apply mackness/dotfiles
```

On first run, `init` prompts for three values that feed the templated configs:

| Prompt | Used for |
|--------|----------|
| Git name | `~/.gitconfig` identity |
| Git email | `~/.gitconfig` identity |
| Is this a work machine | Toggles work-specific config |

## What's inside

| Domain | Tools | Source |
|--------|-------|--------|
| Shell | Zsh (Oh My Zsh) | `dot_zshrc.tmpl`, `dot_zshenv` |
| Multiplexer | tmux, tmuxinator, sesh | `dot_tmux.conf`, `dot_tmuxinator/`, `dot_config/sesh/` |
| Editor | Neovim (kickstart-based), Vim | `dot_config/nvim/`, `dot_vimrc` |
| Terminal | Ghostty | `dot_config/ghostty/` |
| Prompt | Starship | `dot_config/starship.toml` |
| Git | Git | `dot_gitconfig.tmpl` |

## Bootstrap

The `.chezmoiscripts/` run automatically on `apply` and set up everything the
configs depend on:

- **Packages** — Homebrew (macOS) or apt (Linux): tmux, fzf, bat, neovim,
  starship, gh, lazygit, sesh, zoxide, jenv, and more.
- **Shell** — Oh My Zsh plus `zsh-autosuggestions` and `zsh-syntax-highlighting`.
- **Toolchains** — Rust/Cargo, `tree-sitter` CLI, and NVM.
- **tmux** — TPM and all configured plugins (re-runs when `dot_tmux.conf` changes).

Scripts are idempotent — they skip anything already installed, so re-applying is
safe.

## Everyday usage

```sh
chezmoi edit ~/.zshrc    # edit the source file
chezmoi apply            # apply changes
chezmoi diff             # preview changes
chezmoi add <file>       # track a new file
chezmoi update           # pull + apply
```


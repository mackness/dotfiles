#!/bin/bash
# Claude Code statusline script
# Receives JSON context via stdin

input=$(cat)

# Current git branch
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "n/a")

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')

# Context window progress bar
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // 100')
used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

# Build progress bar (20 chars wide)
bar_width=20
filled=$(echo "$used $bar_width" | awk '{printf "%d", ($1/100)*$2}')
empty=$((bar_width - filled))
bar=$(printf '%0.s#' $(seq 1 $filled 2>/dev/null) ; printf '%0.s-' $(seq 1 $empty 2>/dev/null))

echo "$branch | ctx [${bar}] ${remaining}% left | $model"

#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Files that symlink directly into $HOME
HOME_FILES=(
  bashrc
  tmux.conf
)

# Directories that symlink into $XDG_CONFIG_HOME (~/.config/)
CONFIG_DIRS=(
  nvim
)

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    local current
    current="$(readlink "$dst")"
    if [ "$current" = "$src" ]; then
      echo "  ok   $dst -> $src"
      return
    fi
    echo "  update $dst -> $src (was $current)"
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "  backup $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  else
    echo "  link $dst -> $src"
  fi
  ln -s "$src" "$dst"
}

echo "==> Linking home dotfiles"
for f in "${HOME_FILES[@]}"; do
  link "$DOTFILES_DIR/$f" "$HOME/.$f"
done

echo "==> Creating ~/.config"
mkdir -p "$HOME/.config"

echo "==> Linking config directories"
for d in "${CONFIG_DIRS[@]}"; do
  link "$DOTFILES_DIR/$d" "$HOME/.config/$d"
done

echo "==> Done"

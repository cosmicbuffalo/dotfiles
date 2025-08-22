#!/usr/bin/env bash
set -euo pipefail

# --- Helper functions ---
info() { echo -e "\033[1;32m[INFO]\033[0m $*"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $*"; }

# --- Install dependencies ---
info "Installing tmux, neovim, and zsh..."
if command -v apt-get &>/dev/null; then
  sudo apt-get update
  sudo apt-get install -y tmux neovim zsh git curl
elif command -v brew &>/dev/null; then
  brew install tmux neovim zsh git curl
else
  warn "Package manager not detected. Please install tmux, neovim, and zsh manually."
fi

# --- Set zsh as default shell ---
if [ "$SHELL" != "$(command -v zsh)" ]; then
  info "Changing default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi

# --- Copy dotfiles from repo ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info "Setting up custom zshrc..."
cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"

info "Setting up tmux.conf..."
cp "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"

# --- Setup tmux plugin manager (TPM) ---
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  info "Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- Setup Neovim config ---
NVIM_CONFIG_DIR="$HOME/.config/nvim"
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
  info "Cloning custom Neovim config..."
  git clone https://github.com/YOUR-USERNAME/YOUR-NVIM-CONFIG.git "$NVIM_CONFIG_DIR"
else
  info "Updating existing Neovim config..."
  git -C "$NVIM_CONFIG_DIR" pull
fi

# --- Install Neovim plugins with Lazy.nvim ---
info "Installing Neovim plugins with Lazy..."
nvim --headless "+Lazy! restore" +qa

# --- Apply tmux config and install plugins ---
info "Reloading tmux config..."
tmux source "$HOME/.tmux.conf"

info "Installing tmux plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

info "Bootstrap complete! Restart your terminal or run 'zsh' to start."


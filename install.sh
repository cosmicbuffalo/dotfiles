#!/usr/bin/env bash

# This install script can be run with a single command:
# curl -fsSL https://raw.githubusercontent.com/cosmicbuffalo/dotfiles/main/install.sh | bash


set -euo pipefail

info() { echo -e "\033[1;32m[INFO]\033[0m $*"; }

# --- Configuration ---
DOTFILES_REPO="https://github.com/cosmicbuffalo/dotfiles.git"
NVIM_CONFIG_REPO="https://github.com/cosmicbuffalo/nvim.git"
DOTFILES_DIR="$HOME/.dotfiles"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

# --- Install dependencies ---
info "Installing tmux, neovim, and zsh..."
if command -v apt-get &>/dev/null; then
  sudo apt-get update
  sudo apt-get install -y tmux neovim zsh git curl golang nodejs ripgrep fd-find
elif command -v brew &>/dev/null; then
  brew install tmux neovim zsh git curl golang nodejs ripgrep fd
elif command -v pacman &>/dev/null; then
  sudo pacman -Sy --noconfirm tmux neovim zsh git curl golang nodejs ripgrep fd-find
else
  echo "Unsupported package manager. Please install dependencies manually." >&2
  exit 1
fi

info "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

info "Installing stylua..."
cargo install stylua

info "Installing Lazygit..."
go install github.com/jesseduffield/lazygit@latest

# --- Clone dotfiles repo ---
if [ ! -d "$DOTFILES_DIR" ]; then
  info "Cloning dotfiles repo..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  info "Updating existing dotfiles repo..."
  git -C "$DOTFILES_DIR" pull
fi

# --- Install dotfiles ---
info "Setting up zshrc..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

info "Setting up tmux.conf..."
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# --- Set zsh as default shell ---
if [ "$SHELL" != "$(command -v zsh)" ]; then
  info "Changing default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi

# --- Setup tmux plugin manager (TPM) ---
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  info "Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- Setup Neovim config ---
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
  info "Cloning Neovim config..."
  git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG_DIR"
else
  info "Updating Neovim config..."
  git -C "$NVIM_CONFIG_DIR" pull
fi

info "Installing Neovim plugins with Lazy..."
nvim --headless "+Lazy! restore" +qa

# --- Apply tmux config and install plugins ---
info "Reloading tmux config..."
tmux source "$HOME/.tmux.conf" || true  # no tmux session yet? ignore

info "Installing tmux plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

info "✅ Bootstrap complete! Restart your terminal or run 'zsh'."


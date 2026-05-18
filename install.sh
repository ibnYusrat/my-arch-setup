#!/bin/bash

set -e

echo "Starting My Arch Setup Installation..."

# 1. Install yay (AUR Helper) if not installed
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay-bin
else
    echo "yay is already installed."
fi

# 2. Install Packages
echo "Installing packages from packages.txt..."
yay -S --needed --noconfirm - < packages.txt

# 3. Symlink Configurations using GNU Stow
echo "Setting up symlinks using GNU Stow..."
if ! command -v stow &> /dev/null; then
    yay -S --needed stow
fi

# We use stow from the root of the repo to target the home directory
# Assuming we restructure the repo slightly to make stow work easily:
# - .config/ -> ~/.config
# - home/ -> ~/

# Stow the .config directory
stow -t ~/.config .config

# Stow the home directory files
stow -t ~/ home

echo "Installation complete!"
echo "Note: You might need to set up your ZSH custom plugins, Espanso, and NVM manually."

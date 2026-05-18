# My Arch Linux Setup

This repository contains the dotfiles and an automated installation script for my custom Hyprland-based Arch Linux setup.

## Features
- **Window Manager:** Hyprland
- **Status Bar:** Waybar (Highly customized with weather and power menus)
- **Terminal:** Kitty
- **Shell:** Zsh with Oh-My-Zsh and Powerlevel10k theme
- **File Manager:** Dolphin (Configured to use Kitty as the embedded terminal)
- **Launcher & Menus:** Wofi and nwg-dock-hyprland
- **Dynamic Wallpapers:** Custom scripts leveraging `mpvpaper` (for video wallpapers that auto-pause to save resources) and `hyprpaper`.
- **Text Expansion:** Espanso (Wayland native)

## Installation

**Warning:** Running the install script will use GNU Stow to symlink configurations into your home directory. It may overwrite existing configurations if they share the same name. Proceed with caution.

1. **Clone the repository:**
   ```bash
   git clone <your-repository-url> ~/Repos/my-arch-setup
   cd ~/Repos/my-arch-setup
   ```

2. **Run the installation script:**
   ```bash
   ./install.sh
   ```
   *The script will install the `yay` AUR helper (if missing), install all required packages listed in `packages.txt`, and use `stow` to link the `.config` and `home` directories.*

3. **Post-Installation Steps:**
   - **Oh-My-Zsh:** Ensure Oh-My-Zsh is installed.
   - **Environment Variables:** You may need to manually add sensitive environment variables (like API keys) to your `~/.zshrc.local` or directly into the generated `~/.zshrc` (just remember not to commit them!).

## File Structure
- `.config/`: Contains the configurations for Hyprland, Waybar, Kitty, Espanso, KDE globals (for Dolphin), and nwg-components.
- `home/`: Contains shell configurations (`.zshrc`, `.p10k.zsh`).
- `packages.txt`: A comprehensive list of official Arch and AUR packages required for the setup.
- `install.sh`: The automated deployment script.

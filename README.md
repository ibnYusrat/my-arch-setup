# ❄️ My Arch Linux Wayland Setup

![Arch Linux](https://img.shields.io/badge/OS-Arch_Linux-1793d1?style=flat-square&logo=arch-linux&logoColor=white)
![WM](https://img.shields.io/badge/WM-Hyprland-00a8f3?style=flat-square&logo=hyprland&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Zsh-4EAA25?style=flat-square&logo=zsh&logoColor=white)

A highly customized, script-driven, and beautiful Hyprland setup for Arch Linux. This repository contains all dotfiles, custom binaries, and an automated deployment script to replicate the environment instantly.

---

## 🎥 Demo

*(Add your `demo.mp4` or a GIF here so people can see the desktop in action!)*
> **Note:** To embed a video directly in GitHub markdown, you can just drag and drop your `demo.mp4` right into this section while editing it on GitHub.com.

---

## ✨ Key Features

- **Window Manager:** [Hyprland](https://hyprland.org/) - Configured for smooth animations and a modern aesthetic.
- **Dynamic "Smart" Wallpaper:** A custom background daemon that plays a video wallpaper (`winter_forest.mp4`) when the desktop is empty, but **automatically pauses** the video when windows are open to save CPU/GPU resources.
- **Status Bar:** Waybar - Highly customized with a power menu and dynamic weather integration.
- **Terminal:** Kitty - Fast, GPU-accelerated, and cleanly themed.
- **File Manager Integration:** Dolphin is uniquely configured to use Kitty as its embedded terminal (via custom KDE globals).
- **Nearby Sharing:** Includes a custom compiled binary (`nearby_qml_file_tray_app`) for seamless local file sharing.
- **Text Expansion:** Native Wayland text expansion via Espanso.

---

## 🛠️ File Structure

The repository is structured to be used directly with `GNU Stow`:

```text
my-arch-setup/
├── .config/            # Waybar, Hyprland, Kitty, Espanso, KDE configs
├── home/               # Zsh configurations (.zshrc, .p10k.zsh) & Media Assets
│   ├── Photos/         # Fallback static wallpaper
│   └── Pictures/       # The video wallpaper file
├── local/              # Custom binaries and shared libraries
│   ├── bin/            # nearby_qml_file_tray_app
│   └── lib/            # Required shared libraries for the binary
├── install.sh          # 1-click deployment script
└── packages.txt        # Master list of required pacman & AUR packages
```

---

## 🚀 Installation

**⚠️ Warning:** The installation script uses GNU Stow to symlink files into your home directory. If you already have configurations for these apps, Stow might complain or overwrite them. Please back up your existing `~/.config/hypr` and `~/.zshrc` before proceeding.

### 1. Clone the Repository
```bash
git clone <your-repository-url> ~/Repos/my-arch-setup
cd ~/Repos/my-arch-setup
```

### 2. Run the Installer
```bash
chmod +x install.sh
./install.sh
```

**What the script does:**
1. Installs the `yay` AUR helper if it is not present on your system.
2. Installs all required packages from `packages.txt` (including Wayland compositors, fonts, network managers, and video players).
3. Uses `stow` to link all configurations, binaries, and wallpaper assets directly into your `~/.config`, `~/.local`, and home directories.

### 3. Post-Installation
- **Shell Theme:** Open a new terminal. `zsh` should prompt you to configure the `powerlevel10k` theme if the symlink did not automatically apply the saved `.p10k.zsh` state.
- **API Keys:** If you have custom scripts requiring API keys (like the Waybar weather module), add them to a `.zshrc.local` file or export them manually so they are not tracked by Git.

---

## 📜 Custom Scripts Breakdown

### The Smart Wallpaper (`smart_pause.sh`)
This setup uses `mpvpaper` to render a video background. To prevent battery drain and high resource usage while working, `smart_pause.sh` actively monitors Hyprland workspaces. If a non-ignored window (like a browser or code editor) is opened and visible, it pauses the `mpv` instance via an IPC socket. When you minimize or close the window, the video resumes.

### Dolphin & Kitty
By modifying `kdeglobals`, Dolphin standard behavior of opening Konsole is overridden. Clicking "Open in Terminal" will now natively launch your highly customized Kitty terminal within the directory.

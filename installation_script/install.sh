#!/bin/bash

# Exit immediately if a command fails
set -e
DOTDIR="$HOME/dotfiles"

echo "Starting installation (required packages)..."

# Example: Update package lists
read -p "Do you want to update system?(recommended) (y/n): " update
if [[ $update == "y" ]]; then
  sudo pacman -Syu --noconfirm
fi
# Example: Install necessary packages
PACKAGES=("neovim" "git" "htop" "fzf" "rofi" "zsh" "kitty" "fastfetch" "hyprland" "waybar" "grim" "swww" "hyprlock" "pipewire" "bluez-utils" "brightnessctl" "pipewire-pulse" "python" "ttf-jetbrains-mono-nerd" "wireplumber")

for pkg in "${PACKAGES[@]}"; do
  echo "Installing $pkg..."
  sudo pacman -S --noconfirm $pkg
done

echo "Installation complete!"

if ! command -v paru &>/dev/null; then
  echo "Installing Paru..."
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm
  cd ..
  rm -rf paru
fi

paru -S --noconfirm bluetui rofi-lbonn-wayland-git apple_fonts cava-git anyrun

echo "Backuping up older config files, it will be in your home directory"

BACKUP_DIR="$HOME/.config_backup"
CONFIG_DIR="$HOME/.config"
CONFIGS=("nvim" "zsh" "kitty" "hypr" "waybar" "fastfetch" "anyrun" "kitty" "cava") # List of config folders to back up

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

for config in "${CONFIGS[@]}"; do
  if [ -d "$CONFIG_DIR/$config" ] || [ -f "$CONFIG_DIR/$config" ]; then
    echo "Backing up $config..."
    mv "$CONFIG_DIR/$config" "$BACKUP_DIR/${config}_$(date +%Y%m%d_%H%M%S)"
  fi
done

echo "Backup complete. Old configs are in $BACKUP_DIR"

echo "Setting up dotfiles..."
cd "$DOTDIR"
stow nvim zsh kitty hyprland cava anyrun waybar fastfetch

echo "Config files are setup"

sudo chsh -s /bin/zsh

echo "done"

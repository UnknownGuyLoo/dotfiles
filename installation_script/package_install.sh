#!/bin/bash

set -e # Exit on any error

PKG_FILE="packages.txt"
PARU_FILE="paru_pkgs.txt"

# Check if the package file exists
if [ ! -f "$PKG_FILE" ]; then
  echo "Error: $PKG_FILE not found!"
  exit 1
fi

# Check if the paru pkg file exists
if [ ! -f "$PARU_FILE" ]; then
  echo "Error: $PARU_FILE not found!"
  exit 1
fi

echo "Starting package installation..."

# Read each package line by line and install
while IFS= read -r pkg || [ -n "$pkg" ]; do
  # Ignore empty lines and comments (#)
  [[ -z "$pkg" || "$pkg" =~ ^#.*$ ]] && continue

  echo "Installing: $pkg..."
  sudo pacman -S --noconfirm --needed "$pkg"
done <"$PKG_FILE"

while IFS= read -r pkgs || [ -n "$pkgs" ]; do
  [[ -z "$pkgs" || "$pkgs" =~ ^#.*$ ]] && continue

  echo "Installing: $pkgs..."
  sudo paru -S --noconfirm --needed "$pkgs"
done <"$PARU_FILE"

echo "✅ Installation complete!"

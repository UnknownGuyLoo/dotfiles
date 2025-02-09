#!/bin/bash

set -e # Exit on any error

PARU_FILE="paru_pkgs.txt"

# Check if the paru pkg file exists
if [ ! -f "$PARU_FILE" ]; then
  echo "Error: $PARU_FILE not found!"
  exit 1
fi

echo "Starting package installation..."

while IFS= read -r pkgs || [ -n "$pkgs" ]; do
  [[ -z "$pkgs" || "$pkgs" =~ ^#.*$ ]] && continue

  echo "Installing: $pkgs..."
  paru -S --noconfirm --needed "$pkgs"
done <"$PARU_FILE"

echo "✅ Installation complete!"

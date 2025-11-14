#!/bin/bash

# Dotfiles installer for Miles-dots
set -e

SOURCE_DIR="/usr/share/miles-dots-git"

# Helper to check commands
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install package
install_package() {
    local package=$1

    if command_exists yay; then
        echo "Installing $package with yay..."
        yay -S --noconfirm $package
    else
        echo "Installing $package with pacman..."
        sudo pacman -S --noconfirm $package
    fi
}

# Copy function with backup
copy_config() {
    local src=$1
    local dest=$2
    local name=$3

    if [ -e "$dest" ]; then
        echo "Backing up existing $name → ${dest}.bak_$(date +%Y%m%d_%H%M%S)"
        mv "$dest" "${dest}.bak_$(date +%Y%m%d_%H%M%S)"
    fi

    mkdir -p "$(dirname "$dest")"
    echo "Copying $name..."
    cp -r "$src" "$dest"
}

# CONFIG LIST
declare -A configs=(
    ["niri"]="$HOME/.config/niri"
    ["rofi"]="$HOME/.config/rofi"
    ["eww"]="$HOME/.config/eww"
)

# Install + copy each config
for pkg in "${!configs[@]}"; do
    if ! command_exists "$pkg"; then
        install_package "$pkg"
    else
        echo "$pkg already installed."
    fi

    copy_config "$SOURCE_DIR/.config/$pkg" "${configs[$pkg]}" "$pkg"
done

# Copy bin scripts
copy_config "$SOURCE_DIR/.local/share/bin" "$HOME/.local/share/bin" "bin scripts"

# Copy mimeapps.list
copy_config "$SOURCE_DIR/.config/mimeapps.list" "$HOME/.config/mimeapps.list" "mimeapps.list"

# Copy dolphinrc
copy_config "$SOURCE_DIR/.config/dolphinrc" "$HOME/.config/dolphinrc" "dolphinrc"

echo "Miles dotfiles installed successfully!"


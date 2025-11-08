#!/bin/bash

# This script sets up the dotfiles by copying them to their correct locations.
# It also installs missing packages for Arch Linux (using pacman or yay).

# --- Helper function to check if a command exists ---
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# --- Package installation ---
install_package() {
    local package=$1
    if command_exists yay; then
        echo "Installing $package with yay..."
        yay -S --noconfirm $package
    else
        echo "Installing $package with pacman..."
        echo 'ubuntum' | sudo -S pacman -S --noconfirm $package
    fi
}

# --- Copying function ---
copy_config() {
    local source_path=$1
    local target_path=$2
    local config_name=$3

    # Back up existing config if it's a real file/directory
    if [ -e "$target_path" ]; then
        echo "Backing up existing $config_name config..."
        mv "$target_path" "${target_path}.bak_$(date +%Y%m%d_%H%M%S)"
    fi

    # Create the parent directory if it doesn't exist
    mkdir -p "$(dirname "$target_path")"

    # Copy the files
    echo "Copying $config_name..."
    cp -r "$source_path" "$target_path"
}

# --- Main setup ---

# Define configs to manage
declare -A configs
configs=(
    ["niri"]="$HOME/.config/niri"
    ["rofi"]="$HOME/.config/rofi"
    ["eww"]="$HOME/.config/eww"
)

# Process packages and their configs
for pkg in "${!configs[@]}"; do
    if ! command_exists "$pkg"; then
        install_package "$pkg"
    else
        echo "$pkg is already installed."
    fi
    copy_config "$HOME/dotfiles/.config/$pkg" "${configs[$pkg]}" "$pkg"
done

# --- Handle other files ---

# Scripts in bin
copy_config "$HOME/dotfiles/.local/share/bin" "$HOME/.local/share/bin" "bin scripts"

# mimeapps.list
copy_config "$HOME/dotfiles/.config/mimeapps.list" "$HOME/.config/mimeapps.list" "mimeapps.list"

# dolphinrc
copy_config "$HOME/dotfiles/.config/dolphinrc" "$HOME/.config/dolphinrc" "dolphinrc"

echo "Dotfiles setup complete!"

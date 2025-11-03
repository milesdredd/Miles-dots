#!/bin/bash

# This script sets up the dotfiles by creating symbolic links.
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

# --- Symlinking function ---
link_config() {
    local source_path=$1
    local target_path=$2
    local config_name=$3

    # Back up existing config if it's a real file/directory and not a symlink
    if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
        echo "Backing up existing $config_name config..."
        mv "$target_path" "${target_path}.bak_\$(_date +%Ymt%d_%H_%M%S)"
    fi

    # Create the symlink
    echo "Creating symlink for $config_name..."
    # Ensure parent directory of target exists
    mkdir -p "$(dirname "$target_path")"
    ln -sfn "$source_path" "$target_path"
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
    link_config "$HOME/dotfiles/.config/$pkg" "${configs[$pkg]}" "$pkg"
done

# --- Handle other files ---

# Scripts in bin
link_config "$HOME/dotfiles/.local/share/bin" "$HOME/.local/share/bin" "bin scripts"

# mimeapps.list
link_config "$HOME/dotfiles/.config/mimeapps.list" "$HOME/.config/mimeapps.list" "mimeapps.list"

# dolphinrc
link_config "$HOME/dotfiles/.config/dolphinrc" "$HOME/.config/dolphinrc" "dolphinrc"

echo "Dotfiles setup complete!"

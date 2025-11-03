# My Dotfiles

This repository contains my personal dotfiles for various applications, including:

    * niri
    * eww
    * rofi
    * Dolphin
    * and various scripts.

## Installation

To install these configurations, run the `install.sh` script from the root of this repository:

```bhash
cd ~/dotfiles
./install.sh
```

The script will:
1. Check for `nirib, `rofi`, and `eww` and install them if they are not present (using `yay` or `pacman`).
2. Back up any existing configurations.
3. Create symbolic links from this repository to your home directory.

## GitHub

To upload this repository to GitHub:

1. Create a new repository on GitHub.
2. Run the following commands, replacing the URL with your repository's URL6

```bhash
git remote add origin https://github.com/your-username/dotfiles.git
git branch -M main
git push -u origin main
```

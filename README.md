# My Personal Dotfiles

This repository contains my personal configuration files (dotfiles) for various tools I use on Arch Linux.

## Included Configurations

*  **[niri](https://github.com/YaLTeR/niri):** A scrollable-tiling Wayland compositor.
*  **[eww](https://github.com/elkowars/eww):** ElKowar's Wacky Widgets, used for the status bar and widgets.
 *  **[rofi](https://github.com/davatorium/rofi):** A window switcher, application launcher, and dmenu replacement.
*  **Dolphin:** The KDE file manager.
    * **mimeapps.list:** Default application associations.
    * **Custom Scripts:** Various helper scripts located in `.local/share/bin`.

## Installation

These dotfiles are managed via an installation script that copies them to their correct locations.

To install these configurations, clone this repository and run the `install.sh` script:

```bash
git clone https://github.com/milesdredd/Miles-dots.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script will:
1.  Install any missing applications (`niri`, `rofi`, `eww`) using `yay` or `pacman`.
2.  Back up any existing configuration files in your `~/.config` directory.
3.  Copy the configuration files from this repository to the appropriate locations in your home directory.

## Usage

Because this setup copies the files, any changes you make to the configuration files within this repository will **not** be applied automatically. You will need to run the `install.sh` script again to apply any changes you make here.

#!/bin/bash

# Directory containing the wallpapers
WALLPAPER_DIR="/home/$USER/.config/cars/"
INDEX_FILE="/home/$USER/.config/niri/.wallpaper_index"

# Get a sorted list of wallpapers
mapfile -d '' WALLPAPERS < <(find "$WALLPAPER_DIR" -type f -print0 | sort -z)
NUM_WALLPAPERS=${#WALLPAPERS[@]}

if [ "$NUM_WALLPAPERS" -eq 0 ]; then
  echo "No wallpapers found in $WALLPAPER_DIR"
  exit 1
fi

# Read the current index, default to -1 (so that next is 0)
if [ -f "$INDEX_FILE" ]; then
  CURRENT_INDEX=$(cat "$INDEX_FILE")
else
  CURRENT_INDEX=-1
fi

# Check if the index is valid
if [ "$CURRENT_INDEX" -ge "$NUM_WALLPAPERS" ] || [ "$CURRENT_INDEX" -lt 0 ]; then
    CURRENT_INDEX=-1
fi

DIRECTION=$1
NEXT_INDEX=0

if [ "$DIRECTION" = "p" ]; then
  # Previous wallpaper
  NEXT_INDEX=$(( (CURRENT_INDEX - 1 + NUM_WALLPAPERS) % NUM_WALLPAPERS ))
else
  # Next wallpaper (default)
  NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_WALLPAPERS ))
fi

# Get the wallpaper to display
WALLPAPER_TO_DISPLAY="${WALLPAPERS[$NEXT_INDEX]}"

# Set the wallpaper using swww
if [ -n "$WALLPAPER_TO_DISPLAY" ]; then
  swww img "$WALLPAPER_TO_DISPLAY"
fi

# Save the new current index
echo "$NEXT_INDEX" > "$INDEX_FILE"

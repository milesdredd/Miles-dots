#!/bin/bash
# This script opens the specified link in Brave's web app mode.

if [ -z "$1" ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

# Open the URL in Brave's web app mode
#env OZONE_PLATFORM=wayland /sbin/brave --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --profile-directory=1 --app="$1"
brave --profile-directory=1 --app="$1"

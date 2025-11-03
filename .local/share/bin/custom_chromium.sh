#!/bin/bash
# This script opens the specified file or link in Brave's web app mode.

if [ -z "$1" ]; then
    echo "Usage: $0 <file_or_url>"
    exit 1
fi

# Check if input is a URL
if echo "$1" | grep -qE "^(https?://|www\.)"; then
    if echo "$1" | grep -qE "^www\."; then
        user_input="https://$1"
    else
        user_input="$1"
    fi
# Check if input is a local file
elif [ -f "$1" ]; then
    user_input="file://$(realpath "$1")"
else
    echo "Invalid file or URL."
    exit 1
fi

# Open in Brave
brave --profile-directory=1 --app="$user_input"

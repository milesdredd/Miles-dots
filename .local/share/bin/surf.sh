#!/usr/bin/env sh





# Prompt user to enter a URL or search query
user_input=$(rofi -dmenu -i -p "" -theme "~/.config/rofi/styles/surf.rasi")

# Check if input is provided
if [ -n "$user_input" ]; then
    # Check if the input is a valid URL (basic check for "http" or "https")
    if echo "$user_input" | grep -qE "^(https?://|www\.)"; then
        if echo "$user_input" | grep -qE "^www\."; then
            user_input="https://$user_input"
        fi
        # Open the URL in Brave as a web app
        brave --profile-directory=1 --app="$user_input"
    else
        # Treat the input as a Google search query and open in Brave
        search_query=$(echo "$user_input" | sed 's/ /+/g')
        env OZONE_PLATFORM=wayland /sbin/brave --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --profile-directory=1 --app="https://www.google.com/search?q=$search_query"

        #brave --profile-directory=1 --app="$user_input"
    fi
else
    echo "No input provided" # This line is for debugging
    hyprctl notify 3 2000 "rgb(0320fc)" "fontsize:22 No input provided!"
fi


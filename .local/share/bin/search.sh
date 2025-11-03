#!/usr/bin/env sh


# Search for files in the /home directory using fd and show the results in rofi
search_results=$(fd --type f . /home)

# Use rofi to select a file from the search results
selected_file=$(echo "$search_results" | rofi -dmenu -i -p "" -theme "~/.config/rofi/styles/fd.rasi" -theme-str "entry { placeholder: \"Search in /Home...\";}")

# Check if a file is selected and open it with the appropriate application
if [ -n "$selected_file" ]; then
    echo "Opening file: $selected_file" # This line is for debugging
    # Determine file type and open accordingly
    case "$(file -b --mime-type "$selected_file")" in
        text/plain)
            # Open text files in terminal-based editor (Vim)
            kate "$selected_file"
            ;;
        *)
            # Open other file types with xdg-open
            xdg-open "$selected_file"
            ;;
    esac
else
    echo "No file selected" # This line is for debugging
#    hyprctl notify 3 2000 "rgb(0320fc)" "fontsize:22 No file selected !..."
fi


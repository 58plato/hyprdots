#!/bin/bash

# Simple Wallpaper Selector - Only Wofi
WALLPAPER_DIR="$HOME/Pictures/wallpaper"
CURRENT_WALLPAPER_FILE="$HOME/.config/hypr/current-wallpaper"

# Create directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

# Find wallpapers
wallpapers=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) 2>/dev/null | sort))

if [[ ${#wallpapers[@]} -eq 0 ]]; then
    notify-send "❌ No wallpapers found" "Please add wallpapers to $WALLPAPER_DIR directory"
    exit 1
fi

# Create wofi list
wofi_list=""
for wp in "${wallpapers[@]}"; do
    filename=$(basename "$wp")
    # Mark current wallpaper
    if [[ -f "$CURRENT_WALLPAPER_FILE" ]] && [[ "$(cat "$CURRENT_WALLPAPER_FILE")" == "$wp" ]]; then
        filename="✅ $filename"
    fi
    wofi_list+="${filename}"$'\n'
done

# Select with wofi
selected=$(echo "$wofi_list" | wofi \
    --dmenu \
    --prompt "🎨 Select wallpaper..." \
    --height 400 \
    --width 600 \
    --location center \
    --insensitive \
    --cache-file /tmp/wofi-wallpaper)

if [[ -n "$selected" ]]; then
    # Remove ✅ mark
    clean_selected=$(echo "$selected" | sed 's/✅ //')
    
    # Find file path
    for wp in "${wallpapers[@]}"; do
        if [[ "$(basename "$wp")" == "$clean_selected" ]]; then
            # Set wallpaper with swww
            swww img "$wp" \
                --transition-type grow \
                --transition-pos 0.98,0.98 \
                --transition-step 90 \
                --transition-fps 60 \
                --transition-bezier 0.65,0.05,0.36,1 \
                --transition-duration 2
            
            # Save current wallpaper
            echo "$wp" > "$CURRENT_WALLPAPER_FILE"
            
            # Notification
            notify-send "🎨 Wallpaper Changed" "$(basename "$wp")" -i "$wp"
            break
        fi
    done
fi
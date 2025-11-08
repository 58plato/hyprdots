#!/bin/bash

# Simple Wallpaper Selector - Rofi Version
WALLPAPER_DIR="$HOME/Pictures/wallpaper"
CURRENT_WALLPAPER_FILE="$HOME/.config/hypr/current-wallpaper"

mkdir -p "$WALLPAPER_DIR"

# Find wallpapers
wallpapers=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) 2>/dev/null | sort))

if [[ ${#wallpapers[@]} -eq 0 ]]; then
    notify-send "❌ No wallpapers found" "Please add wallpapers to $WALLPAPER_DIR"
    exit 1
fi

# Create rofi list
rofi_list=""
for wp in "${wallpapers[@]}"; do
    filename=$(basename "$wp")
    if [[ -f "$CURRENT_WALLPAPER_FILE" ]] && [[ "$(cat "$CURRENT_WALLPAPER_FILE")" == "$wp" ]]; then
        filename="✅ $filename"
    fi
    rofi_list+="${filename}\n"
done

# Select with rofi
selected=$(echo -e "$rofi_list" | rofi -dmenu -p "🎨 Wallpaper" -theme-str 'window {width: 50%;} listview {lines: 10;}')

if [[ -n "$selected" ]]; then
    clean_selected=$(echo "$selected" | sed 's/✅ //')
    
    for wp in "${wallpapers[@]}"; do
        if [[ "$(basename "$wp")" == "$clean_selected" ]]; then
            swww img "$wp" \
                --transition-type grow \
                --transition-pos 0.98,0.98 \
                --transition-step 90 \
                --transition-fps 60 \
                --transition-bezier 0.65,0.05,0.36,1 \
                --transition-duration 2
            
            echo "$wp" > "$CURRENT_WALLPAPER_FILE"
            notify-send "🎨 Wallpaper Changed" "$(basename "$wp")" -i "$wp"
            break
        fi
    done
fi

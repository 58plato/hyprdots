#!/bin/bash
# ~/.config/hypr/scripts/hybrid-launcher.sh

QUICK_ACTIONS="📸 Screenshot Area
📷 Screenshot Full  
🎨 Change Theme
⚡ Performance Mode
🖼️ Change Wallpaper
🔒 Lock Screen
🚪 Logout"

# Wofi'yi başlat
selected=$(echo -e "$QUICK_ACTIONS" | wofi --dmenu --prompt "🚀 Quick Actions" --height 350 --width 500)

case "$selected" in
    "📸 Screenshot Area") grim -g "$(slurp)" - | swappy -f - ;;
    "📷 Screenshot Full") grim - | swappy -f - ;;
    "🎨 Change Theme") ~/.config/hypr/scripts/theme-switcher.sh ;;
    "⚡ Performance Mode") ~/.config/hypr/scripts/performance-mode.sh ;;
    "🖼️ Change Wallpaper") ~/.config/hypr/scripts/wallpaper.sh ;;
    "🔒 Lock Screen") swaylock ;;
    "🚪 Logout") hyprctl dispatch exit ;;
esac

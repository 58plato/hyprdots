#!/bin/bash

# Theme Switcher Script - Safe for your existing configs
THEME_DIR="$HOME/.config/theme-switcher"
mkdir -p "$THEME_DIR"

# Original waybar style template (önceki gibi aynı)
cat > "$THEME_DIR/waybar-style-template.css" << 'EOF'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrainsMono Nerd Font", "JetBrains Mono", monospace;
    font-weight: bold;
    font-size: 12px;
    min-height: 0;
}

window#waybar {
    background: {{WAYBAR_BG}};
    color: #cdd6f4;
    border-bottom: 1px solid {{WAYBAR_BORDER}};
    transition: background-color 0.3s;
}

window#waybar.hidden {
    opacity: 0.2;
}

tooltip {
    background: #1e1e2e;
    border-radius: 10px;
    border: 2px solid #313244;
    color: #cdd6f4;
}

tooltip label {
    color: #cdd6f4;
}

/* CLOCK */
#clock {
    color: {{CLOCK_COLOR}};
    background: transparent;
    padding: 0 12px;
    margin: 3px 0;
    border-radius: 6px;
    font-weight: bold;
}

#clock:hover {
    background: #313244;
}

/* WORKSPACES */
#workspaces {
    background: transparent;
    margin: 0 5px;
}

#workspaces button {
    padding: 0 12px;
    color: #a6adc8;
    margin: 3px 0;
    border-radius: 6px;
    background: transparent;
    font-size: 14px;
    transition: all 0.3s;
}

#workspaces button.active {
    color: {{WORKSPACE_ACTIVE}};
    background: #313244;
    font-weight: bold;
}

#workspaces button:hover {
    background: #45475a;
    color: #cdd6f4;
}

#workspaces button.urgent {
    color: #f38ba8;
    background: #313244;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { opacity: 1; }
    50% { opacity: 0.5; }
    100% { opacity: 1; }
}

/* WINDOW */
#window {
    color: {{WINDOW_COLOR}};
    background: transparent;
    padding: 0 12px;
    margin: 3px 0;
    border-radius: 6px;
    font-weight: bold;
}

/* NETWORK */
#network {
    color: {{NETWORK_COLOR}};
    background: transparent;
    padding: 0 12px;
    margin: 3px 0;
    border-radius: 6px;
}

#network.disconnected {
    color: #a6adc8;
}

#network:hover {
    background: #313244;
}

/* PULSEAUDIO */
#pulseaudio {
    color: {{PULSEAUDIO_COLOR}};
    background: transparent;
    padding: 0 12px;
    margin: 3px 0;
    border-radius: 6px;
}

#pulseaudio.muted {
    color: #a6adc8;
}

#pulseaudio:hover {
    background: #313244;
}

/* BATTERY */
#battery {
    color: {{BATTERY_COLOR}};
    background: transparent;
    padding: 0 12px;
    margin: 3px 0;
    border-radius: 6px;
}

#battery.charging {
    color: #a6e3a1;
}

#battery.warning:not(.charging) {
    color: #f9e2af;
    animation: blink-warning 3s infinite;
}

#battery.critical:not(.charging) {
    color: #f38ba8;
    animation: blink-critical 1s infinite;
}

@keyframes blink-warning {
    0% { opacity: 1; }
    50% { opacity: 0.5; }
    100% { opacity: 1; }
}

@keyframes blink-critical {
    0% { opacity: 1; }
    50% { opacity: 0.2; }
    100% { opacity: 1; }
}

#battery:hover {
    background: #313244;
}

/* TRAY */
#tray {
    background: #313244;
    padding: 0 12px;
    margin: 3px 0;
    border-radius: 6px;
}

#tray > * {
    padding: 0 6px;
}

/* WALLPAPER BUTTON */
#custom-wallpaper {
    color: #cba6f7;
    background: transparent;
    padding: 0 12px;
    margin: 3px 0;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s;
}

#custom-wallpaper:hover {
    background: #313244;
    color: #f5c2e7;
}

/* THEME BUTTON */
#custom-theme {
    color: #cba6f7;
    background: transparent;
    padding: 0 12px;
    margin: 3px 0;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s;
}

#custom-theme:hover {
    background: #313244;
    color: #f5c2e7;
}

/* PERFORMANCE BUTTON */
#custom-performance {
    color: #f9e2af;
    background: transparent;
    padding: 0 12px;
    margin: 3px 0;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s;
}

#custom-performance:hover {
    background: #313244;
    color: #a6e3a1;
}

/* POWER BUTTON */
#custom-power {
    color: #f38ba8;
    background: transparent;
    padding: 0 12px;
    margin: 3px 5px 3px 0;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s;
}

#custom-power:hover {
    background: #313244;
    color: #f5c2e7;
}
EOF

# Define themes
cat > "$THEME_DIR/themes.json" << 'EOF'
{
"green": {
    "hypr_border": "rgba(00ff99ee) rgba(00ff99ee) 45deg",
    "kitty_foreground": "#00ff99",
    "kitty_background": "#1e1e2e",
    "mako_border": "#00ff99",
    "mako_bg": "#1e1e2e", 
    "mako_progress": "#00ff99",
    "waybar_bg": "rgba(21, 18, 27, 0.95)",
    "waybar_border": "#00ff99",
    "clock_color": "#00ff99",
    "workspace_active": "#00ff99",
    "window_color": "#00ff99",
    "network_color": "#00ff99",
    "pulseaudio_color": "#00ff99",
    "battery_color": "#00ff99",
    "kvantum_theme": "KvGnomeDark"
  },
  "blue": {
    "hypr_border": "rgba(33ccffee) rgba(0088ffee) 45deg",
    "kitty_foreground": "#33ccff",
    "kitty_background": "#1e1e2e",
    "mako_border": "#33ccff",
    "mako_bg": "#1e1e2e",
    "mako_progress": "#33ccff",
    "waybar_bg": "rgba(21, 18, 27, 0.95)",
    "waybar_border": "#33ccff",
    "clock_color": "#33ccff",
    "workspace_active": "#33ccff",
    "window_color": "#33ccff",
    "network_color": "#33ccff",
    "pulseaudio_color": "#33ccff",
    "battery_color": "#33ccff",
    "kvantum_theme": "KvGnome"
  },
  "pink": {
    "hypr_border": "rgba(ff66ccee) rgba(ff33aaee) 45deg",
    "kitty_foreground": "#ff66cc",
    "kitty_background": "#1e1e2e", 
    "mako_border": "#ff66cc",
    "mako_bg": "#1e1e2e",
    "mako_progress": "#ff66cc",
    "waybar_bg": "rgba(21, 18, 27, 0.95)",
    "waybar_border": "#ff66cc",
    "clock_color": "#ff66cc",
    "workspace_active": "#ff66cc",
    "window_color": "#ff66cc",
    "network_color": "#ff66cc",
    "pulseaudio_color": "#ff66cc",
    "battery_color": "#ff66cc",
    "kvantum_theme": "KvOxygen"
  },
  "purple": {
    "hypr_border": "rgba(cc66ffee) rgba(9933ccee) 45deg",
    "kitty_foreground": "#cc66ff",
    "kitty_background": "#1e1e2e",
    "mako_border": "#cc66ff",
    "mako_bg": "#1e1e2e",
    "mako_progress": "#cc66ff",
    "waybar_bg": "rgba(21, 18, 27, 0.95)",
    "waybar_border": "#cc66ff",
    "clock_color": "#cc66ff",
    "workspace_active": "#cc66ff",
    "window_color": "#cc66ff",
    "network_color": "#cc66ff",
    "pulseaudio_color": "#cc66ff",
    "battery_color": "#cc66ff",
    "kvantum_theme": "KvSimplicityDarkLight"
  }
}
EOF

# Show theme selection with wofi
selected_theme=$(echo -e "🟢 Green\n🔵 Blue\n💖 Pink\n💜 Purple" | wofi --dmenu --prompt "🎨 Select Theme" --height 200 --width 300)

if [[ -z "$selected_theme" ]]; then
    exit 0
fi

# Map selection to theme names
case "$selected_theme" in
    "🟢 Green") theme="green" ;;
    "🔵 Blue") theme="blue" ;;
    "💖 Pink") theme="pink" ;;
    "💜 Purple") theme="purple" ;;
    *) exit 1 ;;
esac

# Get theme data
theme_data=$(jq -r ".$theme" "$THEME_DIR/themes.json")

# Apply Hyprland changes - IMPROVED VERSION
if [[ -f "$HOME/.config/hypr/hyprland.conf" ]]; then
    # Backup original
    cp "$HOME/.config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf.backup"
    
    # Get the new border color
    new_border=$(echo "$theme_data" | jq -r '.hypr_border')
    
    # Use more flexible sed pattern to match any col.active_border line
    sed -i "s|col.active_border = .*|col.active_border = ${new_border}|g" "$HOME/.config/hypr/hyprland.conf"
    
    # Alternative method if above doesn't work
    if ! grep -q "col.active_border = ${new_border}" "$HOME/.config/hypr/hyprland.conf"; then
        echo "⚠️  First method failed, trying alternative..."
        # Remove any existing col.active_border lines and add new one
        sed -i "/col.active_border = /d" "$HOME/.config/hypr/hyprland.conf"
        # Insert after general { section
        sed -i "/general {/a\    col.active_border = ${new_border}" "$HOME/.config/hypr/hyprland.conf"
    fi
fi

# Apply Kitty changes
if [[ -f "$HOME/.config/kitty/kitty.conf" ]]; then
    sed -i "s|^foreground .*|foreground $(echo "$theme_data" | jq -r '.kitty_foreground')|" "$HOME/.config/kitty/kitty.conf"
    sed -i "s|^background .*|background $(echo "$theme_data" | jq -r '.kitty_background')|" "$HOME/.config/kitty/kitty.conf"
fi

# Apply Mako changes
if [[ -f "$HOME/.config/mako/config" ]]; then
    sed -i "s|border-color=.*|border-color=$(echo "$theme_data" | jq -r '.mako_border')|" "$HOME/.config/mako/config"
    sed -i "s|background-color=.*|background-color=$(echo "$theme_data" | jq -r '.mako_bg')|" "$HOME/.config/mako/config"
    sed -i "s|progress-color=.*|progress-color=over $(echo "$theme_data" | jq -r '.mako_progress')|" "$HOME/.config/mako/config"
fi

# Apply Waybar CSS changes
if [[ -f "$THEME_DIR/waybar-style-template.css" ]]; then
    # Get theme colors
    waybar_bg=$(echo "$theme_data" | jq -r '.waybar_bg')
    waybar_border=$(echo "$theme_data" | jq -r '.waybar_border')
    clock_color=$(echo "$theme_data" | jq -r '.clock_color')
    workspace_active=$(echo "$theme_data" | jq -r '.workspace_active')
    window_color=$(echo "$theme_data" | jq -r '.window_color')
    network_color=$(echo "$theme_data" | jq -r '.network_color')
    pulseaudio_color=$(echo "$theme_data" | jq -r '.pulseaudio_color')
    battery_color=$(echo "$theme_data" | jq -r '.battery_color')
    
    # Create new CSS from template
    cat "$THEME_DIR/waybar-style-template.css" | \
        sed "s|{{WAYBAR_BG}}|${waybar_bg}|g" | \
        sed "s|{{WAYBAR_BORDER}}|${waybar_border}|g" | \
        sed "s|{{CLOCK_COLOR}}|${clock_color}|g" | \
        sed "s|{{WORKSPACE_ACTIVE}}|${workspace_active}|g" | \
        sed "s|{{WINDOW_COLOR}}|${window_color}|g" | \
        sed "s|{{NETWORK_COLOR}}|${network_color}|g" | \
        sed "s|{{PULSEAUDIO_COLOR}}|${pulseaudio_color}|g" | \
        sed "s|{{BATTERY_COLOR}}|${battery_color}|g" > "$HOME/.config/waybar/style.css"
fi

# Apply Kvantum theme if available
if command -v kvantummanager &> /dev/null; then
    kvantum_theme=$(echo "$theme_data" | jq -r '.kvantum_theme')
    kvantummanager --set "$kvantum_theme" 2>/dev/null || true
fi

# Reload applications
hyprctl reload
pkill -USR1 kitty
pkill waybar && waybar &
makoctl reload

# Notification
notify-send "🎨 Theme Changed" "Applied $theme theme" -t 3000

echo "✅ Theme switched to $theme"
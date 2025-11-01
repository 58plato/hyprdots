#!/bin/bash

CONFIG_DIR="$HOME/.config/hypr"
PERFORMANCE_MODE_FILE="$CONFIG_DIR/.performance_mode"
ORIGINAL_CONFIG="$CONFIG_DIR/hyprland.conf"
BACKUP_CONFIG="$CONFIG_DIR/hyprland.conf.backup"

# Check current mode
if [[ -f "$PERFORMANCE_MODE_FILE" ]]; then
    # Performance mode active → switch to NORMAL
    rm -f "$PERFORMANCE_MODE_FILE"
    echo "🔄 Switching to NORMAL mode..."
    
    # Restore from BACKUP config
    if [[ -f "$BACKUP_CONFIG" ]]; then
        cp "$BACKUP_CONFIG" "$ORIGINAL_CONFIG"
        echo "✅ Restored original config from backup"
    else
        echo "❌ No backup config found!"
        return 1
    fi
    
else
    # Normal mode → switch to PERFORMANCE
    touch "$PERFORMANCE_MODE_FILE"
    echo "🚀 Switching to PERFORMANCE mode..."
    
    # Backup original config first
    if [[ ! -f "$BACKUP_CONFIG" ]]; then
        cp "$ORIGINAL_CONFIG" "$BACKUP_CONFIG"
        echo "✅ Original config backed up"
    fi
    
    # Create performance config
    cat > "$ORIGINAL_CONFIG" << 'CONFIGEOF'
# HYPRLAND PERFORMANCE MODE
# Auto-generated - Performance mode active

monitor=,preferred,auto,1

exec-once = waybar
exec-once = mako

input {
    kb_layout = tr
    follow_mouse = 1
}

general {
    gaps_in = 1
    gaps_out = 2
    border_size = 1
    col.active_border = rgba(33ccffee)
    col.inactive_border = rgba(595959aa)
    layout = dwindle
}

# ANIMATIONS DISABLED
animations {
    enabled = no
}

# BLUR DISABLED
decoration {
    rounding = 1
    blur {
        enabled = no
    }
    shadow {
        enabled = no
    }
    active_opacity = 1.0
    inactive_opacity = 1.0
}

dwindle {
    pseudotile = yes
    preserve_split = yes
}

misc {
    disable_autoreload = yes
    disable_splash_rendering = yes
    mouse_move_enables_dpms = no
    key_press_enables_dpms = no
    force_default_wallpaper = 0
}

# Window rules
windowrulev2 = float, class:^(pavucontrol)$
windowrulev2 = float, class:^(blueman-manager)$
windowrulev2 = float, class:^(nm-connection-editor)$
windowrulev2 = float, title:^(File Open)$
windowrulev2 = float, title:^(Save As)$
windowrulev2 = center, class:^(pavucontrol)$

# Keybinds
$mainMod = SUPER

bind = $mainMod, return, exec, kitty
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, nemo
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, wofi --show drun
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,
bind = $mainMod, F, fullscreen,

# Workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5

bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5

# Screenshots
bind = $mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy
bind = , Print, exec, grim - | wl-copy

# Multimedia
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl set 5%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl set 5%-

# Performance mode toggle
bind = $mainMod SHIFT, P, exec, ~/.config/hypr/scripts/performance-mode.sh
CONFIGEOF

    echo "✅ Performance config activated"
fi

# Reload waybar
pkill waybar
waybar &

# Reload Hyprland
echo "🔄 Reloading Hyprland..."
hyprctl reload

# Send notification
if command -v notify-send &>/dev/null && pgrep mako >/dev/null; then
    if [[ -f "$PERFORMANCE_MODE_FILE" ]]; then
        notify-send "🚀 Performance Mode" "Animations disabled - System optimized"
    else
        notify-send "🎨 Normal Mode" "Animations and effects enabled"
    fi
fi

echo "✅ Mode switching completed!"

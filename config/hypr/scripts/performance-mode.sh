#!/bin/bash

CONFIG_DIR="$HOME/.config/hypr"
PERFORMANCE_MODE_FILE="$CONFIG_DIR/.performance_mode"
MAIN_CONFIG="$CONFIG_DIR/hyprland.conf"
BACKUP_CONFIG="$CONFIG_DIR/hyprland.conf.backup"

# Check current mode
if [[ -f "$PERFORMANCE_MODE_FILE" ]]; then
    # Performance mode active → switch to NORMAL
    rm -f "$PERFORMANCE_MODE_FILE"
    echo "🎨 Switching to NORMAL mode..."
    
    # Restore original config from backup
    if [[ -f "$BACKUP_CONFIG" ]]; then
        cp "$BACKUP_CONFIG" "$MAIN_CONFIG"
        echo "✅ Restored original config from backup"
    else
        echo "❌ No backup config found!"
        exit 1
    fi
    
else
    # Normal mode → switch to PERFORMANCE
    touch "$PERFORMANCE_MODE_FILE"
    echo "🚀 Switching to PERFORMANCE mode..."
    
    # Backup original config first
    if [[ ! -f "$BACKUP_CONFIG" ]]; then
        cp "$MAIN_CONFIG" "$BACKUP_CONFIG"
        echo "✅ Original config backed up"
    fi
    
    # Create performance config
    cat > "$MAIN_CONFIG" << 'CONFIGEOF'
monitor=,preferred,auto,1

$terminal = kitty
$fileManager = nemo
$menu = wofi --show drun

exec-once = waybar
exec-once = mako
exec-once = swww-daemon

general {
    gaps_in = 1
    gaps_out = 2
    border_size = 1
    col.active_border = rgba(33ccffee)
    col.inactive_border = rgba(595959aa)
    resize_on_border = false
    allow_tearing = false
    layout = dwindle
}

decoration {
    rounding = 0
    active_opacity = 1.0
    inactive_opacity = 1.0
    
    blur {
        enabled = false
    }
    
    shadow {
        enabled = false
    }
}

animations {
    enabled = no
}

dwindle {
    pseudotile = true
    preserve_split = true
}

master {
    new_status = master
}

misc {
    force_default_wallpaper = -1
    disable_hyprland_logo = false
}

input {
    kb_layout = tr
    follow_mouse = 1
    sensitivity = 0
    
    touchpad {
        natural_scroll = false
    }
}

device {
    name = epic-mouse-v1
    sensitivity = -0.5
}

$mainMod = SUPER

bind = $mainMod, return, exec, $terminal
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, $menu
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,

bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

bindl = , XF86AudioNext, exec, playerctl next
bindl = , XF86AudioPause, exec, playerctl play-pause
bindl = , XF86AudioPlay, exec, playerctl play-pause
bindl = , XF86AudioPrev, exec, playerctl previous

bind = $mainMod SHIFT, Print, exec, grim -g "$(slurp)" - | swappy -f - -o - | wl-copy
bind = , Print, exec, grim - | swappy -f - -o - | wl-copy

bind = $mainMod SHIFT, P, exec, ~/.config/hypr/scripts/performance-mode.sh

windowrulev2 = float, class:^(pavucontrol)$
windowrulev2 = float, class:^(blueman-manager)$
windowrulev2 = float, class:^(nm-connection-editor)$
windowrulev2 = float, title:^(File Open)$
windowrulev2 = float, title:^(Save As)$
windowrulev2 = center, class:^(pavucontrol)$
windowrulev2 = size 800 600, class:^(pavucontrol)$
windowrulev2 = suppressevent maximize, class:.*
windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
windowrulev2 = float,class:^(kitty)$
windowrulev2 = float, title:^(Friends List)$
windowrulev2 = float, title:^(Profile)$
windowrulev2 = float, title:^(Volume Control)$
CONFIGEOF

    echo "✅ Performance config activated"
fi

# Reload Hyprland
echo "🔄 Reloading Hyprland..."
hyprctl reload

# Send notification
if command -v notify-send &>/dev/null; then
    if [[ -f "$PERFORMANCE_MODE_FILE" ]]; then
        notify-send "🚀 Performance Mode" "Animations disabled - Maximum performance"
    else
        notify-send "🎨 Normal Mode" "All animations and effects enabled"
    fi
fi

echo "✅ Mode switching completed!"

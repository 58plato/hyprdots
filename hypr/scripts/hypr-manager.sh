#!/bin/bash

CONFIG_DIR="$HOME/.config/hypr"
CONFIG_FILE="$CONFIG_DIR/hyprland.conf"
BACKUP_DIR="$CONFIG_DIR/backups"

# Create backup directory
mkdir -p "$BACKUP_DIR"

show_help() {
    echo "🎯 Hyprland Config Manager"
    echo ""
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  backup     - Backup current config"
    echo "  restore    - Restore latest backup"
    echo "  list       - List all backups"
    echo "  edit       - Edit config and auto-backup"
    echo "  diff       - Show recent changes"
    echo "  clean      - Clean old backups (older than 7 days)"
    echo "  status     - Show config status"
    echo ""
    echo "Example: $0 edit"
}

create_backup() {
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_file="$BACKUP_DIR/hyprland_$timestamp.conf"
    
    cp "$CONFIG_FILE" "$backup_file"
    echo "✅ Backup created: $(basename "$backup_file")"
    
    # Keep only last 10 backups
    ls -t "$BACKUP_DIR"/hyprland_*.conf | tail -n +11 | xargs -r rm
}

restore_backup() {
    local latest_backup=$(ls -t "$BACKUP_DIR"/hyprland_*.conf 2>/dev/null | head -1)
    
    if [[ -z "$latest_backup" ]]; then
        echo "❌ No backups found"
        return 1
    fi
    
    echo "🔁 Restoring: $(basename "$latest_backup")"
    cp "$latest_backup" "$CONFIG_FILE"
    hyprctl reload
    echo "✅ Config restored and Hyprland reloaded"
}

list_backups() {
    echo "📂 Backups:"
    ls -lt "$BACKUP_DIR"/hyprland_*.conf 2>/dev/null | head -10
}

edit_config() {
    # Create backup first
    create_backup
    
    # Edit config
    nano "$CONFIG_FILE"
    
    # Check for changes
    if ! diff "$CONFIG_FILE" "$BACKUP_DIR"/$(ls -t "$BACKUP_DIR"/hyprland_*.conf | head -1) >/dev/null; then
        echo "📝 Changes detected, creating new backup..."
        create_backup
    fi
    
    # Reload Hyprland
    echo "🔄 Reloading Hyprland..."
    hyprctl reload
}

show_diff() {
    local latest_backup=$(ls -t "$BACKUP_DIR"/hyprland_*.conf 2>/dev/null | head -1)
    
    if [[ -z "$latest_backup" ]]; then
        echo "❌ No backups found"
        return 1
    fi
    
    echo "📊 Changes since last backup:"
    diff "$latest_backup" "$CONFIG_FILE" || echo "No changes detected"
}

clean_backups() {
    echo "🧹 Cleaning backups older than 7 days..."
    find "$BACKUP_DIR" -name "hyprland_*.conf" -mtime +7 -delete
    echo "✅ Old backups cleaned"
}

show_status() {
    echo "📊 Config Status:"
    echo "   Config file: $CONFIG_FILE"
    echo "   Backup dir:  $BACKUP_DIR"
    echo "   Total backups: $(ls "$BACKUP_DIR"/hyprland_*.conf 2>/dev/null | wc -l)"
    echo "   Last modified: $(stat -c %y "$CONFIG_FILE" 2>/dev/null || echo "Unknown")"
}

# Main execution
case "${1:-}" in
    "backup")
        create_backup
        ;;
    "restore")
        restore_backup
        ;;
    "list")
        list_backups
        ;;
    "edit")
        edit_config
        ;;
    "diff")
        show_diff
        ;;
    "clean")
        clean_backups
        ;;
    "status")
        show_status
        ;;
    "help"|"-h"|"--help")
        show_help
        ;;
    *)
        echo "❌ Invalid option"
        show_help
        ;;
esac

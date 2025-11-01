#!/bin/bash

# Hyprdots Update Script
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔄 Hyprdots Update Script${NC}"
echo -e "${BLUE}========================${NC}"

print_status() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }

# Backup current config
backup_config() {
    print_status "Backing up current configuration..."
    
    BACKUP_DIR="$HOME/.config/hyprdots-backup-$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    # Backup important configs
    cp -r ~/.config/hypr "$BACKUP_DIR/" 2>/dev/null || true
    cp -r ~/.config/waybar "$BACKUP_DIR/" 2>/dev/null || true
    cp -r ~/.config/kitty "$BACKUP_DIR/" 2>/dev/null || true
    cp -r ~/.config/mako "$BACKUP_DIR/" 2>/dev/null || true
    cp -r ~/.config/wofi "$BACKUP_DIR/" 2>/dev/null || true
    
    print_status "Backup created: $BACKUP_DIR"
}

# Update from git repo
update_from_git() {
    print_status "Checking for updates..."
    
    # Get current directory
    CURRENT_DIR=$(pwd)
    
    # Check if we're in a git repository
    if [ ! -d ".git" ]; then
        print_error "Not a git repository. Please run this from hyprdots directory."
        exit 1
    fi
    
    # Fetch latest changes
    git fetch origin
    
    # Check if update is needed
    LOCAL_COMMIT=$(git rev-parse HEAD)
    REMOTE_COMMIT=$(git rev-parse origin/main)
    
    if [ "$LOCAL_COMMIT" = "$REMOTE_COMMIT" ]; then
        print_status "Already up to date!"
        return 1
    fi
    
    print_status "New version available! Updating..."
    
    # Create backup before updating
    backup_config
    
    # Pull latest changes
    git pull origin main
    
    return 0
}

# Preserve user customizations
preserve_customizations() {
    print_status "Preserving user customizations..."
    
    # Preserve keyboard layout
    if [ -f ~/.config/hypr/hyprland.conf ]; then
        USER_LAYOUT=$(grep "kb_layout" ~/.config/hypr/hyprland.conf | head -1 | awk '{print $3}')
        if [ ! -z "$USER_LAYOUT" ]; then
            sed -i "s/kb_layout = .*/kb_layout = $USER_LAYOUT/g" hyprland.conf
            print_status "Preserved keyboard layout: $USER_LAYOUT"
        fi
    fi
    
    # Preserve performance mode setting
    if [ -f ~/.config/hypr/.performance_mode ]; then
        cp ~/.config/hypr/.performance_mode .performance_mode.tmp 2>/dev/null || true
    fi
}

# Update packages
update_packages() {
    print_status "Updating system packages..."
    
    read -p "Update system packages? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        yay -Syu --noconfirm
        print_status "System packages updated"
    fi
}

# Copy updated configs
copy_updated_configs() {
    print_status "Copying updated configuration files..."
    
    # Copy updated files
    cp hyprland.conf ~/.config/hypr/ 2>/dev/null || true
    cp scripts/* ~/.config/hypr/scripts/ 2>/dev/null || true
    cp waybar/* ~/.config/waybar/ 2>/dev/null || true
    cp kitty/* ~/.config/kitty/ 2>/dev/null || true
    cp mako/* ~/.config/mako/ 2>/dev/null || true
    cp wofi/* ~/.config/wofi/ 2>/dev/null || true
    
    # Restore performance mode setting
    if [ -f .performance_mode.tmp ]; then
        cp .performance_mode.tmp ~/.config/hypr/.performance_mode 2>/dev/null || true
        rm .performance_mode.tmp
    fi
    
    # Set permissions
    chmod +x ~/.config/hypr/scripts/*.sh 2>/dev/null || true
    
    print_status "Updated configuration files copied"
}

# Reload services
reload_services() {
    print_status "Reloading services..."
    
    # Reload Hyprland if running
    if pgrep -x "hyprland" > /dev/null; then
        hyprctl reload
        print_status "Hyprland reloaded"
    fi
    
    # Reload Waybar if running
    if pgrep -x "waybar" > /dev/null; then
        pkill waybar
        waybar &
        print_status "Waybar reloaded"
    fi
    
    # Reload Mako if running
    if pgrep -x "mako" > /dev/null; then
        pkill mako
        mako &
        print_status "Mako reloaded"
    fi
}

# Show update summary
show_summary() {
    echo -e "${GREEN}"
    echo "🎉 Update completed!"
    echo ""
    echo "📋 Update Summary:"
    echo "   ✅ Backup created"
    echo "   ✅ Repository updated" 
    echo "   ✅ Customizations preserved"
    echo "   ✅ Config files updated"
    echo "   ✅ Services reloaded"
    echo ""
    echo "📝 Backup location: $BACKUP_DIR"
    echo "   (Keep this for 1-2 days in case you need to revert)"
    echo ""
    echo "🔄 Changes will take effect immediately for running services."
    echo -e "${NC}"
}

# Main update function
main() {
    echo -e "${YELLOW}Starting update process...${NC}"
    
    if update_from_git; then
        preserve_customizations
        copy_updated_configs
        reload_services
        show_summary
    else
        echo -e "${YELLOW}No updates found.${NC}"
        read -p "Update system packages instead? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            update_packages
        fi
    fi
}

# Run main function
main

#!/bin/bash

# Hyprdots Installer for Arch Linux
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🐧 Hyprdots Installer${NC}"
echo -e "${BLUE}=====================${NC}"

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Please do not run as root${NC}"
    exit 1
fi

print_status() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }

# Install yay if not present
install_yay() {
    if ! command -v yay &> /dev/null; then
        print_warning "yay not found. Installing yay..."
        sudo pacman -S --needed git base-devel --noconfirm
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd ..
        rm -rf /tmp/yay
        print_status "yay installed successfully"
    fi
}

# Install required packages
install_packages() {
    print_status "Installing Hyprland and dependencies..."
    
    yay -S --needed \
        hyprland \
        waybar \
        mako \
        swww \
        wofi \
        kitty \
        pipewire\
        nemo \
        grim \
        slurp \
        swappy \
        wireplumber \
        brightnessctl \
        playerctl \
        ttf-jetbrains-mono-nerd \
        noto-fonts \
        noto-fonts-emoji \
        wlogout \
        networkmanager \
        network-manager-applet \
        pulseaudio \
        pulseaudio-alsa \
        pavucontrol \
        jq \
        polkit-kde-agent \
        xdg-desktop-portal-hyprland \
        --noconfirm
    
    if [ $? -eq 0 ]; then
        print_status "All packages installed successfully!"
    else
        print_error "Package installation failed!"
        exit 1
    fi
}

# Create directory structure
create_directories() {
    print_status "Creating directory structure..."
    
    mkdir -p ~/.config/hypr
    mkdir -p ~/.config/waybar
    mkdir -p ~/.config/kitty
    mkdir -p ~/.config/mako
    mkdir -p ~/.config/wofi
    mkdir -p ~/.config/hypr/scripts
    mkdir -p ~/Pictures/wallpaper
    mkdir -p ~/Pictures/screenshots
    
    print_status "Directories created"
}

# Copy configuration files
copy_configs() {
    print_status "Copying configuration files..."
    
    # Check if we're in the repo directory
    if [ ! -f "install.sh" ]; then
        print_error "Please run this script from the hyprdots directory!"
        exit 1
    fi
    
    # Copy hyprland config and scripts
    if [ -f "hyprland.conf" ]; then
        cp hyprland.conf ~/.config/hypr/
    fi
    
    if [ -d "scripts" ]; then
        cp scripts/* ~/.config/hypr/scripts/ 2>/dev/null || true
    fi
    
    # Copy waybar config
    if [ -f "waybar/config" ]; then
        cp waybar/config ~/.config/waybar/
        cp waybar/style.css ~/.config/waybar/
    fi
    
    # Copy kitty config
    if [ -f "kitty/kitty.conf" ]; then
        cp kitty/kitty.conf ~/.config/kitty/
    fi
    
    # Copy mako config
    if [ -f "mako/config" ]; then
        cp mako/config ~/.config/mako/
        cp mako/style.css ~/.config/mako/
    fi
    
    # Copy wofi config
    if [ -f "wofi/config" ]; then
        cp wofi/config ~/.config/wofi/
        cp wofi/style.css ~/.config/wofi/
    fi
    
    print_status "Configuration files copied"
}

# Set proper permissions
set_permissions() {
    print_status "Setting permissions..."
    if [ -d "~/.config/hypr/scripts" ]; then
        chmod +x ~/.config/hypr/scripts/*.sh 2>/dev/null || true
    fi
    print_status "Permissions set"
}

# Show completion message
show_completion() {
    echo -e "${GREEN}"
    echo "🎉 Installation completed!"
    echo ""
    echo "📝 Quick Start Guide:"
    echo "   1. Log out and select Hyprland from your display manager"
    echo "   2. Or run 'Hyprland' from TTY"
    echo ""
    echo "🎯 Keybinds to remember:"
    echo "   Super + Enter: Terminal (Kitty)"
    echo "   Super + R: App launcher (Wofi)" 
    echo "   Print: Full screenshot + edit"
    echo "   Super + Shift + Print: Area screenshot + edit"
    echo "   Super + Shift + P: Performance mode toggle"
    echo ""
    echo "🛠️  Useful scripts:"
    echo "   ~/.config/hypr/scripts/hypr-manager.sh  - Config backup/restore"
    echo "   ~/.config/hypr/scripts/wallpaper.sh     - Wallpaper selector"
    echo "   ~/.config/hypr/scripts/performance-mode.sh - Performance toggle"
    echo ""
    echo "⭐ Don't forget to add wallpapers to ~/Pictures/wallpaper/"
    echo -e "${NC}"
}

# Main installation function
main() {
    echo -e "${YELLOW}Starting installation...${NC}"
    
    install_yay
    install_packages
    create_directories
    copy_configs
    set_permissions
    show_completion
}

# Run main function
main
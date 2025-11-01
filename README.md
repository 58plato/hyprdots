# 🚀 Hyprdots

**Modern Hyprland configuration for Arch Linux.**

## ✨ Features

- 🎨 **Catppuccin Mocha theme**
- ⚡ **Performance mode toggle**
- 🖼️ **Wallpaper selector**
- ⌨️ **Multiple keyboard layouts**
- 🔧 **Config manager**
- 🔄 **Auto-update script**

## 🚀 Installation

git clone https://github.com/58plato/hyprdots.git
cd hyprdots
chmod +x install.sh
./install.sh

## 🔄 Update

To update your Hyprdots configuration:

cd hyprdots
./update.sh

**Update script features:**
- ✅ Creates backup of your current config
- ✅ Pulls latest changes from GitHub
- ✅ Preserves your keyboard layout
- ✅ Updates config files automatically
- ✅ Reloads Hyprland and services

**Manual update:**
cd hyprdots
git pull origin main
cp -r hyprland.conf ~/.config/hypr/
cp -r scripts/* ~/.config/hypr/scripts/
hyprctl reload

## 🎯 Keybinds

- **Super + Enter**: Terminal
- **Super + R**: App launcher
- **Print**: Screenshot + edit
- **Super + Shift + Print**: Area screenshot + edit
- **Super + Shift + P**: Performance mode

## 🛠️ Scripts

- **hypr-manager.sh**: Config manager
- **wallpaper.sh**: Wallpaper selector
- **performance-mode.sh**: Performance toggle
- **update.sh**: Auto-update

## 🎨 Customization

Edit **~/.config/hypr/hyprland.conf** to change keyboard layout and other settings.

## 📁 File Structure

hyprdots/
├── install.sh
├── update.sh
├── hyprland.conf
├── scripts/
├── waybar/
├── kitty/
├── mako/
└── wofi/

## ❓ FAQ

- **Change keyboard layout** in hyprland.conf
- **Install grim, slurp, swappy** for screenshots
- **Make scripts executable** if not working
- **Backups created** in ~/.config/hyprdots-backup-DATE/

## 📄 License

**MIT License**

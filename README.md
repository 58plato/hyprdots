# Hyprdots - Modern Hyprland Dotfiles

A clean and performant Hyprland configuration for Arch Linux with Turkish keyboard support.

## Features

- Catppuccin Mocha theme throughout
- Performance mode toggle (disables animations)
- Easy wallpaper selector with previews
- Multiple keyboard layouts supported
- Touchpad gestures and smooth scrolling
- Config manager with backup/restore
- Auto-update script for easy maintenance
- Minimal & Fast optimized for productivity

## Quick Install

git clone https://github.com/58plato/hyprdots.git
cd hyprdots
chmod +x install.sh
./install.sh

The installer will ask for your keyboard layout during installation.

## Updating

To update your Hyprdots configuration to the latest version:

cd hyprdots
./update.sh

What the update script does:
- Creates backup of your current config
- Pulls latest changes from GitHub
- Preserves your customizations (keyboard layout, performance mode, etc.)
- Updates config files automatically
- Reloads services (Hyprland, Waybar, Mako)
- Optional system package updates

Manual Update (if you prefer):
cd hyprdots
git pull origin main
cp -r hyprland.conf ~/.config/hypr/
cp -r scripts/* ~/.config/hypr/scripts/
# Restart Hyprland or run: hyprctl reload

## Keybinds

Super + Enter - Terminal (Kitty)
Super + R - App Launcher (Wofi)
Print - Full screenshot + edit
Super + Shift + Print - Area screenshot + edit
Super + Shift + P - Performance mode toggle
Super + 1-10 - Switch workspaces
Super + Shift + 1-10 - Move window to workspace

## Scripts

hypr-manager.sh - Backup, restore, edit config with auto-reload
wallpaper.sh - Select wallpapers with Wofi + preview
performance-mode.sh - Toggle between performance and normal modes
update.sh - Update to latest version with backup protection

## Customization

Wallpapers:
Add your wallpapers to ~/Pictures/wallpaper/ then run:
~/.config/hypr/scripts/wallpaper.sh

Performance Mode:
Toggle animations and effects for better performance:
~/.config/hypr/scripts/performance-mode.sh

Keyboard Layout:
Change keyboard layout by editing:
nano ~/.config/hypr/hyprland.conf
Find: kb_layout = us
Change to your preferred layout

## File Structure

hyprdots/
├── install.sh (Auto-installer)
├── update.sh (Auto-update script)
├── hyprland.conf (Main Hyprland config)
├── scripts/
│   ├── hypr-manager.sh (Config manager)
│   ├── wallpaper.sh (Wallpaper selector)
│   └── performance-mode.sh (Performance toggle)
├── waybar/ (Status bar config)
├── kitty/ (Terminal config)
├── mako/ (Notifications config)
└── wofi/ (App launcher config)

## FAQ

Q: How to change keyboard layout?
A: Edit ~/.config/hypr/hyprland.conf and change kb_layout = us to your preferred layout.

Q: Screenshots not working?
A: Make sure grim, slurp, and swappy are installed.

Q: Performance mode not switching?
A: Check if scripts are executable: chmod +x ~/.config/hypr/scripts/*.sh

Q: How to revert after update?
A: The update script creates backups in ~/.config/hyprdots-backup-DATE/

Q: Update script says "Not a git repository"?
A: Make sure you're running it from the hyprdots directory you cloned.

## Contributing

Feel free to open issues or submit pull requests!

## License

MIT License

Don't forget to star the repo if you find it useful!

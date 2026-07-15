#!/bin/bash
# Commodore OS Vision Theme Installer
# Supports Fedora (DNF) and Debian/Ubuntu (APT)

set -e

echo "================================================"
echo "   Commodore OS Vision Theme Installer"
echo "================================================"

# Helper function to detect OS/Package Manager
detect_pm() {
    if command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v apt-get &>/dev/null; then
        echo "apt"
    else
        echo "unknown"
    fi
}

PM=$(detect_pm)

# 1. Install dependencies
echo "Installing dependencies..."
if [ "$PM" = "dnf" ]; then
    sudo dnf group install -y mate-desktop mate-applications
    sudo dnf install -y cairo-dock conky dconf
elif [ "$PM" = "apt" ]; then
    sudo apt-get update
    sudo apt-get install -y mate-desktop-environment cairo-dock conky-all dconf-cli
else
    echo "Warning: Unknown package manager. Please make sure MATE, Cairo-Dock, Conky, and dconf are installed manually."
fi

# 2. Copy Theme Assets
echo "Installing theme assets..."
mkdir -p ~/.themes ~/.icons ~/.local/share/fonts ~/.config/autostart

# Copy to user directory
cp -r themes/* ~/.themes/
cp -r icons/* ~/.icons/
cp -r fonts/* ~/.local/share/fonts/

# Copy to system-wide directory (needed for Cairo-Dock paths)
echo "Installing assets system-wide (requires sudo)..."
sudo mkdir -p /usr/share/themes /usr/share/icons /usr/share/backgrounds/CommodoreOS
sudo cp -r themes/* /usr/share/themes/
sudo cp -r icons/* /usr/share/icons/
sudo cp -r wallpapers/* /usr/share/backgrounds/CommodoreOS/
sudo chmod -R a+r /usr/share/backgrounds/CommodoreOS/
sudo chmod -R a+X /usr/share/backgrounds/CommodoreOS/

# Rebuild font cache
echo "Updating font cache..."
fc-cache -f

# 3. Copy Configurations
echo "Configuring desktop configs..."
if [ -d "configs/cairo-dock" ]; then
    # Backup existing cairo-dock config
    if [ -d "$HOME/.config/cairo-dock" ]; then
        mv ~/.config/cairo-dock ~/.config/cairo-dock.bak.$(date +%F_%T)
    fi
    cp -r configs/cairo-dock ~/.config/
fi

# Copy autostart items
cp -r configs/autostart/* ~/.config/autostart/ 2>/dev/null || true

# 4. Import dconf MATE Panel settings
if [ -f "configs/mate-settings.dconf" ]; then
    echo "Importing MATE panel and desktop settings..."
    # Import settings to active user dconf database
    dconf load /org/mate/ < configs/mate-settings.dconf
fi

# 5. Apply theme settings via gsettings
echo "Applying GTK, Icon, and Cursor configurations..."
gsettings set org.mate.interface gtk-theme 'CommodoreOS'
gsettings set org.mate.interface icon-theme 'CommodoreOSIcons'
gsettings set org.mate.Marco.general theme 'CommodoreOS'
gsettings set org.mate.peripherals-mouse cursor-theme 'CommodoreOSCursors'
gsettings set org.mate.background picture-filename '/usr/share/backgrounds/CommodoreOS/CommodoreOS_1920x1200.jpg'
gsettings set org.mate.background picture-options 'zoom'

# Restart mate-panel, cairo-dock, and conky if running
if pgrep -x mate-panel &>/dev/null; then
    echo "Reloading MATE panel..."
    DISPLAY=:0 mate-panel --replace >/dev/null 2>&1 &
fi

if pgrep -x cairo-dock &>/dev/null; then
    echo "Reloading Cairo-Dock..."
    killall cairo-dock || true
    sleep 1
    DISPLAY=:0 cairo-dock -k >/dev/null 2>&1 &
fi

if pgrep -x conky &>/dev/null; then
    echo "Reloading Conky..."
    killall conky || true
    sleep 1
    DISPLAY=:0 conky >/dev/null 2>&1 &
fi

echo "================================================"
echo " Installation Complete!"
echo " Log out and log into MATE Desktop to enjoy your Commodore OS Vision theme."
echo "================================================"

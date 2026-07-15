# Commodore OS Vision Theme Pack for MATE

This repository contains the Commodore OS Vision theme, icons, cursors, retro computing fonts, wallpapers, and desktop configs, extracted from Commodore OS Vision 3.1 and packaged for ease of installation on standard Linux distributions running the **MATE Desktop Environment** (tested on Fedora 44 and Debian/Ubuntu).

## Features
*   **GTK Themes**: Includes `CommodoreOS` (main retro-cyber theme), `C64-Esque` (Commodore 64 color scheme), and `GlassyBleu` (the iconic translucent glass border style).
*   **Icon & Cursor Themes**: Packaged cursor set (`CommodoreOSCursors`) and custom cybernetic icon pack (`CommodoreOSIcons`).
*   **Wallpapers**: A collection of high-resolution retro backgrounds, including the classic space theme, Commodore 64 command prompts, and Amiga Boing Ball designs.
*   **Retro Fonts**: Includes original typography such as:
    *   *Amiga*: `Amiga-Regular`
    *   *Atari*: `AtariSmall`
    *   *C64*: `C64 Pro`, `Commodore Angled`, `Commodore Rounded`
    *   *Sci-Fi / Terminals*: `Orbitron` (Black, Bold, Light, Medium), `Furore`, `TerminalVector`
*   **Pre-configured Layouts**: Automation for **Cairo-Dock** (configured with VIC-20/Amiga style icons), **Conky** system monitors, **Compiz** desktop effects (wobbly windows, desktop cube, skydome), and the **Emerald** window decorator (`CommodoreOS` and `CyberHack` themes).
<img width="1920" height="1080" alt="Screenshot at 2026-07-15 16-25-34" src="https://github.com/user-attachments/assets/511fc517-076b-401c-acb7-450ee470b922" />

---

## Installation

### Automated Install (Recommended)
Clone the repository and run the automated installation script:

```bash
git clone https://github.com/rsomonte/commodore-os-vision-theme.git
cd commodore-os-vision-theme
chmod +x install.sh
./install.sh
```

The script will automatically:
1. Detect your package manager and install dependencies (`MATE`, `Cairo-Dock`, `Conky`, `Compiz`, `Emerald`, `dconf`).
2. Install themes and icons system-wide and locally.
3. Install the retro fonts and update the font cache.
4. Load the MATE desktop layouts, Cairo-Dock configurations, Compiz profiles, Emerald themes, and autostart apps.
5. Apply the GTK, cursor, icon, window manager (Compiz), and decorator (Emerald) settings.

---

## Manual Installation

If you prefer to configure the theme manually:

### 1. Install MATE, Cairo-Dock, Conky, Compiz, and Emerald
*   **Fedora**:
    ```bash
    sudo dnf group install "MATE Desktop"
    sudo dnf install cairo-dock conky dconf compiz compiz-manager ccsm emerald emerald-themes simple-ccsm fusion-icon compiz-plugins-main compiz-plugins-extra compiz-plugins-experimental
    ```
*   **Ubuntu / Debian**:
    ```bash
    sudo apt-get install mate-desktop-environment cairo-dock conky-all dconf-cli compiz compiz-boxmenu compizconfig-settings-manager emerald
    ```

### 2. Copy Theme Assets
*   Copy folders inside `themes/` to `~/.themes/` (and `/usr/share/themes/` system-wide).
*   Copy folders inside `icons/` to `~/.icons/` (and `/usr/share/icons/` system-wide).
*   Copy files inside `fonts/` to `~/.local/share/fonts/` and run `fc-cache -f`.
*   Copy images inside `wallpapers/` to `/usr/share/backgrounds/CommodoreOS/` (create this folder).

### 3. Load Configurations
*   Copy `configs/cairo-dock/` to `~/.config/cairo-dock/`.
*   Copy `configs/compiz/` to `~/.config/compiz/`.
*   Copy `configs/.emerald/` to `~/.emerald/`.
*   Copy files inside `configs/autostart/` to `~/.config/autostart/`.
*   Import MATE settings using `dconf`:
    ```bash
    dconf load /org/mate/ < configs/mate-settings.dconf
    ```
*   Set Compiz as MATE's window manager:
    ```bash
    gsettings set org.mate.session.required-components windowmanager 'compiz'
    ```
*   Set Emerald theme:
    ```bash
    emerald --theme CommodoreOS
    ```

---

## Credits
All visual assets, themes, icons, and configurations are intellectual property of their original authors and designers from the **Commodore OS Vision** distribution (Debian/MX Linux spin). Packaged here solely for archive and theme portability.

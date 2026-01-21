Modified from [Isoheptane/dotfiles](https://github.com/Isoheptane/dotfiles/).
# Dotfiles

Managed by [chezmoi](https://www.chezmoi.io/).

## Usage

```sh
# Initialize chezmoi with this repository
./deploy.sh init-apply

# Add a new file to chezmoi source
./deploy.sh add ~/.config/hypr/hyprland.conf

# Apply changes
./deploy.sh apply

# Show differences
./deploy.sh diff

# Update dotfiles from home directory
./deploy.sh update

# Sync with git
./deploy.sh sync
```

## Directory Structure

```
dotfiles/
├── hypr/          # Hyprland config
├── mako/          # Mako notification daemon
├── niri/          # Niri window manager
├── nushell/       # Nushell config
├── waybar/        # Waybar config
├── wofi/          # Wofi launcher
└── deploy.sh      # Deployment script
```
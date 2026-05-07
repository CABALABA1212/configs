#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

backup_and_link() {
    local src="$1"
    local dest="$2"
    local backup="${dest}.bak_$(date +%Y%m%d_%H%M%S)"

    if [ -L "$dest" ] || [ -f "$dest" ]; then
        echo -e "${YELLOW}Exists: $dest${NC}"
        read -p "Backup and overwrite? (y/n): " ans
        if [[ "$ans" =~ ^[Yy]$ ]]; then
            mv "$dest" "$backup"
            echo "Backed up to: $backup"
        else
            echo -e "${RED}Skipped: $dest${NC}"
            return
        fi
    fi

    ln -s "$src" "$dest"
    echo -e "${GREEN}Linked: $dest -> $src${NC}"
}

mkdir -p "$HOME/.config/fish"
backup_and_link "$SCRIPT_DIR/config.fish" "$HOME/.config/fish/config.fish"

backup_and_link "$SCRIPT_DIR/tmux.conf" "$HOME/.tmux.conf"

echo ""
echo "Where to install vimrc?"
echo "1) ~/.vimrc"
echo "2) ~/.config/nvim/init.vim"
read -p "Choice (1 or 2): " choice

if [ "$choice" == "2" ]; then
    mkdir -p "$HOME/.config/nvim"
    backup_and_link "$SCRIPT_DIR/vimrc" "$HOME/.config/nvim/init.vim"
else
    backup_and_link "$SCRIPT_DIR/vimrc" "$HOME/.vimrc"
fi

echo ""
echo -e "${GREEN}Done.${NC}"
echo "Restart terminal or run: source ~/.config/fish/config.fish"

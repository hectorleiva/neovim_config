## Pre

MacOS

```bash
brew install neovim
```

Ubuntu

Make sure neovim 0.9.x is installed

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
```

Install patched fonts from here:
https://www.nerdfonts.com/font-downloads

- Symbols Nerd Font
- Hack Nerd Font

## Setup

```bash
mkdir -p ~/.config/nvim
git clone --depth 1 https://github.com/hectorleiva/neovim_config ~/.config/nvim
```

## Current Keymappings

```bash
vim ~/.config/nvim/lua/hector/core/remap.lua
```

```
<space><space> - Opens telescope to observe all files within the current directory and below

<space>t - Neovim Tree
<space>tt - Open current file in relation to neovim tree

Visual mode + J - Moves selected blocks Down
Visual mode + K - Moves selected blocks Up

<space> + p - Copy/Paste while perserving string into memory

<C-k> - Next error
<C-j> - Previous Error

<space> + s - Replace word you're currently on

# Harpoon
<leader>hm - Harpoons a file
<leader>hp - Jump to prev harpooned file
<leader>hn - Jump to next harpooned file
```

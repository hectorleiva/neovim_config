## Pre

MacOS
```bash
brew install neovim
```

Ubuntu
```bash
sudo apt install neovim
```

https://github.com/wbthomason/packer.nvim#quickstart
```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Setup

```bash
mkdir -p ~/.config/nvim
git clone --depth 1 https://github.com/hectorleiva/neovim_config ~/.config/nvim
vim ~/.config/nvim/lua/hector/packer.lua
```

`packer.lua`

```bash
:PackerSync
```

- Restart `vim` to test.

## Current Keymappings

```bash
vim ~/.config/nvim/lua/hector/remap.lua
```

```
<space><space> - Opens telescope to observe all files within the current directory and below

<space> + q - Open Vim dir view

Visual mode + J - Moves selected blocks Down
Visual mode + K - Moves selected blocks Up

<space> + p - Copy/Paste while perserving string into memory

<C-k> - Next error
<C-j> - Previous Error

<space> + s - Replace word you're currently on

# Harpoon
<space> + a - Harpoons a file
<C-e> - Harpoon toggle menu
```

# Pre

## MacOS

```bash
brew install neovim
```

## Ubuntu

### Install NeoViM

Make sure neovim `0.9.x` is installed by doing the following:

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
mkdir -p /opt/nvim
mv nvim.appimage /opt/nvim/nvim
```

### Python package installation

```bash
pip install -U nginx-language-server
```

### Additional packages

```bash
sudo apt install xclip # for clipboard usage
```

### Update ~/.bashrc or ~/.zshrc

Within `~/.bashrc` or `~/.zshrc`:

```bash
export PATH="$PATH:/opt/nvim/"
```

### Update Fonts

Install patched fonts from here:
https://www.nerdfonts.com/font-downloads

- Symbols Nerd Font
- Hack Nerd Font

### Node.js must be set-up on the host machine for lsp to work

I'm using `nvim` to install Node.js on my host machine using the following script: https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script

# Setup

```bash
mkdir -p ~/.config/nvim
git clone --depth 1 git@github.com:hectorleiva/neovim_config.git ~/.config/nvim
sudo apt install ripgrep # for telescope live_grep to work
```

# Current Keymappings

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

# Diagnostics
<F8> - Pull up the list of issues
```

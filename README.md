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

#### Clipboard support

```bash
sudo apt install xclip # for clipboard usage
```

#### LazyGit

https://github.com/jesseduffield/lazygit?tab=readme-ov-file#ubuntu

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
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

### Additional Global NPM Packages

```bash
npm i -g vscode-langservers-extracted # for eslint to automatically work
```

# Setup

```bash
mkdir -p ~/.config/nvim
git clone --depth 1 git@github.com:hectorleiva/neovim_config.git ~/.config/nvim
sudo apt install ripgrep # for telescope live_grep to work
```

## Github Copilot

Run the following within neovim:

```bash
:Copilot setup
```

and follow the instructions which will include the need to login into Github and to enter the device code presented.

# Current Keymappings

```bash
vim ~/.config/nvim/lua/hector/core/remap.lua
```

```bash
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

# Keep packages up-to-date

Within a ViM session:

```bash
:Lazy
```

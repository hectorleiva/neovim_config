vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

-- Vistual-select blocks of code and move them around with respect to brackets
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Search while keeping the cursor in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Preserve copied buffer while pasting it elsewhere
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Yank to the system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Quick fix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace the word that you are currently on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--Open new tab in current directory
vim.keymap.set("n", "<C-t>", ":tabf %:p:h")

--Tab lines over in normal mode
vim.keymap.set("n", "<tab>", ">>")
vim.keymap.set("n", "<S-tab>", "<<")

--Tab lines in Visual mode
vim.keymap.set("v", "<tab>", ">gv")
vim.keymap.set("v", "<S-tab>", "<gv")

--Firefox VimTab Navigation
vim.keymap.set("n", "<C-S-tab>", ":tabprevious")
vim.keymap.set("n", "<C-tab>", ":tabnext")

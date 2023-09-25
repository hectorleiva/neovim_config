require("hector.remap")
require("hector.set")

-- Close Quickfix list fix after selecting an item from the list
vim.cmd([[autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>]])

--Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

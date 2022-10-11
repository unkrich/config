-- Vim Fugitive remap
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gj', ':diffget //3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gd', ':diffget //2<CR>', { noremap = true, silent = true })

vim.cmd('autocmd!')
    
-- Fixes issue with gutentags
-- vim.g.gutentags_ctags_executable = '/opt/homebrew/Cellar/universal-ctags/HEAD-2052bbf/bin/ctags'

-- Inserts spaces instead of tabs by default
vim.cmd('set expandtab')

-- Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

-- Set highlight on search to highlight current match
vim.o.hlsearch = false

-- Make line numbers relative by default
vim.wo.relativenumber = true

-- Do not save when switching buffers (note: this is now a default on master)
-- AKA when you switch files, you do not have to / it won't save by default
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent and tabs as 4 spaces
-- AKA text wraps will automatically indent
vim.o.breakindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
-- vim.wo.signcolumn = 'yes'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })


-- Map blankline
-- AKA - TODO
-- vim.g.indent_blankline_char = '┊'
-- vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
-- vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
-- vim.g.indent_blankline_char_highlight = 'LineNr'
-- vim.g.indent_blankline_show_trailing_blankline_indent = false


-- CUSTOM REMAPS --

-- Greatest remap ever
vim.api.nvim_set_keymap('n', '<leader>p', '"_dP', { noremap = true, silent = true })
-- Second greatest remap ever
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {noremap = true, silent = true })


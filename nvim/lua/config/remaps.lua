vim.g.mapleader = " " -- Sets leader to space

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true }) -- Copy to the system clipboard THIS IS SYTEM DEPENDENT, TEST

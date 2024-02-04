return {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
        vim.cmd(":TSUpdate")
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            ensure_installed = { "lua" },
            highlight = { enable = true },
        })
    end
}

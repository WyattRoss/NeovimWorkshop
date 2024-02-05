return {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
        vim.cmd(":TSUpdate")
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            auto_install = true,
            highlight = { enable = true },
        })
    end
}

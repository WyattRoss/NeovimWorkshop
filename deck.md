# Zero to LSP
## NeoVim as your editor

---

# Contents in summary
- Why should we use NeoVim?
- Why should we make a configuration ourselves?
- How can we make a configuration in a way that is simple, effective, and extensible?

---

# Why (Neo)Vim?
- Easy to use on a remote server.
- You'll be more inclined to use terminal tools.
- Vim motions are faster (use them, even if you don't switch to nvim).
- Lua configuration is nice.

---

# Why not a pre-existing spin?
- Learning one plugin at a time is quicker and easier.
- Easier to extend on your own.
- If something breaks, you're more likely to know why.
- It's fun :)

---

# What do we need?
- A color scheme.
- A plugin manager.
    - LSP
    - A fuzzy finder
    - Autocompletion
    - A popup terminal (nice to have)

---

# Getting started: Folder Structure
- Your configuration will generally be in one of two places:
    - On Unix-Like systems it will be in `$HOME/.config/nvim`
    - On Windows it will be in `%userprofile%\AppData\Local\nvim`
    - If you're not sure, open neovim and use the command `:echo stdpath("config")`

---

# Folder Structure (continued)

Below is an example of the folder structure of a NeoVim configuration.
```
nvim
├── init.lua
└── lua
   ├── config
   │  ├── init.lua
   │  ├── lazy.lua
   │  ├── remaps.lua
   │  └── set.lua
   └── plugin
      ├── color.lua
      ├── fterm.lua
      ├── lsp.lua
      ├── telescope.lua
      └── treesitter.lua
```

---

# Initialization

```lua
-- init.lua
require("config")
```
`nvim/lua/config` folder. The `init.lua` contained with that folder will be similarly simple.

---

# Settings: Line Numbers and Tabs
Line numbers are a necessity. Even better though are relative line numbers.
```lua
-- lua/config/set.lua
vim.opt.number = true
vim.opt.relativenumber = true
```

And consistent, beautiful tabs:
```lua
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
```

---

# Settings: Grab Bag
Persistent undo progress between sessions:
```lua
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
```
24bit color:
```lua
vim.opt.termguicolors = true
```
Scrolloff:
```lua
vim.opt.scrolloff = 8
```
Diagnostics Column:
```lua
vim.opt.signcolumn = "yes"
```

---

# Remaps: Pure Power
The `<leader>` key is a namespace for user managed shortcuts, by default it is '\\'. It can be remaped like so:
```lua
-- lua/config/remaps.lua
vim.g.mapleader = " " -- Sets leader to space
```

The general recipe for a remap is as follows:
```lua
vim.keymap.set('<mode>', '<shortcut>', '<command>', {<opts>})
```

---

# Two Useful Remaps:

Sometimes fuzzy finding isn't enough, so we like to access the file explorer:
```lua
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
```

Sometimes we need code on our system clipboard, we can do that with another remap:
```lua
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })
```

---

# Plugins!

To add plugins to NeoVim we need a plugin manager. For this example we're going to use [Lazy.nvim](https://github.com/folke/lazy.nvim).

```lua
-- lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugin") -- Sources the plugin folder from earlier to manage plugins from
```
---

# Adding a Color Scheme
```lua
-- lua/plugin/colors.lua
return {
    "EdenEast/nightfox.nvim", -- installs plugin containing the color scheme
    init = function ()
        vim.cmd([[colorscheme carbonfox]]) -- sets color scheme on initialization
    end
}
```

I set up [Nightfox](https://github.com/EdenEast/nightfox.nvim) in this example because it's what I use, but there are plenty of others listed at https://vimcolorschemes.com/.

---

# Telescope: A Fuzzy Finder for the 21st Century

- Fuzzy search across an entire project.
- Extensible, search with dozens of built in filters and any number of custom ones.
- Configurable preview window of whatever file you're navigating to.

```lua
-- lua/plugin/telescope.lua
return {
   {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.5",
      dependencies = { "nvim-lua/plenary.nvim" },
      init = function()
         local builtin = require("telescope.builtin")
         vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) -- File search by name
         vim.keymap.set("n", "<leader>fg", builtin.live_grep, {}) -- Search file contents using ripgrep
         vim.keymap.set("n", "<leader>fb", builtin.buffers, {}) -- Search open buffers
         vim.keymap.set("n", "<leader>fh", builtin.help_tags, {}) -- Search nvim documentation
      end,
   },
}
```

---

# A Terminal Window


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
require("config")
```
This is the entirety of `nvim/init.lua`. Super simple, just pointing to the
`nvim/lua/config` folder. The `init.lua` contained with that folder will be similarly simple.

---

# Settings: Line Numbers and Tabs
Now for `set.lua`.

Line numbers are a necessity. Even better though are relative line numbers.
```lua
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

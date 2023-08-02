# emacs-keys.nvim

Simple Emacs-style keybindings for neovim.

Note that this plugin may overwrite some existing vim keybindings

## Usage

For packer, add this to your `init.lua`:

```lua
use {
  'lumiknit/emacs-keys.nvim',
  config = function()
    require("emacs-keys").setup()
  end
}
```

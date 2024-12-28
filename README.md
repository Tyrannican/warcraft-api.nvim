# World of Warcraft API for Neovim

This plugin is basically just [Ketho WoW API](https://github.com/Ketho/vscode-wow-api/tree/master) but with NeoVim support.

It works by extending your LuaLS LSP client settings with the API definitions for the World of Warcraft API.
Your current settings are remembered and not altered globally.

Full credit to [Ketho](https://github.com/Ketho) for their hard-work implementing the API definitions!

## Required Dependencies

* [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug)

```viml
Plug 'nvim-lua/plenary.nvim'
Plug 'tyrannican/warcraft-api.nvim'
```

Using [dein](https://github.com/Shougo/dein.vim)

```viml
call dein#add('nvim-lua/plenary.nvim')
call dein#add('tyrannican/warcraft-api.nvim')
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    'tyrannican/warcraft-api',
    requires = { { 'nvim-lua/plenary.nvim' } }
}
```

Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    'tyrannican/warcraft-api',
    dependencies = { 'nvim-lua/plenary.nvim' }
}
```

You then run the setup function is whatever way you deem appropriate

Example:

```lua
require('warcraft-api').setup()
```

[lazy.nvim](https://github.com/folke/lazy.nvim) example

```lua
{
    'tyrannican/warcraft-api',
    dependencies = { 'nvim-lua/plenary.nvim' }
    config = function()
        require('warcraft-api').setup()
    end
}
```

### Running checkhealth

Run `:checkhealth warcraft-api` to ensure everything is installed correctly!

## Usage

* Run `:WarcraftApi enable` to enable the API definitions in your current WoW addon project
    * This will download the latest API version (if not downloaded already) and add it to your LSP settings
* Run `:WarcraftApi disable` to disable the API definitions in your current WoW addon project
* Run `:WarcraftApi update` to download the latest version of the API definitions

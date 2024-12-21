# TODO List 

* Remove `force-update` and just make it `update`

* Find a better way to download when enabling the addon

* Find a CLEAN way to reload the open buffers to we can get the API to load in the LSP dynamically
    * Looking at how folke/lazydev.nvim does its buffer reloads

## LSP OnAttach

* Add an new AutoGroup for the Plugin
* Add an OnAttach function that will trigger the reload
* Add a thing to detatch and re-attach all active buffers

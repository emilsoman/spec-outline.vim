spec-outline.vim
================

`<Leader>?` opens a spec outline in a quickfix window when inside a spec file
(Rspec, Jasmine).

To map your custom shortcut, add this to your vimrc.

    map <silent> SHORTCUT :SpecOutlineToggle<CR>

Replace `SHORTCUT` with your keyboard shortcut.

## Installation

This plugin follows the standard runtime path structure, and as such it can be installed with a variety of plugin managers:

*  Pathogen
  *  `git clone https://github.com/emilsoman/spec-outline.vim ~/.vim/bundle/spec-outline.vim`
*  NeoBundle
  *  `NeoBundle 'emilsoman/spec-outline.vim'`
*  Vundle
  *  `Plugin 'emilsoman/spec-outline.vim'`
*  VAM
  *  `call vam#ActivateAddons([ 'spec-outline.vim' ])`
*  manual
  *  copy all of the files into your `~/.vim` directory


## License

MIT License. Copyright (c) 2014 Emil Soman

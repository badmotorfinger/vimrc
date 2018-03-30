## vimrc

My _vimrc configuraiton

Powershell installation script (install-vim.ps1) installs vim (via Chocolatey) and [vim-plug](https://github.com/junegunn/vim-plug) which manages my plugins within Vim.

### Plugins installed by vim-plug, listed in _vimrc are

  - NERD Tree - https://github.com/scrooloose/nerdtree
  - Syntastic - https://github.com/scrooloose/syntastic
  - vim-ps1   - https://github.com/PProvost/vim-ps1
  - ctrlp     - https://github.com/ctrlpvim/ctrlp.vim
  - Powerline - https://github.com/powerline/powerline
  - wombat256 - https://github.com/vim-scripts/wombat256.vim
  - MRU       - https://github.com/yegappan/mru
  
  *Due to Powerline not supporting Windows, the install script does some magic to get it working*

## vimrc configs

Repo should be placed in %USERPROFILE%\source\github\vimrc so that _vimrc and other config files can by symlinked and kept in source control.

`cmd /c mklink /H _vimrc .\source\github\vimrc\_vimrc`
`cmd /c mklink /H _gvimrc .\source\github\vimrc\_gvimrc`

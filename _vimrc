set nocompatible
set encoding=utf-8
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
execute pathogen#infect()

set nobackup 		" don't back up files when saving
set diffexpr=MyDiff()
set clipboard=unnamed	" use the O/S clipboard by default

set number 	" show line numbers
set tw=79 	" width of document
set nowrap 	" don't automatically wrap on load
set fo=t	" don't automatically wrap text when typing

vmap Q gq	" automatically wrap paragraphs of text
nmap Q gqap

set colorcolumn=80
highlight ColorColumn ctermbg=233

vnoremap < <gv
vnoremap > >gv

autocmd vimenter * if !argc() | NERDTree | endif " open NERDTree if no args specified

set rnu " turn on relative file numbers

if has("win32")
    set shell=cmd.exe
    set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive\ -ExecutionPolicy\ RemoteSigned
    set shellpipe=|
    set shellredir=>
endif

let g:syntastic_haskell_checkers = ['ghc_mod'] " On by default, turn it off for html
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['html'] }

function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


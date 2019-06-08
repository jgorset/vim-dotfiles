" Required by Vundle
set nocompatible
set encoding=utf-8
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

set shell=/bin/bash

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sotte/presenting.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'slim-template/vim-slim'
Plugin 'plasticboy/vim-markdown'
Plugin 'kien/ctrlp.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'rking/ag.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'mike-hearn/base16-vim-lightline'
Plugin 'dag/vim-fish'
Plugin 'ryanoasis/vim-devicons'
Plugin 'airblade/vim-gitgutter'
Plugin 'smerrill/vcl-vim-plugin'

" All of your Plugins must be added before the following line
call vundle#end()

" Jump to the marked line and column on ', and only the marked line on `.
nnoremap ' `
nnoremap ` '

" Remap leader to ",".
let mapleader = ","

" Keep 1000 commands worth of history.
set history=1000

" Allow 1000 levels of undo.
set undolevels=1000

" Ignore some files when autocompleting.
set wildignore=*.swp,*.pyc,*.class,*.xcodeproj,*.xcassets,*.lproj,node_modules,spec/tmp

" Change the terminal's title.
set title

" Don't create backup or swap files.
set nobackup
set noswapfile

" Maintain at least 3 lines worth of context around the cursor.
set scrolloff=3

" Show line numbers
set number

" Automatically read changed files
set autoread

" Set lightline options
let g:lightline = {
      \ 'colorscheme': 'base16_eighties',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'directory', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2v', 'line': '%l', 'column': '%c', 'close': '%999X X ', 'winnr': '%{winnr()}',
      \   'percent': '  %3p%% ', 'filename': '  %t '
      \ },
      \ 'component_function': {
      \   'directory': 'LightLineDirectory'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineDirectory()
  return "  " . expand('%:h')
endfunction

" Synchronize vim colorscheme with base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Lightline already displays modes, so don't mirror it in vim
set noshowmode

" Enable syntax highlighting
syntax on

" Load plugins and indentation preferences based on file type.
filetype plugin indent on

" Quickly edit and source ~/.vimrc.
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Map CtrlP to <leader>t
let g:ctrlp_map = '<leader>t'

" Allow opening new files without writing changes first.
set hidden

" Don't wrap lines.
set nowrap

" A tab is 2 spaces.
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Round indentation to multiples of shiftwidth when indenting.
set shiftround

" Enable automatic indentation.
set autoindent
set copyindent

" NERDTree and devicons
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

" Show search matches as you type.
set incsearch

" Set default encoding
set encoding=utf-8

" Disable the arrow keys. You'll thank me later.
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Navigate splits with just Ctrl+hjkl instead of
" Ctrl+w and then hjkl.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remap splitjoin.
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

" Open new splits below below or right of the current split
" instead of above or to the left of it
set splitbelow
set splitright

" Display a list of completion alternatives.
set wildmenu

" Allow deleting anything with backspace.
set backspace=indent,eol,start

" Highlight customization
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=236
hi Directory cterm=NONE ctermfg=white ctermbg=NONE

" Always show the status line.
set laststatus=2

" Customize the status line
set statusline=%f\ (%{&fenc})%=\ %l/%L

" Copy gist URL to clipboard
let g:gist_clip_command = 'pbcopy'

" Set the default register to be the system clipboard
set clipboard=unnamedplus

" Detect the gist filetype from the filename
let g:gist_detect_filetype = 1

" Alias CommandTFlush to CTF
command CTF CommandTFlush

" Navigate open buffers
nmap <Space> :e#<Return>

" vim-markdown
let g:vim_markdown_folding_disabled=1

" NERDTree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.git$','\.sass-cache$', '\.tmp$', '\~$', '\.DS_Store']
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Annotate code with xmpfilter (https://github.com/tnoda/rcodetools)
map <silent> <Leader>a :%!xmpfilter -a --no-warnings<CR>

" Don't highlight Git gutter's sign column
highlight clear SignColumn

" Git cutter
set signcolumn=yes
set updatetime=100
nmap <Leader>j <Plug>GitGutterNextHunk
nmap <Leader>k <Plug>GitGutterPrevHunk

" Create directories upon writing buffers if needed
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
      let dir=fnamemodify(a:file, ':h')
      if !isdirectory(dir)
          call mkdir(dir, 'p')
      endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

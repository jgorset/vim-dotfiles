" Required by Vundle
set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'
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
Plugin 'wincent/command-t'

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
set wildignore=*.swp,*.pyc,*.class,spec/tmp

" Change the terminal's title.
set title

" Don't create backup or swap files.
set nobackup
set noswapfile

" Maintain at least 3 lines worth of context around the cursor.
set scrolloff=3

" Show line numbers
set number

" Set color scheme
colorscheme busybee

" Enable syntax highlighting
syntax on

" Load plugins and indentation preferences based on file type.
filetype plugin indent on

" Quickly edit and source ~/.vimrc.
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

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

" Detect the gist filetype from the filename
let g:gist_detect_filetype = 1

" Alias CommandTFlush to CTF
command CTF CommandTFlush

" Navigate open buffers
nmap <Space> :e#<Return>

" NERDTree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.git$','\.sass-cache$', '\.tmp$', '\~$', '\.DS_Store']
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

" Annotate code with xmpfilter (https://github.com/tnoda/rcodetools)
map <silent> <Leader>a :%!xmpfilter -a --no-warnings<CR>

" Don't highlight Git gutter's sign column
highlight clear SignColumn

" Always show Git gutter
let g:gitgutter_sign_column_always = 1

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

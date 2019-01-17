
" To execute one line:         yy:@"<CR>
" Underline line:              yypVr=
" Go to last opened line in file:         '"
" Go to line where last change occured:   '.
" Open last file edited when exiting vim: '0

set nocompatible
syntax on
colorscheme delek

let mapleader = ','              " change mapleader from \ to ,
set backspace=indent,eol,start   " make backspace work normally, going over everything
set tabstop=4                    " a tabstop is 4 spaces. default 8
set shiftwidth=4                 " use 4 spaces when (auto)indenting w/ cindent, '>>', etc. default 8
set softtabstop=-1               " Use 'shiftwidth' spaces when hitting backspace or <Tab>. default 8
set expandtab                    " expand tabs by default (overwritable per filetype)
set shiftround                   " round indent to multiples of 'shiftwidth' when indenting with '>' and '<'
set autoindent                   " copy indent from current line when starting new line
set scrolloff=4                  " keep 4 lines off the edges of the screen when scrolling
set hidden                       " allow unsaved buffers in the background
set cursorline                   " show line of cursor
set encoding=utf-8
set pastetoggle=<leader>p

" Allow directory-specific .vimrc files, but limit the commands to secure ones
set exrc
set secure

"" Show invisible characters on ,i
set listchars=tab:▸-,trail:·,nbsp:·,eol:$
set nolist                      " don't show invisible characters by default,
noremap <leader>i :set list!<CR>

"" Text wrapping on ,w
set nowrap                           " don't wrap long lines
set sidescroll=5                     " scroll 5 chars to the side at a time
set listchars+=precedes:<,extends:>  " show wrapping characters
noremap <leader>w :set wrap!<CR>

" Turn off search highlighting on ,h
set hlsearch incsearch
nmap <leader>h :set hlsearch! incsearch! <CR>
nmap <leader>h :set hlsearch! incsearch! <CR>

" use \v in searches to use Perl regexp
" use \c in search to ignore case

" Reselect pasted text on ,v
nnoremap <leader>v V`]

" Folding rules (zM close, zR open) {{{
"  toggle w/ za or zA when on fold
"  open all fols w/ zR
"  close all folds w/ zM
set foldenable
set foldcolumn=0         " no folding column
set foldmethod=marker    " use foldmarker - default -{-{-{
set foldnestmax=1
" }}}
" Keep undo history across sessions by storing it in a file {{{
if has('persistent_undo')
    if !isdirectory($HOME."/.vim")
        call mkdir($HOME."/.vim", "", 0770)
    endif

    if !isdirectory($HOME."/.vim/undo-dir")
        call mkdir($HOME."/.vim/undo-dir", "", 0700)
    endif
    set undodir=$HOME/.vim/undo
    set undofile
    set undolevels=1000         " How many undos
    set undoreload=10000        " number of lines to save for undo
endif
" }}}
" Save a file as root with w!! {{{
function SaveAsRoot()
	:w !sudo tee % > /dev/null<CR>
endfunction
cmap w!! w !sudo tee > /dev/null %
" }}}
" Status line {{{
set laststatus=2

set statusline=%<%f                              "file+path
set statusline+=\ %m%r%w                           "modified? readonly? 
"set statusline+=\ %y                                "filetype
"set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}   "encoding
"set statusline+=%{(&bomb?\",bom\":\"\")}            "encoding2
"set statusline+=\ %{&ff}                            "fileformat (dos/unix..) 
set statusline+=\ %=\ %l:%c\ (%p%%)          "rownumber/total (%)
" }}}

call plug#begin('~/.vim/plugged')
"Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'   " Fuzzy finder! Use for Files, Buffers, etc
Plug 'tpope/vim-eunuch'   " Use :Rename, :Chmod, :SudoWrite, :Mkdir
Plug 'tpope/vim-surround' " Change and delete surroundings! ysiw<em>
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/seoul256.vim'
call plug#end()

" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 236
colo seoul256

" Toggle NERDTree on ,t
noremap <leader>t :NERDTreeToggle<CR>

" Toggle number (+ relativenumber) + GitGutter on ,l
"nmap <leader>l :set nu! rnu! gle<CR>
set nu
" let g:gitgutter_signs = 0  " Don't show Gutter signs on startup
noremap <leader>l :set nu! \| GitGutterSignsToggle<CR>
noremap <leader>L :GitGutterLineHighlightsToggle<CR>

nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk

" FZF
noremap ; :Files<CR>
noremap <Tab> :Buffers<CR>
noremap <S-Tab> :Files<CR>
noremap // :Lines<CR>

" Switcht to last buffer on Tab
"noremap <Tab> :b! #<CR>
"noremap <Tab><Tab> :ls<CR>:b!<Space>



" To execute one line:   yy:@"<CR>
" Underline line:        yypVr=

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
"set cursorline                   " show line of cursor
set encoding=utf-8
set pastetoggle=<leader>p

" Allow directory-specific .vimrc files, but limit the commands to secure ones
set exrc
set secure

"" Short invisible characters on ,i
set listchars=tab:▸-,trail:·,nbsp:·,eol:$
set nolist                      " don't show invisible characters by default,
noremap <leader>i :set list!<CR>

"" Text wrapping on ,w
set nowrap                           " don't wrap long lines
set sidescroll=5                     " scroll 5 chars to the side at a time
set listchars+=precedes:<,extends:>  " show wrapping characters
noremap <leader>w :set wrap!<CR>
""""""""""""""""""""""""""""""""""""""""""""""TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTEEEEEEEEEEEEEEEEEEEESSSSSSSSSSSSSSSSTTTTTTTTTTTTTTTTTTTTTT

" Turn of highlighting on ,h
set hlsearch incsearch
nmap <leader>h :set hlsearch! incsearch! <CR>
nmap <leader>h :set hlsearch! incsearch! <CR>

" use \v in searches to use Perl regexp
" use \c in search to ignore case

" Reselect pasted text on ,v
nnoremap <leader>v V`]

" Folding rules {{{
"  toggle w/ za or zA when on fold
"  open all fols w/ zR
"  close all folds w/ zM
set foldenable
set foldcolumn=0         " no folding column
set foldmethod=marker    " use foldmarker - default -{-{-{
set foldnestmax=1
" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep undo history across sessions by storing it in a file
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


" Switcht to last buffer on Tab
"noremap <Tab> :b! #<CR>
"noremap <Tab><Tab> :ls<CR>:b!<Space>

" Save a file as root with w!!
function SaveAsRoot()
	:w !sudo tee % > /dev/null<CR>
endfunction
cmap w!! w !sudo tee > /dev/null %

" Status line
set laststatus=2
set statusline=%q%m%r%F\ %l\/%L%y

set statusline=%0*
set statusline+=\%n                                 "buffernr
set statusline+=\ %<%F                              "File+path
set statusline+=\ %y                                "FileType
set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}   "Encoding
set statusline+=%{(&bomb?\",BOM\":\"\")}            "Encoding2
set statusline+=\ %{&ff}                            "FileFormat (dos/unix..) 
set statusline+=\ %=\ line\ %l/%L\ (%p%%)          "Rownumber/total (%)
set statusline+=\ col\ %c                          "Colnr
set statusline+=\ %m%r%w                           "Modified? Readonly? 

call plug#begin('~/.vim/plugged')
"Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'   " Fuzzy finder! Use for Files, Buffers, etc
Plug 'tpope/vim-eunuch'   " Use :Rename, :Chmod, :SudoWrite, :Mkdir
Plug 'tpope/vim-surround' " Change and delete surroundings! ysiw<em>
call plug#end()

" Toggle number (+ relativenumber) + GitGutter on F3 in normal and insert mode
"nmap <leader>l :set nu! rnu! gle<CR>
let g:gitgutter_signs = 0
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

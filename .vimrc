" ---------------Package Manager-------------------
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim/package_manager/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin($HOME.'/.vim/package_manager/')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('tpope/vim-fugitive')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" You can specify revision/branch/tag.
"call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------


set nocompatible
set term=xterm

scriptencoding utf-8 
set encoding=utf-8
set fileencoding=utf-8

set et
set ts=4
set ru
set backspace=indent,eol,start
set sw=4                        "this is the level of autoindent, adjust to taste
set showmode
set number
set showmatch                   "shows matching braces
set whichwrap+=h,l,<,>,[,]
set so=12 "Start scrolling before cursor reaches bottom

set cursorline
set autoindent
set mouse=a

"Without this, vim has a delay in Tmux when going
"from insert mode to normal mode
set ttimeoutlen=0

filetype on
au Filetype make setlocal noexpandtab

set shortmess=atI

"Searching
set incsearch
set ignorecase
set smartcase

set columns=115

set nobackup
"set backupdir=~/.vim/backup

"Awesomesauce
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.a,*.d,*.dd,*.so,*.pyc,*.pyo,*.tsk
set wildignore+=*/tmp/*,*.swp,*.zip 

set hidden

let mapleader = ","

" ---------------CtrlP-------------------
let g:ctrlp_follow_symlinks = 1 "Follow symlinks without loops
"let g:ctrlp_clear_cache_on_exit = 0 "Clear cache with <F5>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

nmap <silent> <C-Space> :CtrlPBuffer<CR>

" ---------------NERDTree---------------
"Opens NERDTree
map <silent><leader>n :NERDTreeToggle<CR>

""Bookmark, only works in NERDTree buffer
map <leader>b :Bookmark 

"Open Bookmark, only works in NERDTree buffer
map <leader>o :OpenBookmark 

"If NERDTree is only buffer left open, auto closes vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ---------------Tabline---------------
"set guioptions-=m  "menu bar
"set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar

"let g:airline#extensions#tabline#enabled = 1

" ---------------Buffers----------------
"Switch to next/previous buffers
nnoremap [ :bprev<cr>
nnoremap ] :bnext<cr>
"Using Leader brings up list of buffers
nnoremap <leader>,] :buffers<CR>:buffer<SPACE>
nnoremap <leader>,[ :buffers<CR>:buffer<SPACE>

" ---------------Splits----------------
"Switch cursor to different buffers in splits
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

"Move buffers left right up down with arrow keys
nmap <silent>,<Left> :wincmd H<CR> :call MaximizeWithoutResizingQuickfix()<CR>
nmap <silent>,<Right> :wincmd L<CR> :call MaximizeWithoutResizingQuickfix()<CR>
nmap <silent>,<Up> :wincmd K<CR> :call MaximizeWithoutResizingQuickfix()<CR>
nmap <silent>,<Down> :wincmd J<CR>  :call MaximizeWithoutResizingQuickfix()<CR>

"Move buffers left right up down with hlkj
nmap <silent>,h :wincmd H<CR>
nmap <silent>,l :wincmd L<CR>
nmap <silent>,k :wincmd K<CR>
nmap <silent>,j :wincmd J<CR>

:au VimResized * wincmd =

" ---------------Color---------------
set hls                             "sets highlight search
syntax on       
syntax enable
set background=dark

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set t_Co=256
colorscheme xoria256
"colorscheme molokai
"colorscheme solarized

map <F9> :colorscheme desert
map <F10> :colorscheme desert256

map <F7> :colorscheme wombat
map <F8> :colorscheme wombat256

map <F5> :colorscheme molokai
map <F6> :colorscheme xoria256


" -------------AutoComplete-----------
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"


"--------------Status Line------------------
set laststatus=2 "show the status line

"Hide default input/normal mode indicator
set noshowmode
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'

let g:airline_extensions = ['branch', 'ctrlp']

function! AirlineInit()
    let g:airline_section_a = airline#section#create_right(['mode'])
    let g:airline_section_b = airline#section#create_right(['branch'])
    let g:airline_section_c = airline#section#create(['readonly','file'])
    let g:airline_section_x = airline#section#create_left([''])
    let g:airline_section_y = airline#section#create_left(['filetype'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()


"--------------Diffing------------
"set statusline=%-10.3n  "buffer number
" ,2 pulls change from buffer 2
map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>
map <silent> <leader>4 :diffget 4<CR> :diffupdate<CR>

" --------------Macros----------------
"Ctrl-S saves
nnoremap <silent> <C-s> :w!<CR>
map! <silent> <C-s> <Esc>:w!<CR>a

" Next Tab
nnoremap <silent> <S-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <S-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" New Tab
nnoremap <silent> <C-w> :q!<CR>

" Shift-Tab will shift back 1 tab
map <S-tab> <lt><lt> 
map! <S-tab> <BS><BS><BS><BS>

nnoremap <silent> <C-[> <Esc>


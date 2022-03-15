set nocompatible 
" ---------------Package Manager-------------------
call plug#begin()

" Make sure you use single quotes

"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter', { 'on':  'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" ---------------Package Manager-------------------

inoremap <F10> <Esc>
set nocompatible
set term=xterm

scriptencoding utf-8 
set encoding=utf-8
set fileencoding=utf-8

set expandtab
set tabstop=4
set ruler
set backspace=indent,eol,start
set shiftwidth=4                        "this is the level of autoindent, adjust to taste
set showmode
set number
set showmatch  "shows matching braces
set whichwrap+=h,l,<,>,[,]
set so=12  "Start scrolling before cursor reaches bottom

set cursorline
set autoindent
set mouse=a

if has('mouse_sgr')
    set ttymouse=sgr
endif

"Make vim yank and paste sync with system clipboard
set clipboard=unnamed

"Without this, vim has a delay in Tmux when going
"from insert mode to normal mode
set ttimeoutlen=0

filetype plugin indent on 
au Filetype make setlocal noexpandtab

set shortmess=atI

"Searching
set incsearch
set ignorecase
set smartcase

set nobackup
"set backupdir=~/.vim/backup

"Awesomesauce
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.a,*.d,*.dd,*.so,*.pyc,*.pyo,*.tsk
set wildignore+=*/tmp/*,*.swp,*.zip 

set hidden

let mapleader = ","

" ---------------FZF---------------------
" - Popup window (anchored to the bottom of the current window)
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
let g:fzf_layout = { 'down': '40%' }

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --hidden --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nmap <silent> <C-P> :Files<CR>
nmap <silent> <C-F> :BLines<CR>
nmap <silent> <C-G> :RG<CR>
nmap <silent> <NUL> :Buffers<CR>

" ---------------CtrlP-------------------
"let g:ctrlp_follow_symlinks = 1 "Follow symlinks without loops
"let g:ctrlp_clear_cache_on_exit = 0 "Clear cache with <F5>
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }

"nmap <silent> <C-Space> :CtrlPBuffer<CR>

"Get Ctrl-Space to work in vim
"nmap <silent> <NUL> :CtrlPBuffer<CR>

" ---------------NERDTree---------------
"Opens NERDTree
map <silent><leader>f :NERDTreeToggle<CR>

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
nnoremap <leader>] :buffers<CR>:buffer<SPACE>
nnoremap <leader>[ :buffers<CR>:buffer<SPACE>

" ---------------Splits----------------
"Split current buffer
nmap <silent> <leader>s :vsplit<CR>
nmap <silent> <leader>S :split<CR>

"Arrows Switch cursor to different splits
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

"hjkl Switch cursor to different splits
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

"Move split left right up down with arrow keys
nmap <silent> <leader><Left> :wincmd H<CR>
nmap <silent> <leader><Right> :wincmd L<CR>
nmap <silent> <leader><Up> :wincmd K<CR>
nmap <silent> <leader><Down> :wincmd J<CR>>

"Move split left right up down with hlkj
nmap <silent> <leader>h :wincmd H<CR>
nmap <silent> <leader>l :wincmd L<CR>
nmap <silent> <leader>k :wincmd K<CR>
nmap <silent> <leader>j :wincmd J<CR>

:au VimResized * wincmd =

" ---------------Color---------------
set hls                             "sets highlight search
nmap <silent> <leader>n :nohlsearch<CR>
syntax on       
syntax enable

"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set guifont=Hack\ Regular\ 14
set t_Co=256

if (has("termguicolors"))
    set termguicolors
endif

"colorscheme apprentice
"colorscheme xoria256
"colorscheme molokai
"colorscheme solarized
colorscheme onedark

highlight Normal ctermbg=None

map <F9> :colorscheme desert
map <F10> :colorscheme desert256

map <F7> :colorscheme wombat
map <F8> :colorscheme two-firewatch

map <F5> :colorscheme onedark
map <F6> :colorscheme xoria256


" -------------AutoComplete-----------
"  This is simple version, deprecated use version below for more features
"function! Tab_Or_Complete()
"  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
"    return "\<C-N>"
"  else
"    return "\<Tab>"
"  endif
"endfunction
":inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
":set dictionary="/usr/dict/words"


" -------------YouCompleteMe-----------
"let g:ycm_global_ycm_extra_conf=$HOME.'/.vim/.ycm_extra_conf.py'
"
"" Preview
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:airline_exclude_preview = 1
"set splitbelow
"
"" Goto stuff
"let g:ycm_goto_buffer_command = 'horizontal-split'
"nnoremap <leader>g :YcmCompleter GoTo<CR>
"
"" Misc
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_error_symbol = '>>'
"let g:ycm_warning_symbol = '>'
"
"
"" ----------------Snippets--------------
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"
"" expand snippet, close menu or insert newline
"let g:UltiSnipsExpandTrigger = "<NOP>"
"let g:ulti_expand_or_jump_res = 0
"inoremap <silent> <CR> <C-r>=<SID>ExpandSnippetOrReturnEmptyString()<CR>
"function! s:ExpandSnippetOrReturnEmptyString()
"    if pumvisible()
"        let snippet = UltiSnips#ExpandSnippetOrJump()
"        if g:ulti_expand_or_jump_res > 0
"            return snippet
"        else
"            return "\<C-y>\<CR>"
"        endif
"    else
"        return "\<CR>"
"    endif
"endfunction

" This is not used right now in favor of YouCompleteMe
" However we might one day come back and use this instead
" so keeping here for now.
" -------------NeoComplete-----------
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell': $HOME.'/.vimshell_hist',
"    \ 'scheme'  : $HOME.'/.gosh_completions'
"    \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"" <TAB>: completion.
""inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"" <BS>: close popup and delete backword char.
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"
"" Auto close preview pane upon tab completion
"autocmd CompleteDone * if pumvisible() == 0|pclose|endif
"let g:airline_exclude_preview = 1
"set splitbelow
""set completeopt-=preview
"
"" Enable omni completion.
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
"" Use jedi-vim for python completion
"autocmd FileType python setlocal omnifunc=jedi#completions
"let g:jedi#completions_enabled = 0
"let g:jedi#auto_vim_configuration = 0
"let g:jedi#smart_auto_mappings = 0
"
"if !exists('g:neocomplete#force_omni_input_patterns')
"    let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.python ='\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"" alternative pattern: '\h\w*\|[^. \t]\.\w*'
"
"
""--------------Snippets------------------
"" Get tabs to behave properly with snippets and neocomplete
"" From https://github.com/SirVer/ultisnips/issues/519 Hotschke's comments
"let g:UltiSnipsJumpForwardTrigger="<NOP>"
"let g:ulti_expand_or_jump_res = 0
"function! ExpandSnippetOrJumpForwardOrReturnTab()
"    let snippet = UltiSnips#ExpandSnippetOrJump()
"    if g:ulti_expand_or_jump_res > 0
"        return snippet
"    else
"        return "\<TAB>"
"    endif
"endfunction
"
"inoremap <expr> <TAB>
"    \ pumvisible() ? "\<C-n>" :
"    \ "<C-R>=ExpandSnippetOrJumpForwardOrReturnTab()<CR>"
"
"" jump to next placeholder otherwise do nothing
"snoremap <buffer> <silent> <TAB>
"    \ <ESC>:call UltiSnips#JumpForwards()<CR>
"
"" previous menu item, jump to previous placeholder or do nothing
"let g:UltiSnipsJumpBackwordTrigger = "<NOP>"
"inoremap <expr> <S-TAB>
"    \ pumvisible() ? "\<C-p>" :
"    \ "<C-R>=UltiSnips#JumpBackwards()<CR>"
"
"" jump to previous placeholder otherwise do nothing
"snoremap <buffer> <silent> <S-TAB>
"    \ <ESC>:call UltiSnips#JumpBackwards()<CR>
"
"" expand snippet, close menu or insert newline
"let g:UltiSnipsExpandTrigger = "<NOP>"
"let g:ulti_expand_or_jump_res = 0
"inoremap <silent> <CR> <C-r>=<SID>ExpandSnippetOrReturnEmptyString()<CR>
"function! s:ExpandSnippetOrReturnEmptyString()
"    if pumvisible()
"        let snippet = UltiSnips#ExpandSnippetOrJump()
"        if g:ulti_expand_or_jump_res > 0
"            return snippet
"        else
"            return "\<C-y>\<CR>"
"        endif
"    else
"        return "\<CR>"
"    endif
"endfunction
"

"--------------Status Line------------------
set laststatus=2 "show the status line

"Hide default input/normal mode indicator
set noshowmode
let g:airline_powerline_fonts = 1
"let g:airline_theme='jellybeans'
let g:airline_theme='onedark'

let g:airline_extensions = ['branch', 'fzf']

function! AirlineInit()
    let g:airline_section_a = airline#section#create_right(['mode'])
    let g:airline_section_b = airline#section#create_right(['branch'])
    let g:airline_section_c = airline#section#create(['readonly','file'])
    let g:airline_section_x = airline#section#create_left([''])
    let g:airline_section_y = airline#section#create_left(['filetype'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()


"--------------Tmux Line------------------
let g:tmuxline_preset = {
      \'a'    : '#H',
      \'b'    : '#P',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'y'    : '%a, %b %d',
      \'z'    : '#S'}

"--------------Diffing------------
"set statusline=%-10.3n  "buffer number
" ,2 pulls change from buffer 2
map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>
map <silent> <leader>4 :diffget 4<CR> :diffupdate<CR>

" --------------Macros----------------
" Fixes weird issue where Ctrl-S and some other stuff not
" working in a tmux split
silent !stty -ixon > /dev/null 2>/dev/null

"Ctrl-S saves
nnoremap <silent> <C-s> :w!<CR>
inoremap <silent> <C-s> <C-O>:w!<CR>

" Next Tab
nnoremap <silent> <S-Right> :tabnext<CR>
      
" Previous Tab
nnoremap <silent> <S-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Close Tab
nnoremap <silent> <C-w> :q!<CR>

" Shift-Tab will shift back 1 tab
nnoremap <S-tab> <lt><lt> 
inoremap <S-tab> <BS><BS><BS><BS>

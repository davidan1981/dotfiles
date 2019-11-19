" =========================================================================
"                                       
"  ________  ________  ___      ___ ___  ________  ________      
" |\   ___ \|\   __  \|\  \    /  /|\  \|\   ___ \|\   ____\     
" \ \  \_|\ \ \  \|\  \ \  \  /  / | \  \ \  \_|\ \ \  \___|_    
"  \ \  \ \\ \ \   __  \ \  \/  / / \ \  \ \  \ \\ \ \_____  \   
"   \ \  \_\\ \ \  \ \  \ \    / /   \ \  \ \  \_\\ \|____|\  \  
"    \ \_______\ \__\ \__\ \__/ /     \ \__\ \_______\____\_\  \ 
"     \|_______|\|__|\|__|\|__|/       \|__|\|_______|\_________\
"                                                    \|_________|
"  ___      ___ ___  _____ ______                                
" |\  \    /  /|\  \|\   _ \  _   \                              
" \ \  \  /  / | \  \ \  \\\__\ \  \                             
"  \ \  \/  / / \ \  \ \  \\|__| \  \                            
"   \ \    / /   \ \  \ \  \    \ \  \                           
"    \ \__/ /     \ \__\ \__\    \ \__\                          
"     \|__|/       \|__|\|__|     \|__|                          
"
" =========================================================================
"   - To reload this resource file, do <leader>sv which is mapped to 
"     :so $MYVIMRC.
"   - Use 'z' for navigation. For example, zt opens a new tab.
"   - Use 'jj' or 'jk' to get out of insert mode. Try best not to use esc.
" =========================================================================

" This will make plugins recognizable easily
execute pathogen#infect()
command! -nargs=? -bar -bang Goyo call goyo#execute(<bang>0, <q-args>)

" ====================
" Basic configurations
" ====================
syntax on
filetype on
filetype plugin on
" set shellcmdflag=-ic
set enc=utf-8
set backspace=2
set laststatus=2
set statusline=%F\ %y:\ %l,%v\ of\ %L\ lines
let NERDTreeStatusline="."
set history=50
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set textwidth=120  " be modern
set incsearch
set hlsearch
set title
set number
set mouse=a
set fillchars=vert:\ 
set pastetoggle=<F2>
let g:vim_markdown_folding_disabled=1

fun! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun

if exists("+showtabline")
     function MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= '%' . i . 'T'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let s .= ' '
             let s .= i . ' - '
             let s .= '%*'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let file = bufname(buflist[winnr - 1])
             let file = fnamemodify(file, ':p:t')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= file . ' '
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=2
     set tabline=%!MyTabLine()
endif

" =======
" Leaders
" =======
let mapleader=","
let maplocalleader=","  " use something else if needed

" ============
" Key mappings
" ============
nnoremap <Right>    :tabn<CR>
nnoremap z<Right>     :tabn<CR>
nnoremap zl           :tabn<CR>
nnoremap <Left>     :tabp<CR>
nnoremap z<Left>      :tabp<CR>
nnoremap zh           :tabp<CR>
nnoremap zt           :tabnew<CR>
nnoremap zw           :confirm bdelete<CR>
nnoremap zv           :set paste<cr>:r !pbpaste<cr>:set nopaste<CR>
nnoremap <leader>ev   :vsplit $MYVIMRC<cr>
nnoremap <leader>sv   :source $MYVIMRC<cr>
nnoremap <leader>"    viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>'    viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>p    :set spell spelllang=en_us<CR>
nnoremap <leader>P    :set nospell<CR>
inoremap #            X<c-h>#
inoremap jk           <esc>
inoremap jj           <esc>
inoremap jwj          <esc>:w<cr>
inoremap jwk          <esc>:w<cr>
vnoremap //           y/<c-r>"<cr>
vnoremap <leader>"    <esc>`<i"<esc>`>a"<esc>
vnoremap <leader>'    <esc>`<i'<esc>`>a'<esc>
vnoremap zc           <esc>:'<,'>w !pbcopy<cr>
iabbrev  adn          and
iabbrev  waht         what
iabbrev  tehn         then
iabbrev  tempalte     template
iabbrev  acount       account
iabbrev  accuont      account
iabbrev  Acount       Account
iabbrev  Accuont      Account
iabbrev  qury         query
iabbrev  qeury        query
iabbrev  verison      version
iabbrev  uesr         user
iabbrev  fucn         func
iabbrev  destory      destroy
" turn off annoying keys. any better way to do this?
nnoremap <esc>j       <nop>
nnoremap <esc>k       <nop>
nnoremap <esc>h       <nop>
nnoremap <esc>l       <nop>
nnoremap <esc>i       <nop>
nnoremap <esc>a       <nop>
nnoremap <esc>,       <nop>
nnoremap <esc>z       <nop>
nnoremap <esc>w       <nop>
nnoremap <esc>v       <nop>
nnoremap <esc><cr>    <nop>
nnoremap <esc><space> <nop>
" I'm not sure if there is a better way to do this. And how do I allow paste?
nnoremap zc           ?^\s*class<cr>:nohlsearch<cr>

" =============
" Auto commands
" =============
augroup filetype_md
    autocmd!
    autocmd BufNewFile,BufReadPost *.md setlocal filetype=ghmarkdown
augroup END
augroup filetype_ocaml
    autocmd!
    autocmd FileType     ocaml,omake     setlocal tabstop=8 shiftwidth=8
augroup END
augroup filetype_ruby
    autocmd!
    autocmd FileType     ruby        nnoremap <buffer> <localleader>c I# <esc>
    autocmd FileType     ruby        nnoremap <buffer> <localleader>u I<esc>lxx
    autocmd BufWritePre  *.rb        call TrimWhitespace()
augroup END
augroup filetype_html
    autocmd!
    autocmd FileType     html        setlocal textwidth=255
    autocmd BufWritePre  html        call TrimWhitespace()
augroup END
augroup filetype_js
    autocmd!
    autocmd FileType     javascript  nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType     javascript  nnoremap <buffer> <localleader>u I<esc>lxxx
    autocmd FileType     javascript  setlocal tabstop=2 shiftwidth=2
    autocmd BufWritePre  javascript  call TrimWhitespace()
augroup END
augroup filetype_vim
    autocmd!
    autocmd FileType     vim,conf    setlocal tabstop=4 shiftwidth=4
augroup END
augroup filetype_python
    autocmd!
    autocmd FileType     python      setlocal tabstop=4 shiftwidth=4
    autocmd FileType     python      nnoremap <buffer> <localleader>c I# <esc>
    autocmd FileType     python      nnoremap <buffer> <localleader>u I<esc>lxx
    autocmd FileType     python      iabbrev <buffer> iff if:<cr>pass<up><left>
    autocmd BufWritePost *.py        call Flake8()
    autocmd BufUnload    *.py        cclose
    autocmd ColorScheme  python      highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd BufWinEnter  python      match ExtraWhitespace /\s\+$/
    autocmd InsertEnter  python      match ExtraWhitespace /\s\+\%# \@<!$/
    autocmd InsertLeave  python      match ExtraWhitespace /\s\+$/
    autocmd BufWritePre  *.py        call TrimWhitespace()
augroup END
augroup filetype_make
    autocmd FileType     make    setlocal noexpandtab
augroup END

" ================
" Terminal vs. GUI
" ================
" I just like having GUI vim possibly with a different theme.
if has("gui_running")
  colorscheme davidan_white
  " set guifont=PT\ Mono:h14
else
  let &t_ZH="\e[3m"  " allows italics
  let &t_ZR="\e[23m"  " allows italics
  colorscheme davidan
  let g:NERDTreeDirArrows=0 " uncomment when no support for unicode
end

" ================================
" Plugins
" ================================

" <<<< NERDTree + NERDTreeTabsToggle >>>>
let NERDTreeIgnore = ['\.pyc$']
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <F10>     :NERDTreeTabsToggle<CR>
nnoremap <leader>f :NERDTreeTabsToggle<CR>
nnoremap zf        :NERDTreeTabsToggle<CR>
" Close vim if only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" <<<< ctags >>>>
" You must run ctags -R -o ~/tags ~/src
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
set tags=tags;$HOME/.vim/tags/
nnoremap <F9> :TlistToggle<CR>
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <C-[> :pop<CR>

"autocmd bufenter * if (winnr("$") == 1 && exists("s:displayed_warnings")) | q | endif
"

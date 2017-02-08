" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
    syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		    " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" Vim Plug (replace pathogen)
" --------------------------------------------------------------------
if has ("nvim")
    call plug#begin('~/.local/share/nvim/plugged')
endif
" - color schemes
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'rakr/vim-one'
Plug 'tomasr/molokai'
" - dirtree
Plug 'scrooloose/nerdtree'
" - programming
Plug 'rip-rip/clang_complete'
Plug 'ervandew/supertab'
Plug 'AndrewRadev/simple_bookmarks.vim'
Plug 'aklt/plantuml-syntax'
" - utils
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Colorscheme (onedark, solarized)
" --------------------------------------------------------------------
set background=dark
"set background=light
colorscheme onedark
"colorscheme solarized
"colorscheme one
"colorscheme molokai

" Airline
" --------------------------------------------------------------------
let g:airline_theme='base16_monokai'

" Gui specific - TODO: REMOVE!!!
" --------------------------------------------------------------------
if has ("gui_running")
    " just an alternative, i'm quiting GVim
    set lines=1500 columns=1500
    let g:fontman_font="DejaVu Sans Mono"
    let g:fontman_size=9
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
endif

" Vim-Clang - this is setting on CentOs 64 bit 
" --------------------------------------------------------------------
if isdirectory ("/usr/lib64/llvm")
    let g:clang_auto_select=1
    let g:clang_complete_auto=0
    let g:clang_complete_copen=1
    let g:clang_snippets=1
    let g:clang_snippets_engine='clang_complete'
    let g:clang_auto_user_options='path, .clang_complete'
    let g:clang_library_path='/usr/lib64/llvm'
else
    " No LLVM - do not load Clang
    let g:clang_complete_loaded=1
endif

" SuperTab
" --------------------------------------------------------------------
let g:SuperTabDefaultCompletionType='<C-x><C-u>'

" Simple Bookmark
let g:simple_bookmarks_filename='./.vim_bookmarks'
nmap <silent> <C-b><C-n> :execute ':CopenBookmarks'<CR>
nmap <C-b><C-v> :Bookmark

" Plant-uml
" --------------------------------------------------------------------
let g:plantuml_executable_script='java -jar ~/.vimapps/plantuml/plantuml.jar'

" Cscope
" --------------------------------------------------------------------
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb

    if has ('quickfix')
        nmap <F6> :execute 'set cscopequickfix='<CR>
        nmap <F7> :execute 'set cscopequickfix=s-,c-,d-,i-,t-,e-'<CR>
        nmap <F8> :execute 'cp'<CR>
        nmap <F9> :execute 'cn'<CR>
    endif

    " The following maps all invoke one of the following cscope search types:
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    nmap <C-h><C-h>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-h><C-h>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-h><C-h>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-h><C-h>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-h><C-h>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-h><C-h>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-h><C-h>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-h><C-h>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-u><C-u>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-u><C-u>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-u><C-u>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-u><C-u>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-u><C-u>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-u><C-u>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-u><C-u>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-u><C-u>d :scs find d <C-R>=expand("<cword>")<CR><CR>	

    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left
    nmap <C-n><C-n>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-n><C-n>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-n><C-n>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-n><C-n>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-n><C-n>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-n><C-n>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-n><C-n>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-n><C-n>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif

" Zaihas custom
" --------------------------------------------------------------------
set expandtab
set tabstop=4
set shiftwidth=4
set number
"set ttyscroll=0

nmap <silent> <F2> :execute 'NERDTreeToggle' . getcwd()<CR>
nmap <silent> <F4> :execute 'wa!'<CR>
nmap <silent> <F3> :execute 'q!'<CR>

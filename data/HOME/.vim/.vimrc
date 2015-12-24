
" Basiert auf http://spf13.com/post/perfect-vimrc-vim-config-file/
" -> https://github.com/spf13/spf13-vim/blob/master/.vimrc

" Environment {
    " Basics {
        set nocompatible
"        set background=dark
    " }
" }

" General {
    filetype plugin indent on    " Automatically detect file types.
    syntax on                    " syntax highlighting
    set history=1000             " Store a ton of history (default is 20)

    set backup                   " backups are nice ...
    set undofile                 " so is persistent undo ...
    set undolevels=1000          " maximum number of changes that can be undone
    set undoreload=10000         " maximum number lines to save for undo on a buffer reload

    " Setting up directories {
        set backupdir=$HOME/.vim/backup//   " but not when they clog .
        set directory=$HOME/.vim/swap//    " Same for swap files
        set viewdir=$HOME/.vim/views//     " same for view files
    " }
" }

" Vim UI {
    colorscheme desert           " load a colorscheme
    "colorscheme darkblue         " load a colorscheme
    set cursorline               " highlight current line
    hi cursorline guibg=#333333  " highlight bg color of current line
    hi CursorColumn guibg=#333333 " highlight cursor

    if has('cmdline_info')
        set ruler                  " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                " show partial commands in status line and
        " selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        "set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=\ [A=\%03.3b/H=\%02.2B]  " ASCII / Hexadecimal value of char
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start         " backspace for dummys
    set linespace=0                        " No extra spaces between rows
    set nu                                 " Line numbers on
    set showmatch                          " show matching brackets/parenthesis
    set incsearch                          " find as you type search
    set hlsearch                           " highlight search terms
    set winminheight=0                     " windows can be 0 line high 
    set ignorecase                         " case insensitive search
    set smartcase                          " case sensitive when uc present
    set wildmenu                           " show list instead of just completing
    set wildmode=list:longest,full         " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]          " backspace and cursor keys wrap to
    set scrolljump=5                       " lines to scroll when cursor leaves screen
    set scrolloff=3                        " minimum lines to keep above and below cursor
    "set foldenable                         " auto fold code
    "set gdefault                           " the /g flag on :s substitutions by default
    "set list
    "set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {
    set nowrap                             " wrap long lines
    set autoindent                         " indent at the same level of the previous line
    set shiftwidth=4                       " use indents of 4 spaces
    set expandtab                          " tabs are spaces, not tabs
    set tabstop=4                          " an indentation every four columns
    set softtabstop=4                      " let backspace delete indent
    set matchpairs+=<:>                   " match, to be used with %
    set pastetoggle=<F12>                  " pastetoggle (sane indentation on pastes)
    set comments=sl:/*,mb:*,elx:*/         " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        "set guioptions-=T                  " remove the toolbar
        set lines=40                       " 40 lines of text instead of 24,
    "else
    "    set term=builtin_ansi              " Make arrow and other keys work
    endif
" }


function! InitializeDirectories()
  let separator = "/"
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = { 
              \ 'backup': 'backupdir', 
              \ 'views': 'viewdir', 
              \ 'swap': 'directory', 
              \ 'undo': 'undodir' }

  for [dirname, settingname] in items(dir_list)
      let directory = parent . '/' . prefix . separator . dirname . "/"
      if exists("*mkdir")
          if !isdirectory(directory)
              call mkdir(directory)
          endif
      endif
      if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
      else  
          let directory = substitute(directory, " ", "\\\\ ", "")
          exec "set " . settingname . "=" . directory
      endif
  endfor
endfunction
call InitializeDirectories() 

function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" EOF

" ----------------------------------------------------------------------
" | General Settings                                                   |
" ----------------------------------------------------------------------
set nocompatible                    " Don't make Vim vi-compatibile.
set ttyfast                         " Enable fast terminal connection.
set encoding=utf-8 nobomb           " Use UTF-8 without BOM.
syntax on                           " Enable syntax highlighting.

if has('autocmd')
    filetype plugin indent on
    "           │     │    └──────── Enable file type detection.
    "           │     └───────────── Enable loading of indent file.
    "           └─────────────────── Enable loading of plugin files.
endif

set autoindent                      " Copy indent to the new line.

set backspace=indent                " ┐
set backspace+=eol                  " │ Allow `backspace`
set backspace+=start                " ┘ in insert mode.

set backupdir=~/.config/nvim/backups " Set directory for backup files.

if has('wildignore')
    set backupskip=/tmp/*           " ┐ Don't create backups
    set backupskip+=/private/tmp/*  " ┘ for certain files.
endif

set clipboard=unnamed               " ┐
                                    " │ Use the system clipboard
if has('unnamedplus')               " │ as the default register.
    set clipboard+=unnamedplus      " │
endif                               " ┘

set cpoptions+=$                    " When making a change, don't
                                    " redisplay the line, and instead,
                                    " put a `$` sign at the end of
                                    " the changed text.

if has('syntax')
    set colorcolumn=81              " Highlight certain column(s).
    set cursorline                  " Highlight the current line.
endif

set tabstop=2                       " ┐
set softtabstop=2                   " │ Set global <TAB> settings.
set shiftwidth=2                    " │
set expandtab                       " ┘

set directory=~/.config/nvim/swaps          " Set directory for swap files.
set encoding=utf-8 nobomb           " Use UTF-8 without BOM.

if has('cmdline_hist')
    set history=5000                " Increase command line history.
endif

if has('extra_search')

    set hlsearch                    " Enable search highlighting.

    set incsearch                   " Highlight search pattern
                                    " as it is being typed.
endif

set ignorecase                      " Ignore case in search patterns.
set lazyredraw                      " Do not redraw the screen while
                                    " executing macros, registers
                                    " and other commands that have
                                    " not been typed.

set listchars=tab:▸\                " ┐
set listchars+=trail:·              " │ Use custom symbols to
set listchars+=eol:↴                " │ represent invisible characters.
set listchars+=nbsp:_               " ┘

set magic                           " Enable extended regexp.
set mousehide                       " Hide mouse pointer while typing.
set noerrorbells                    " Disable error bells.

set nojoinspaces                    " When using the join command,
                                    " only insert a single space
                                    " after a `.`, `?`, or `!`.

set nomodeline                      " Disable for security reasons.
                                    " https://github.com/numirias/security/blob/cf4f74e0c6c6e4bbd6b59823aa1b85fa913e26eb/doc/2019-06-04_ace-vim-neovim.md#readme

set nostartofline                   " Kept the cursor on the same column.
set number                          " Show line number.

if has('linebreak')
    set numberwidth=5               " Increase the minimal number of
                                    " columns used for the `line number`.
endif

set report=0                        " Report the number of lines changed.

if has('cmdline_info')
    set ruler                       " Show cursor position.
endif

set scrolloff=5                     " When scrolling, keep the cursor
                                    " 5 lines below the top and 5 lines
                                    " above the bottom of the screen.

set shortmess=aAItW                 " Avoid all the hit-enter prompts.

if has('cmdline_info')
    set showcmd                     " Show the command being typed.
endif

set showmode                        " Show current mode.

if has('syntax')
    set spelllang=en_us             " Set the spellchecking language.
endif

set smartcase                       " Override `ignorecase` option
                                    " if the search pattern contains
                                    " uppercase characters.

if has('syntax')
    set synmaxcol=2500              " Limit syntax highlighting (this
                                    " avoids the very slow redrawing
                                    " when files contain long lines).
endif

if has('persistent_undo')
    set undodir=~/.config/nvim/undos        " Set directory for undo files.
    set undofile                            " Automatically save undo history.
endif

if has('virtualedit')
    set virtualedit=all             " Allow cursor to be anywhere.
endif

set visualbell                      " ┐
set noerrorbells                    " │ Disable beeping and window flashing.
set t_vb=                           " ┘ https://vim.wikia.com/wiki/Disable_beeping

if has('wildmenu')
    set wildmenu                    " Enable enhanced command-line
endif                               " completion (by hitting <TAB> in
                                    " command mode, Vim will show the
                                    " possible matches just above the
                                    " command line with the first
                                    " match highlighted).
if has('windows')
    set winminheight=0              " Allow windows to be squashed.
endif

" Prevent `Q` in `normal` mode from entering `Ex` mode.
nmap Q <Nop>

" Prevent arrow keys on normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" move up/down consider wrapped lines
nnoremap j gj
nnoremap k gk

nnoremap <C-D> :bnext<CR>
nnoremap <C-S> :bprev<CR>

" ----------------------------------------------------------------------
" | Helper Functions                                                   |
" ----------------------------------------------------------------------

function! GetGitBranchName()

    let branchName = ""

    if exists("g:loaded_fugitive")
        let branchName = "[" . fugitive#head() . "]"
    endif

    return branchName

endfunction
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! PrettyPrint()

    if ( &filetype == 'json' && (has('python3') || has('python')) )
        %!python -m json.tool
        norm! ggVG==
    elseif ( &filetype == 'svg' || &filetype == 'xml' )
        set formatexpr=xmlformat#Format()
        norm! Vgq
    endif

endfunction
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! StripBOM()
    if has('multi_byte')
        set nobomb
    endif
endfunction
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! StripTrailingWhitespaces()

    " Save last search and cursor position.

    let searchHistory = @/
    let cursorLine = line(".")
    let cursorColumn = col(".")

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Strip trailing whitespaces.

    %s/\s\+$//e

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Restore previous search history and cursor position.

    let @/ = searchHistory
    call cursor(cursorLine, cursorColumn)


endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! ToggleLimits()

    " [51,73]
    "
    "   * Git commit message
    "     http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
    "
    " [81]
    "
    "   * general use
    "     https://daniel.haxx.se/blog/2020/11/30/i-am-an-80-column-purist/

    if ( &colorcolumn == "73" )
        set colorcolumn+=51,81
    else
        set colorcolumn-=51,81
    endif

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! ToggleRelativeLineNumbers()

    if ( &relativenumber == 1 )
        set number
    else
        set relativenumber
    endif

endfunction



" ----------------------------------------------------------------------
" | Automatic Commands                                                 |
" ----------------------------------------------------------------------
if has("autocmd")

    " Autocommand Groups.
    " http://learnvimscriptthehardway.stevelosh.com/chapters/14.html

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Automatically reload the configurations from
    " the `~/.vimrc` file whenever they are changed.

    augroup auto_reload_vim_configs

        autocmd!
        autocmd BufWritePost vimrc source $MYVIMRC

    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Correctly recognize files.

    augroup correctly_recognize_files

        autocmd!
        autocmd BufEnter  gitconfig       :setlocal filetype=gitconfig
        autocmd BufEnter .gitconfig.local :setlocal filetype=gitconfig

    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Use relative line numbers.
    " http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/

    augroup relative_line_numbers

        autocmd!

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to absolute
        " line numbers when Vim loses focus.

        autocmd FocusLost * :set number

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to relative
        " line numbers when Vim gains focus.

        autocmd FocusGained * :set relativenumber

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to absolute
        " line numbers when Vim is in insert mode.

        autocmd InsertEnter * :set number

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to relative
        " line numbers when Vim is in normal mode.

        autocmd InsertLeave * :set relativenumber


    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Automatically strip whitespaces when files are saved.

    augroup strip_whitespaces

        " List of file types for which the whitespaces
        " should not be removed:

        let excludedFileTypes = []

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Only strip the whitespaces if the file type is not
        " in the excluded list.

        autocmd!
        autocmd BufWritePre * if index(excludedFileTypes, &ft) < 0 |
            \ :call StripBOM() |
            \ :call StripTrailingWhitespaces()

    augroup END

endif

" ----------------------------------------------------------------------
" | Key Mappings                                                       |
" ----------------------------------------------------------------------

" Use a different mapleader (default is "\").

let mapleader = ","

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,* ] Search and replace the word under the cursor.

nmap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cs] Clear search.

map <leader>cs <Esc>:noh<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,gd] Toggle Git differences.

map <leader>gd :SignifyToggle<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,l ] Toggle `set list`.

nmap <leader>l :set list!<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,n ] Toggle `set relativenumber`.

nmap <leader>n :call ToggleRelativeLineNumbers()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,pp] Pretty print

map <Leader>pp :call PrettyPrint()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" [,rl ] Toggle `RainbowLevels`.

map <leader>rl :RainbowLevelsToggle<cr>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,sb] Strip BOM (Byte Order Mark).

nmap <leader>sb :call StripBOM()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,sr] Strip carriage returns.

nmap <leader>sr :%s/\r//g<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,sw] Strip trailing whitespace.

nmap <leader>sw :call StripTrailingWhitespaces()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,t ] Toggle NERDTree.

map <leader>t :NERDTreeToggle<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,W ] Sudo write.

map <leader>W :w !sudo tee %<CR>
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,w] Close current buffer
map <leader>w :bdelete<CR>

"----------------------------------------------
" Splits
"----------------------------------------------
" Create horizontal splits below the current window
set splitbelow
set splitright

" Creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

" Closing splits
nnoremap <leader>q :close<cr>
" End Splits

" ----------------------------------------------------------------------
" | Plugins                                                            |
" ----------------------------------------------------------------------

" be impatient
lua require('impatient')

" packer
lua require('plugins')

" gopls
lua require('gopls')

"----------------------------------------------
" Plugin: 'junegunn/fzf.vim'
"----------------------------------------------
nnoremap <c-p> :FZF<cr>

"----------------------------------------------
" Plugin: 'ctrlpvim/ctrlp.vim'
"----------------------------------------------
" Note: We are not using CtrlP much in this configuration. But vim-go depend on
" it to run GoDecls(Dir).

" Disable the CtrlP mapping, since we want to use FZF instead for <c-p>.
let g:ctrlp_map = ''

"----------------------------------------------
" Plugin: Ag
"----------------------------------------------
" Open Ag
nnoremap <leader>a :Ag<space>
" ---------------------------------------------------------

"----------------------------------------------
" Plugin: 'preservim/nerdtree'
"----------------------------------------------
let NERDTreeShowHidden=1

"----------------------------------------------
" Plugin: 'fatih/vim-go'
"----------------------------------------------

" Language specific settings
" Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_fmt_command = "gopls"
let g:go_gopls_gofumpt=1
let g:go_list_type = "quickfix"
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

"----------------------------------------------
" Plugin: 'dense-analysis/ale'
"----------------------------------------------
let g:ale_linters = {
\   'go': ['gopls', 'golint', 'go vet'],
\}

"----------------------------------------------
" Plugin: 'ggreer/the_silver_searcher'
"----------------------------------------------
let g:ackprg = 'ag --nogroup --nocolor --column'

" Mappings
au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>gd <Plug>(go-def)
au FileType go nmap gc <Plug>(go-coverage-toggle)
au FileType go nmap gt <Plug>(go-test)
au FileType go nmap gf <Plug>(go-test-func)
au FileType go nmap gr <Plug>(go-run)

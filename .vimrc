" get rid of vi compatibilyityness
set nocompatible

let mapleader = " "

" filetypw options
filetype on
filetype plugin on
filetype indent on

" fancy looks
syntax enable
set number
set cursorline

" 4 as default spacing
set shiftwidth=4
set tabstop=4

" searching
set incsearch
set ignorecase
set smartcase
set showmatch
set hlsearch

" command bar
set showcmd
set showmode
set wildmenu " auto complete [TAB]
set history=1000 " save more commands
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx "ignore uneditable files

" line #s relitive to cursor
:set number relativenumber

" save capitialized markers
set viminfo='1000,f1

" clipboard used with \"*y and \"*p
let g:clipboard = {
                \   'name': 'WslClipboard',
                \   'copy': {
                \      '+': 'clip.exe',
                \      '*': 'clip.exe',
                \    },
                \   'paste': {
                \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \   },
                \   'cache_enabled': 0,
                \ }

" PLUGINS --------------------------

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'folke/zen-mode.nvim'

lua << EOF
  require("zen-mode").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

call plug#end()

" PLUGIN CONFIG -------------------

" config for coc
set updatetime=300 " fast updatetime
set signcolumn=yes " dont constatly shift side
" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" COLORSCHEME

colorscheme molokai

let g:light = 0	" start on dark theme
function SwapColors()
	" swap value
	let g:light = 1-g:light

	" light theme
	if g:light == 1
		let g:solarized_termcolors=256
		syntax enable
		set background=light
		colorscheme solarized
	" dark theme
	elseif g:light == 0
		colorscheme molokai
	endif
endfunction
nnoremap <expr> <f3> (SwapColors())

" MAPPINGS -------------------------

" i mess these up often, still holding shift after typing :
cnoreabbrev W w
cnoreabbrev Q q

inoremap jk <esc>
nnoremap <f4> :wq <CR>
tnoremap <f4> <C-c>exit<CR>

nnoremap j gj
nnoremap k gk

vnoremap j gj
vnoremap k gk

" this isnt working
augroup comment
	autocmd!
	autocmd FileType javascript nnoremap <buffer> <C-K> maI// <esc>'a
	autocmd FileType python     nnoremap <buffer> <C-K> maI# <esc>'a
	autocmd FileType vim        nnoremap <buffer> <C-K> maI" <esc>'a
augroup END

" VIMSCRIPT ------------------------

" dont let curser scroll into top/bottom 1/6 of visable page
augroup scroll
	autocmd!
	autocmd BufEnter,VimResized * let &scrolloff=( line('w$') - line('w0') ) / 6
augroup END

" set indentation to 2 spaces in html
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" hide cursor line when in different window
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
augroup END

" STATUS LINE-----------------------

set statusline=	" clear
set statusline+=\ %f\ %M\ %Y\ %R " left
set statusline+=%= " left->right
set statusline+=\ %l,%c\ %p%% " right
set laststatus=2

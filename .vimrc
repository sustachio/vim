" get rid of vi compatibilyityness
set nocompatible

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

" PLUGINS --------------------------

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

inoremap jk <esc>
nnoremap <f5> :term <CR>!python3 % <CR>
nnoremap <f4> :q <CR>
tnoremap <f4> exit<CR>

augroup comment
	autocmd!
	autocmd FileType javascript nnoremap <buffer> <C-/> I//<esc>
	autocmd FileType python     nnoremap <buffer> <C-/> I#<esc>
	autocmd FileType vim        nnoremap <buffer> <C-/> I"<esc>
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

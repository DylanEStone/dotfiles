" ================================================================
" => Initializing Plugins
" ================================================================
"
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'josa42/vim-lightline-coc'
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax' " updates vim's built-in css to support CSS3
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons'
Plug 'vimwiki/vimwiki'
Plug 'folke/zen-mode.nvim'
"Plug 'mcchrish/nnn.vim'
Plug 'luukvbaal/nnn.nvim'

" ==================================
" File navigation
" ==================================
Plug '/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

" makes fzf work related to git root of buffer which is nice
Plug 'airblade/vim-rooter'

" allows <leader>bo to close all buffers except current focus
Plug 'vim-scripts/BufOnly.vim'

call plug#end()

" Lightline Stuff
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'apprentice',
      \ }

"================================================================
" => VIM user interface
" ================================================================
" Ignore case when searching, but become case-sensitive if there is a capital
set ignorecase
set smartcase

" Don't redraw while executing macros (good performance config)
set lazyredraw

" update tab behavior
set linebreak

" set leader key
let mapleader = ";"

" Base16 Config
let base16colorspace=256  " Access colors present in 256 colorspace

" ================================================================
" => Colors and Fonts
" ================================================================

if has("termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" ================================================================
" => Moving around, tabs, windows and buffers
" ================================================================
map <leader>bb :Buffers<cr>

" Close all buffers except current
map <leader>bo :BufOnly<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme base16-default-dark
set background=dark

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set mouse=a
set titlestring=Editing:\%-2.55F\%a%r%m titlelen=70
set cursorline
set wildmenu
set nu rnu

set encoding=UTF-8

" ================================================================
" vim-javascript
" ================================================================

let g:javascript_plugin_jsdoc=1

autocmd FileType javascript setlocal equalprg=js-beautify\ --stdin
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

filetype plugin indent on
filetype plugin on
syntax on


" ================================================================
" vim-tmux-navigator
" ================================================================
" let g:tmux_navigator_no_mappings = 1

noremap <silent> {c-h} :<C-U>TmuxNavigateLeft<cr>
noremap <silent> {c-j} :<C-U>TmuxNavigateDown<cr>
noremap <silent> {c-k} :<C-U>TmuxNavigateUp<cr>
noremap <silent> {c-l} :<C-U>TmuxNavigateRight<cr>
noremap <silent> {c-p} :<C-U>TmuxNavigatePrevious<cr>

" Disable default mappings
let g:nnn#set_default_mappings = 0
nnoremap <silent> <leader>t :NnnExplorer -c <CR>
nnoremap <silent> <leader>f :NnnPicker -c <CR>


" Turn off the annoying swap files
set nobackup
set nowritebackup
set nowb
set noswapfile

" COC Config
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for apply refactor code actions.
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

set nocompatible

" Opens the n³ window in a split
let g:nnn#layout = 'new' " or vnew, tabnew etc.

" Or pass a dictionary with window size
let g:nnn#layout = { 'left': '~20%' } " or right, up, down

" Floating window. This is the default
let g:nnn#layout = { 'window': { 'width': 14.0, 'height': 0.6, 'highlight': 'Comment' } }

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)


lua << EOF
  require("zen-mode").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
	local builtin = require("nnn").builtin
	require("nnn").setup({
    explorer = {
      cmd = "nnn43",
      width = 24,
    },
    picker = {
      cmd = "nnn43",
      style = {border = "rounded"},
    },
    auto_close = "true",
		mappings = {
			{ "<C-t>", builtin.open_in_tab },       -- open file(s) in tab
			{ "<C-s>", builtin.open_in_split },     -- open file(s) in split
			{ "<C-v>", builtin.open_in_vsplit },    -- open file(s) in vertical split
			{ "<C-p>", builtin.open_in_preview },   -- open file in preview split keeping nnn focused
			{ "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
			{ "<C-w>", builtin.cd_to_path },        -- cd to file directory
			{ "<C-e>", builtin.populate_cmdline },  -- populate cmdline (:) with file(s)
		},
	})
EOF



function! NoteModeToggle()
  if g:coc_enabled
    CocDisable
    set nonu
    set nornu
    ZenMode
  else
    CocEnable
    set nu
    set rnu
    ZenMode
  endif
endfunction
command! NoteModeToggle :call NoteModeToggle()

nnoremap <leader>n :<C-u>NoteModeToggle<CR>

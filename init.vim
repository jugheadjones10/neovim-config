call plug#begin(stdpath('data') . 'plugged')
" Eventually configure snippets

" Movement plugins
Plug 'easymotion/vim-easymotion'

" Color Theme
Plug 'morhetz/gruvbox'

" Filetree
Plug 'preservim/nerdtree'

" Window and tab switching
Plug 't9md/vim-choosewin'
" Prevent NERD_TREE from taking over tab name. Also, quite a few bugs.

" Commenting
Plug 'tpope/vim-commentary'

" Vertical indent helper
Plug 'Yggdroot/indentLine'

" Surround
Plug 'tpope/vim-surround'

" Language server
" Plug 'neovim/nvim-lspconfig'
" Plug 'kabouzeid/nvim-lspinstall'
Plug 'dense-analysis/ale'

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

" Lisp
Plug 'vlime/vlime', {'rtp': 'vim/'}
Plug 'kovisoft/paredit'
Plug 'luochen1990/rainbow'

" Scheme
Plug 'Olical/conjure', {'tag': 'v4.25.0'}

" Marks
" Plug 'Yilin-Yang/vim-markbar'
" Doesn't quite work. Make a better version

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Undo tree
Plug 'mbbill/undotree'

call plug#end()

map <Space> <Leader>

" Local leaders
let g:vlime_leader = "b"
" Weird bug: setting paredit leader to space makes <Shift-(> off paredit mode
" Should remap <Leader><Up> and <Leader><Down> to more convenient stuff
let g:paredit_leader="b"


" Plugin-specific configs ----- ----- -----

" Vim Polyglot
" This is to make md and json play nice with indentLine
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" Vim Prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Ale configs
let g:ale_fixers = {
\  'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1

" Rainbow parantheses configs
let g:rainbow_active = 1 

" Conjure configs
let g:conjure#log#wrap=1

" Paredit configs
" For paredit, I modified the source to prevent it from 
" overriding my beloved easy motion s
let g:paredit_electric_return=0

" Undo tree configs
nnoremap <Leader>t :UndotreeToggle<CR>
let g:undotree_WindowLayout = 3

" Markbar configs
nmap <Leader>m <Plug>ToggleMarkbar

" Choosewin configs
nmap  -  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

" Easy motion configs -----{{{
let g:EasyMotion_do_mapping=0
nmap s <Plug>(easymotion-overwin-f2)
xmap s <Plug>(easymotion-s2)
omap s <Plug>(easymotion-s2)
nmap <Leader>s <Plug>(easymotion-sl)
xmap <Leader>s <Plug>(easymotion-sl)
omap <Leader>s <Plug>(easymotion-sl)
" s here interferes with nerd tree when in nerd tree buffer. Fix.
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
" }}}

" Gruvbox configs -----{{{
" Gruvbox interferes with easy motion highlighting...
autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_invert_selection=0
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" }}}

" NERDTree configs -----{{{
let NERDTreeMapOpenVSplit="ws"
" Original mapping of the above was s, which interfered with easy motion's 2
" char search, which is also s.
augroup NERDTree
  autocmd!
  autocmd VimEnter * NERDTree | wincmd p
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
        \ quit | endif
  autocmd BufWinEnter * silent NERDTreeMirror
augroup END
" }}}

" General configs ----- ----- -----

" Sourcing vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

" Copy paste with buffer
vmap <C-c> :w! ~/.vimbuffer<CR>
nmap <C-c> :.w! ~/.vimbuffer<CR>
map <C-p> :r ~/.vimbuffer<CR>

" Start of line remap
nmap # ^

" Custom escaping of insert mode
inoremap jk <esc>
inoremap kj <esc>
vnoremap jk <esc>
vnoremap kj <esc>

" Enable softwrap with no breaking in the middle of a word

" General vim settings
set splitbelow
set relativenumber
set nohlsearch
set nocompatible
set foldmethod=indent
set backupcopy=yes

" Folding
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" lua <<EOF
" require('lsp')
" EOF

" Abbreviations
iabbrev fn function

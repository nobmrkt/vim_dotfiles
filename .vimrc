set encoding=utf-8
scriptencoding utf-8

" Note: Skip initialization for vim-tiny or vim-small
if !1 | finish | endif

syntax on

let mapleader = ";"
source $VIMRUNTIME/macros/matchit.vim

" 外部で変更のあったファイルを自動的に読みなおす
set autoread
set updatetime=500
augroup AutoreadChecktime
  autocmd!
  autocmd BufEnter,WinEnter,CursorHold * checktime
augroup END

" 起動時のスプラッシュを表示しない
set shortmess+=I

" バックアップファイル、スワップファイルを作らない
set nobackup
set noswapfile
set viminfo+=n~/.vim/.viminfo

" 表示関係
set number
set scrolloff=5
set sidescroll=2
set sidescrolloff=10
set display=lastline
set lazyredraw

" バッファの変更が保存されていなくても移動する
set hidden

" タブの設定
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround

" インデントの設定
set autoindent
set smartindent
set nocindent

" 検索、補完時にスマートケースを有効にする
set ignorecase
set smartcase

" 不可視文字の表示
set list
set listchars=tab:›-,eol:$,extends:^,precedes:^

" 検索結果のハイライト
set hlsearch

" バックスペースの設定
set backspace=start,eol,indent

" クリップボードの設定
set clipboard+=unnamed

" ビープ音の抑制
set noerrorbells
set visualbell t_vb=

" 古い正規表現を使う
set regexpengine=1

" IMEの設定
set iminsert=0
set imsearch=0

" ステータス行の設定
set noshowmode
set laststatus=2
set statusline=%{&ft=='help'?'HELP':get(g:mode_map,mode(),'?')}\ %{&readonly?'RO':&modified?'+':'-'}
set statusline+=\ %t\ \(%<%{expand('%:h')!=''?expand('%:h'):'.'}\)
set statusline+=\ %=%y[%{&fenc!=''?&fenc:&enc}][%{&ff}][%3p%%][%3LL]
let g:mode_map = {
\   'n' : 'NORMAL',
\   'i' : 'INSERT',
\   'R' : 'REPLACE',
\   'v' : 'VISUAL',
\   'V' : 'V-LINE',
\   'c' : 'COMMAND',
\   "\<C-v>": 'V-BLOCK',
\   's' : 'SELECT',
\   'S' : 'S-LINE',
\   "\<C-s>": 'S-BLOCK',
\ }

" コマンドラインの高さ
set cmdheight=1

" ファイルフォーマットの設定
set fileformat=unix
set fileformats=unix,dos,mac

" エンコーディングの設定
set fileencodings=utf-8,ucs-bom,iso-2022-jp,euc-jp,cp932

" 全角文字の表示幅
if has('kaoriya')
  set ambiwidth=auto
else
  set ambiwidth=double
endif

" テキストの幅
set textwidth=120
set formatexpr=0
if exists('&colorcolumn')
  set colorcolumn=+1
endif

" JISに誤認したASCIIファイルのエンコーディングを修正する
augroup CorrectFileEncoding
  autocmd!
  autocmd BufReadPost *
  \ if &l:fileencoding ==# 'iso-2022-jp' && search('[^\x01-\x7e]', 'n') == 0 |
  \   let &l:fileencoding = &encoding |
  \ endif
augroup END

" バッファを閉じる
nnoremap <silent> <Leader>d :<C-u>bdelete<CR>
nnoremap <silent> <Leader>D :<C-u>bdelete!<CR>

" カーソル移動
nnoremap j gj
nnoremap k gk

" QuickFix
command! QfClear call setqflist([]) | doautocmd QuickFixCmdPost
command! LocClear call setloclist(0, []) | doautocmd QuickFixCmdPost

" タグファイルの設定
if has('path_extra')
  set tags+=tags;
endif

" カーソル位置を復元
augroup RestoreCursorPos
  autocmd!
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
augroup END

" ウィンドウの大きさを保存、復元
if has('gui')
  let g:window_pos_file = expand('~/.vim/.vimwinpos')

  if has('vim_starting') && filereadable(g:window_pos_file)
    execute 'source '.g:window_pos_file
  endif

  function! s:save_window_pos()
    let options = [
    \   'set columns='.&columns,
    \   'set lines='.&lines,
    \   'winpos '.getwinposx().' '.getwinposy(),
    \ ]
    call writefile(options, g:window_pos_file)
  endfunction

  augroup SaveWindowPos
    autocmd!
    autocmd VimLeavePre * call s:save_window_pos()
  augroup END
endif

" ファイルタイプ別のタブ設定
augroup TabSetting
  autocmd!
  autocmd FileType ruby,eruby setlocal softtabstop=2 shiftwidth=2
  autocmd FileType vim setlocal softtabstop=2 shiftwidth=2
augroup END

" Vim script の継続行のインデントを無効にする
let g:vim_indent_cont = 0

" markdown内のプログラミング言語をハイライト
let g:markdown_fenced_languages = [
\   'ruby',
\   'python',
\   'php',
\   'javascript',
\   'js=javascript',
\   'json=javascript',
\   'html',
\   'css',
\ ]

" Plugin
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
\   'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin'  : 'make -f make_cygwin.mak',
\     'mac'     : 'make -f make_mac.mak',
\     'linux'   : 'make',
\     'unix'    : 'gmake',
\   },
\ }

NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neocomplcache'

" unite.vim
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'Shougo/unite-outline', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'tsukkee/unite-tag', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'tsukkee/unite-help', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'sgur/unite-qf', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'hrsh7th/vim-versions', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'osyo-manga/unite-highlight', { 'depends' : ["Shougo/unite.vim"] }

" html
NeoBundle 'othree/html5.vim'
NeoBundle 'vim-scripts/closetag.vim'
NeoBundle 'gregsexton/MatchTag'

"css/less
"NeoBundle 'vim-scripts/Better-CSS-Syntax-for-Vim'
NeoBundle 'groenewege/vim-less'

"javascript
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jason0x43/vim-js-indent'
NeoBundle 'https://bitbucket.org/teramako/jscomplete-vim.git'

" php/twig
NeoBundle '2072/PHP-Indenting-for-VIm'
NeoBundle 'beyondwords/vim-twig'
NeoBundle 'tokutake/twig-indent'
NeoBundle 'shiena/vim-dbgp'

" python
NeoBundle 'hynek/vim-python-pep8-indent'

" その他
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'fuenor/im_control.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'kana/vim-submode'
NeoBundle 'scrooloose/syntastic'
NeoBundle "haya14busa/incsearch.vim"
NeoBundle "osyo-manga/vim-anzu"
NeoBundle "AndrewRadev/switch.vim"
NeoBundle 'gcmt/wildfire.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'pbrisbin/vim-mkdir'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'cohama/lexima.vim'
NeoBundle 'wombat256.vim'

augroup OmnifuncSetting
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS "teramako/jscomplete-vim
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

call neobundle#end()

filetype plugin indent on

" Plugin settings

if neobundle#tap('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1
  nnoremap <silent> <Leader>f :<C-u>VimFilerSplit -winwidth=35 -simple -no-quit<CR>

  call neobundle#untap()
endif

if neobundle#tap('neocomplcache')
  let g:neocomplcache_temporary_dir = expand('~/.vim/.neocomplcache')
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion = 1

  if !exists('g:neocomplcache_delimiter_patterns')
    let g:neocomplcache_delimiter_patterns = {}
  endif
  let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

  set completeopt=menuone
  inoremap <expr><C-x><C-f> neocomplcache#manual_filename_complete()
  inoremap <expr><C-n> (pumvisible() ? "" : neocomplcache#start_manual_complete()) . "\<C-n>"
  inoremap <expr><C-p> (pumvisible() ? "" : neocomplcache#start_manual_complete()) . "\<C-p>"
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
  inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
  inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
  inoremap <expr><C-y> neocomplcache#close_popup()
  inoremap <expr><C-e> neocomplcache#cancel_popup()

  call neobundle#untap()
endif

if neobundle#tap('unite.vim')
  let g:unite_data_directory = expand('~/.vim/.unite')
  let g:unite_enable_start_insert = 1
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1
  "let g:unite_update_time = 250

  let g:unite_matcher_fuzzy_max_input_length = 20
  let g:unite_source_rec_min_cache_files = 5
  let g:unite_source_rec_max_cache_files = 5000

  "call unite#filters#matcher_default#use(['matcher_fuzzy'])
  "call unite#filters#sorter_default#use(['sorter_rank'])

  " unite grep に ag を使う
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_max_candidates = 500
  endif

  nnoremap <silent> <leader>ub :<C-u>Unite -buffer-name=files buffer<CR>
  nnoremap <silent> <leader>uf :<C-u>Unite -buffer-name=files file file/new<CR>
  nnoremap <silent> <leader>ur :<C-u>Unite -buffer-name=files file_rec/async<CR>
  nnoremap <silent> <leader>ug :<C-u>Unite grep:.::<CR>
  nnoremap <silent> <leader>ucg :<C-u>Unite grep:.::<CR><C-R><C-W><CR>
  nnoremap <silent> <leader>uvs :<C-u>UniteVersions status:!<CR>
  nnoremap <silent> <leader>uvl :<C-u>UniteVersions log:%<CR>
  nnoremap <silent> <leader>uvc :<C-u>UniteVersions changeset<CR>

  function! s:unite_setting()
    imap <silent><buffer> <ESC> <ESC><Plug>(unite_all_exit)
    imap <silent><buffer> <ESC><ESC> <ESC><Plug>(unite_all_exit)
    imap <silent><buffer> <TAB> <Plug>(unite_select_next_line)
    imap <silent><buffer> <S-TAB> <Plug>(unite_select_previous_line)
    imap <silent><buffer> <C-l> <Plug>(unite_choose_action)
    imap <silent><buffer><expr> <C-j> unite#do_action("cd")
    imap <silent><buffer><expr> i unite#smart_map("i", "\<Plug>(unite_insert_leave)\<Plug>(unite_insert_enter)")
  endfunction

  augroup UniteSetting
    autocmd!
    autocmd FileType unite call s:unite_setting()
  augroup END

  call neobundle#untap()
endif

if neobundle#tap('neomru.vim')
  nnoremap <silent> <leader>um :<C-u>Unite -buffer-name=files file_mru<CR>

  call neobundle#untap()
endif

if neobundle#tap('unite-outline')
  nnoremap <silent> <leader>uo :<C-u>Unite outline<CR>

  call neobundle#untap()
endif

if neobundle#tap('indentLine')
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_indentLevel = 20
  let g:indentLine_color_term = 237

  call neobundle#untap()
endif

if neobundle#tap('im_control.vim')
  "let IM_CtrlMode = has('gui_running') ? 4 : 0
  "inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>

  call neobundle#untap()
endif

if neobundle#tap('vim-quickhl')
  nmap <Space>m <Plug>(quickhl-manual-this)
  xmap <Space>m <Plug>(quickhl-manual-this)
  nmap <F9>     <Plug>(quickhl-manual-toggle)
  xmap <F9>     <Plug>(quickhl-manual-toggle)
  nmap <Space>M <Plug>(quickhl-manual-reset)
  xmap <Space>M <Plug>(quickhl-manual-reset)
  nmap <Space>j <Plug>(quickhl-cword-toggle)
  nmap <Space>] <Plug>(quickhl-tag-toggle)

  call neobundle#untap()
endif

if neobundle#tap('vim-textmanip')
  nmap <M-d> <Plug>(textmanip-duplicate-down)
  xmap <M-d> <Plug>(textmanip-duplicate-down)
  nmap <M-D> <Plug>(textmanip-duplicate-up)
  xmap <M-D> <Plug>(textmanip-duplicate-up)
  xmap <C-j> <Plug>(textmanip-move-down)
  xmap <C-k> <Plug>(textmanip-move-up)
  xmap <C-h> <Plug>(textmanip-move-left)
  xmap <C-l> <Plug>(textmanip-move-right)

  call neobundle#untap()
endif

if neobundle#tap('vim-submode')
  set nowrap
  call submode#enter_with('scroll', 'n', '', '<leader><leader>h', '4zh')
  call submode#enter_with('scroll', 'n', '', '<leader><leader>j', '2<C-e>')
  call submode#enter_with('scroll', 'n', '', '<leader><leader>k', '2<C-y>')
  call submode#enter_with('scroll', 'n', '', '<leader><leader>l', '4zl')
  call submode#map('scroll', 'n', '', 'h', '4zh')
  call submode#map('scroll', 'n', '', 'j', '2<C-e>')
  call submode#map('scroll', 'n', '', 'k', '2<C-y>')
  call submode#map('scroll', 'n', '', 'l', '4zl')

  call neobundle#untap()
endif

if neobundle#tap('syntastic')
  let g:syntastic_check_on_open = 0
  let g:syntastic_auto_jump = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_loc_list_height = 5
  let g:syntastic_error_symbol = 'E'
  let g:syntastic_warning_symbol = 'W'

  call neobundle#untap()
endif

if neobundle#tap('vim-ddbgp')
  let g:debuggerMaxDepth = 3
  let g:debuggerDedicatedTab = 0
  let g:debuggerTimeout = 30

  call neobundle#untap()
endif

if neobundle#tap('html5.vim')
  let g:html_indent_tags = 'dt\|dd'
  let g:html_exclude_tags = ['html']

  call neobundle#untap()
endif

if neobundle#tap('closetag.vim')
  let g:closetag_html_style = 1 

  call neobundle#untap()
endif

if neobundle#tap('jscomplete-vim')
  let g:jscomplete_use = ['dom']

  call neobundle#untap()
endif

if neobundle#tap('incsearch.vim')
  let g:incsearch#auto_nohlsearch = 1
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)

  call neobundle#untap()
endif

if neobundle#tap('vim-anzu')
  nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
  nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
  nmap * <Plug>(incsearch-nohl)<Plug>(anzu-star-with-echo)
  nmap # <Plug>(incsearch-nohl)<Plug>(anzu-sharp-with-echo)

  call neobundle#untap()
endif

if neobundle#tap('switch.vim')
  nnoremap <silent> - :<C-u>Switch<CR>

  call neobundle#untap()
endif

if neobundle#tap('wildfire.vim')
  map <PageUp> <Plug>(wildfire-fuel)
  vmap <PageDown> <Plug>(wildfire-water)
  let g:wildfire_objects = ["i'", 'i"', 'i)', 'i]', 'i}', 'ip', 'it', 'i>']

  call neobundle#untap()
endif

if neobundle#tap('caw.vim')
  nmap <Leader>c <Plug>(caw:i:toggle)
  vmap <Leader>c <Plug>(caw:i:toggle)

  call neobundle#untap()
endif

if neobundle#tap('wombat256.vim')
  set background=dark
  augroup CustomColorScheme
    autocmd!
    autocmd InsertEnter             * highlight StatusLine   ctermfg=21   ctermbg=226  cterm=BOLD
    autocmd InsertLeave,ColorScheme * highlight StatusLine   ctermfg=226  ctermbg=33   cterm=NONE
    autocmd ColorScheme             * highlight StatusLineNC ctermfg=240  ctermbg=253
    autocmd ColorScheme             * highlight VertSplit    ctermfg=253  ctermbg=253
    autocmd ColorScheme             * highlight ColorColumn  ctermfg=NONE ctermbg=16
    autocmd ColorScheme             * highlight MatchParen   ctermfg=201  ctermbg=NONE
    autocmd ColorScheme             * highlight NonText      ctermfg=245  ctermbg=NONE
    autocmd ColorScheme             * highlight SpecialKey   ctermfg=16   ctermbg=235
  augroup END
  colorscheme wombat256mod

  call neobundle#untap()
endif

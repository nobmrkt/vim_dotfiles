﻿scriptencoding utf-8

let mapleader = ";"
source $VIMRUNTIME/macros/matchit.vim

" NeoBundle
if has('vim_starting')
  if isdirectory(expand('~/vimfiles/'))
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
    call neobundle#rc(expand('~/vimfiles/bundle/'))
  elseif isdirectory(expand('~/.vim/'))
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
  endif
endif

" vimproc
NeoBundle 'Shougo/vimproc'

" neocomplcache
NeoBundle 'Shougo/neocomplcache'
set completeopt=menuone
let g:neocomplcache_temporary_dir = expand('~/.vim/.neocomplcache')
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

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

" unite.vim
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'tsukkee/unite-tag', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'tsukkee/unite-help', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'sgur/unite-qf', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'hrsh7th/vim-versions', { 'depends' : ["Shougo/unite.vim"] }
NeoBundle 'osyo-manga/unite-highlight', { 'depends' : ["Shougo/unite.vim"] }

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
endif

nnoremap <silent> <leader>ub :<C-u>Unite -buffer-name=files buffer<CR>
nnoremap <silent> <leader>uf :<C-u>Unite -buffer-name=files file file/new<CR>
nnoremap <silent> <leader>um :<C-u>Unite -buffer-name=files file_mru<CR>
nnoremap <silent> <leader>ur :<C-u>Unite -buffer-name=files file_rec/async<CR>
nnoremap <silent> <leader>uo :<C-u>Unite outline<CR>
nnoremap <silent> <leader>ug :<C-u>Unite grep<CR>
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

" vim-indeng-guides
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" indentLine
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_color_term = 237

" 日本語入力固定モード
NeoBundle 'fuenor/im_control.vim'
"let IM_CtrlMode = has('gui_running') ? 4 : 0
"inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>

" quickhl
NeoBundle 't9md/vim-quickhl'
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)

" vim-textmanip
NeoBundle 't9md/vim-textmanip'
nmap <M-d> <Plug>(textmanip-duplicate-down)
xmap <M-d> <Plug>(textmanip-duplicate-down)
nmap <M-D> <Plug>(textmanip-duplicate-up)
xmap <M-D> <Plug>(textmanip-duplicate-up)
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

NeoBundle 'kana/vim-submode'
set nowrap
call submode#enter_with('scroll', 'n', '', '<leader><leader>h', '4zh')
call submode#enter_with('scroll', 'n', '', '<leader><leader>j', '2<C-e>')
call submode#enter_with('scroll', 'n', '', '<leader><leader>k', '2<C-y>')
call submode#enter_with('scroll', 'n', '', '<leader><leader>l', '4zl')
call submode#map('scroll', 'n', '', 'h', '4zh')
call submode#map('scroll', 'n', '', 'j', '2<C-e>')
call submode#map('scroll', 'n', '', 'k', '2<C-y>')
call submode#map('scroll', 'n', '', 'l', '4zl')

NeoBundle 'yonchu/accelerated-smooth-scroll'
let g:ac_smooth_scroll_du_sleep_time_msec = 5
let g:ac_smooth_scroll_fb_sleep_time_msec = 5

NeoBundle 'scrooloose/syntastic'
let g:syntastic_check_on_open = 0
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_error_symbol = 'E'
let g:syntastic_warning_symbol = 'W'

" php/twig
NeoBundle '2072/PHP-Indenting-for-VIm'
NeoBundle 'beyondwords/vim-twig'
NeoBundle 'tokutake/twig-indent'

NeoBundle 'shiena/vim-dbgp'
let g:debuggerMaxDepth = 3
let g:debuggerDedicatedTab = 0
let g:debuggerTimeout = 30

" html
NeoBundle 'othree/html5.vim'
let g:html_indent_tags = 'dt\|dd'
let g:html_exclude_tags = ['html']

NeoBundle 'vim-scripts/closetag.vim'
let g:closetag_html_style = 1 

NeoBundle 'gregsexton/MatchTag'

"css/less
"NeoBundle 'vim-scripts/Better-CSS-Syntax-for-Vim'
NeoBundle 'groenewege/vim-less'

"javascript
NeoBundle 'jelera/vim-javascript-syntax'

NeoBundle 'jiangmiao/simple-javascript-indenter'
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" jscomplete-vim
NeoBundle 'teramako/jscomplete-vim'
let g:jscomplete_use = ['dom']

" その他
NeoBundle 'wombat256.vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'thinca/vim-localrc'
"NeoBundle 'itchyny/lightline.vim'

if !exists('g:neocomplcache_delimiter_patterns')
  let g:neocomplcache_delimiter_patterns = {}
endif
let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

augroup OmnifuncSetting
  autocmd!
  "autocmd FileType ada setlocal omnifunc=adacomplete#Complete
  "autocmd FileType c setlocal omnifunc=ccomplete#Complete
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS "teramako/jscomplete-vim
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  "autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

filetype plugin indent on

syntax on

set background=dark
autocmd ColorScheme * highlight Pmenu guifg=grey70 guibg=grey40
autocmd ColorScheme * highlight PmenuSel guifg=lightgreen guibg=grey30 gui=bold
autocmd ColorScheme * highlight PmenuSbar guibg=grey40
autocmd ColorScheme * highlight PmenuThumb guibg=grey30
autocmd ColorScheme * highlight VertSplit ctermfg=228 ctermbg=228 guifg=lightyellow guibg=lightyellow
autocmd ColorScheme * highlight StatusLine ctermfg=20 ctermbg=228 cterm=bold guifg=blue guibg=lightyellow gui=bold
autocmd ColorScheme * highlight StatusLineNc ctermfg=67 ctermbg=228 guifg=grey50 guibg=lightyellow
autocmd ColorScheme * highlight LineNr guifg=grey40 guibg=grey10
autocmd ColorScheme * highlight CursorLine guibg=grey10 gui=NONE
autocmd ColorScheme * highlight CursorLineNr guifg=green guibg=grey10 gui=bold
autocmd ColorScheme * highlight Cursor guifg=black guibg=green
autocmd ColorScheme * highlight CursorIM guifg=black guibg=red
autocmd ColorScheme * highlight Comment gui=NONE
autocmd ColorScheme * highlight String gui=NONE
autocmd ColorScheme * highlight MatchParen guifg=magenta guibg=NONE gui=bold
autocmd ColorScheme * highlight IndentGuidesOdd  guibg=grey20
autocmd ColorScheme * highlight IndentGuidesEven guibg=grey20
colorscheme wombat256mod

" カーソル行のハイライト制御
set cursorline
augroup CursorLineSetting
  autocmd!
  " カレントウィンドウでのみハイライトを有効にする
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  " 通常モードと挿入モードでハイライトを変更する
  autocmd InsertEnter * highlight CursorLine guibg=grey10 gui=underline
  autocmd InsertLeave * highlight CursorLine guibg=grey10 gui=NONE
augroup END

" 外部で変更のあったファイルを自動的に読みなおす
set autoread
augroup AutoreadChecktime
  autocmd!
  autocmd WinEnter * checktime
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
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround

" インデントの設定
set autoindent
set smartindent
set nocindent

" 検索、補完時にスマートケースを有効にする
set ignorecase
set smartcase

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
set laststatus=2
set statusline=%t\ %<\(%{expand('%:p:h')}\)\ %m%r%h%w\ %=%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%l,%v][%P]

" コマンドラインの高さ
set cmdheight=1

" ファイルフォーマットの設定
set fileformat=unix
set fileformats=unix,dos,mac

" エンコーディングの設定
set encoding=utf-8
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

" ファイルの保存時にディレクトリが存在しなければ作成する
function! s:auto_mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
  \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

augroup AutoMkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
augroup END

" バッファを閉じる
nnoremap <silent> <Leader>q :<C-u>bdelete<CR>
nnoremap <silent> <Leader>Q :<C-u>bdelete!<CR>

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
      \ 'set columns='.&columns,
      \ 'set lines='.&lines,
      \ 'winpos '.getwinposx().' '.getwinposy(),
      \ ]
    call writefile(options, g:window_pos_file)
  endfunction

  augroup SaveWindowPos
    autocmd!
    autocmd VimLeavePre * call s:save_window_pos()
  augroup END
endif
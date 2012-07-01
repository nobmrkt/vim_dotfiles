scriptencoding utf-8

let mapleader = ";"

" NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  if isdirectory(expand('~/vimfiles'))
    set rtp+=~/vimfiles/neobundle.vim
    call neobundle#rc('~/vimfiles/bundle')
  elseif isdirectory(expand('~/.vim'))
    set rtp+=~/.vim/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle'))
  endif
endif

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'jceb/vim-hier'
NeoBundle 'lambdalisue/nose.vim'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'sgur/unite-qf'
NeoBundle 't9md/vim-quickhl'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'vim-jp/vimdoc-ja'

filetype plugin on
filetype indent on

" unite.vim
let g:unite_enable_start_insert = 1
let g:unite_update_time = 250

call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <silent> <leader>ub :<C-u>Unite -buffer-name=files buffer<CR>
nnoremap <silent> <leader>uf :<C-u>Unite -buffer-name=files file file/new<CR>
nnoremap <silent> <leader>um :<C-u>Unite -buffer-name=files file_mru<CR>
nnoremap <silent> <leader>uo :<C-u>Unite outline<CR>
nnoremap <silent> <leader>ut :<C-u>Unite tag<CR>
nnoremap <silent> <leader>uq :<C-u>Unite qf<CR>
nnoremap <silent> <leader>uh :<C-u>Unite help<CR>
nnoremap <silent> <leader>ug :<C-u>Unite grep<CR>

function! s:unite_setting()
  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <TAB> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <S-TAB> <Plug>(unite_loop_cursor_up)
  nmap <buffer> <C-CR> <Plug>(unite_choose_action)
  imap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <TAB> <Plug>(unite_select_next_line)
  imap <buffer> <S-TAB> <Plug>(unite_select_previous_line)
  imap <buffer><expr> i unite#smart_map("i", "\<Plug>(unite_insert_leave)\<Plug>(unite_insert_enter)")
  imap <buffer> <C-CR> <Plug>(unite_choose_action)
  imap <buffer><expr> <C-CR> unite#do_action("cd")
  imap <buffer><expr> <C-g> unite#do_action("grep")
  imap <buffer><expr> <C-p> unite#do_action("preview")
endfunction

augroup UniteSetting
  autocmd!
  autocmd FileType unite call s:unite_setting()
augroup END

" neocomplcache
set completeopt=menuone
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

augroup OmnifuncSetting
  autocmd!
  "autocmd FileType ada setlocal omnifunc=adacomplete#Complete
  "autocmd FileType c setlocal omnifunc=ccomplete#Complete
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  "autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  "autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

" quickrun
let g:quickrun_config = {}
let g:quickrun_config._ = { 'runner' : 'vimproc' }

let s:silent_quickfix = quickrun#outputter#quickfix#new()

function! s:silent_quickfix.init(session)
  let self.winnr = winnr()
  call call(quickrun#outputter#quickfix#new().init, [a:session], self)
endfunction

function! s:silent_quickfix.finish(session)
  call call(quickrun#outputter#quickfix#new().finish, [a:session], self)
  cclose
  while self.winnr != winnr()
    execute "normal \<C-w>\<C-w>"
  endwhile
  doautocmd QuickFixCmdPost
endfunction

call quickrun#register_outputter('silent_quickfix', s:silent_quickfix)

" quickhl
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)

" vim-textmanip
nmap <M-d> <Plug>(textmanip-duplicate-down)
xmap <M-d> <Plug>(textmanip-duplicate-down)
nmap <M-D> <Plug>(textmanip-duplicate-up)
xmap <M-D> <Plug>(textmanip-duplicate-up)
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

syntax on
set background=dark
colorscheme wombat
highlight Pmenu guifg=grey70 guibg=grey40
highlight PmenuSel guifg=lightgreen guibg=grey30 gui=bold
highlight PmenuSbar guibg=grey40
highlight PmenuThumb guibg=grey30
highlight VertSplit guifg=lightyellow guibg=lightyellow
highlight StatusLine guifg=blue guibg=lightyellow gui=bold
highlight StatusLineNc guifg=grey50 guibg=lightyellow
highlight LineNr guifg=grey40 guibg=grey10
highlight CursorLine guibg=grey10 gui=NONE
highlight CursorLineNr guifg=green guibg=grey10 gui=bold
highlight Cursor guifg=black guibg=green
highlight CursorIM guifg=black guibg=red
highlight Comment gui=NONE
highlight String gui=NONE
highlight MatchParen guifg=magenta guibg=NONE gui=bold

" カーソル行のハイライト制御
set cursorline
augroup CursorLineModeSetting
  autocmd!
  " カレントウィンドウでのみハイライトを有効にする
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  " 通常モードと挿入モードでハイライトを変更する
  autocmd InsertEnter * highlight CursorLine guibg=grey20 gui=underline
  autocmd InsertLeave * highlight CursorLine guibg=grey10 gui=NONE
augroup END

" 起動時のスプラッシュを表示しない
set shortmess+=I

" バックアップファイル、スワップファイルを作らない
set nobackup
set noswapfile

" 表示関係
set number
set scrolloff=5
set display=lastline

" バッファの変更が保存されていなくても移動する
set hidden

" タブの設定
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

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

" IMEの設定
set iminsert=0
set imsearch=0

" ステータス行の設定
set laststatus=2
set statusline=%t\ %<\(%{expand('%:p:h')}\)\ %m%r%h%w\ %=%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%l,%v][%P]

" コマンドラインの高さ
set cmdheight=2

" ファイルフォーマットの設定
set fileformat=unix
set fileformats=unix,dos,mac

" エンコーディングの設定
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp,euc-jp,cp932
if has('kaoriya')
    set ambiwidth=auto
else
    set ambiwidth=double
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

function! s:hier_update_all()
  call setqflist(filter(copy(getqflist()), 'v:val.valid'))
  let l:qfcnt = len(getqflist())
  echohl WarningMsg
  echo l:qfcnt ? 'QuickFix : '.l:qfcnt.' item(s) are updated' : ''
  echohl NONE
  for i in range(1, winnr('$'))
    HierUpdate
    execute "normal \<C-w>\<C-w>"
  endfor
endfunction

augroup QuickFixSetting
  autocmd!
  autocmd QuickFixCmdPost [^l]* call s:hier_update_all()
augroup END

" 日本語入力固定モード
let IM_CtrlMode = has('gui_running') ? 4 : 0
inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>

" タグファイルの設定
if has('path_extra')
  set tags=tags;
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
let g:window_pos_file = expand('~/.vimwinpos')

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

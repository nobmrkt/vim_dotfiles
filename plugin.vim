" neobundle.vim のインストールチェック
if !isdirectory(expand('~/vimfiles/bundle/neobundle.vim'))
  finish
endif

if has('vim_starting')
  set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/vimfiles/bundle/'))

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
"NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neco-syntax', { 'depends' : ["Shougo/neocomplete.vim"] }

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

" python
NeoBundle 'hynek/vim-python-pep8-indent'

" remote debugger
" TODO 検証
" NeoBundle 'shiena/vim-dbgp'
" NeoBundle 'joonty/vdebug'

" その他
NeoBundle 'yonchu/accelerated-smooth-scroll'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'mhinz/vim-signify'
NeoBundle 't9md/vim-quickhl'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'scrooloose/syntastic'
NeoBundle "haya14busa/incsearch.vim"
NeoBundle "haya14busa/vim-asterisk"
NeoBundle "osyo-manga/vim-anzu"
NeoBundle 'rhysd/clever-f.vim'
NeoBundle "AndrewRadev/switch.vim"
NeoBundle 'kana/vim-submode'
NeoBundle 'tyru/caw.vim'
NeoBundle 'pbrisbin/vim-mkdir'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'wombat256.vim'

call neobundle#end()


filetype plugin indent on

if neobundle#exists_not_installed_bundles()
  NeoBundleInstall
endif

" Plugin settings

if neobundle#tap('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_data_directory = expand('~/vimfiles/tmp/vimfiler')
  nnoremap <silent> <Leader>f :<C-u>VimFiler -status<CR>

  call neobundle#untap()
endif

if neobundle#tap('neocomplete.vim')
  let g:neocomplete#data_directory = expand('~/vimfiles/tmp/neocomplete')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1

  if !exists('g:neocomplete#delimiter_patterns')
    let g:neocomplete#delimiter_patterns = {}
  endif
  let g:neocomplete#delimiter_patterns.php = ['->', '::', '\']

  inoremap <expr><C-g> neocomplete#undo_completion()
  inoremap <expr><C-l> neocomplete#complete_common_string()
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
  inoremap <expr><C-h> "\<C-h>".(pumvisible() ?  neocomplete#start_manual_complete() : neocomplete#close_popup())
  inoremap <expr><BS> "\<C-h>".(pumvisible() ?  neocomplete#start_manual_complete() : neocomplete#close_popup())

  call neobundle#untap()
endif

if neobundle#tap('neocomplcache')
  let g:neocomplcache_temporary_dir = expand('~/vimfiles/tmp/neocomplcache')
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
  let g:unite_data_directory = expand('~/vimfiles/tmp/unite')
  let g:unite_enable_auto_select = 0

  call unite#custom#profile('default', 'context', {
  \   'empty': 0,
  \   'prompt_focus': 1,
  \   'start_insert': 0,
  \   'cursor_line_time': '0.0',
  \ })

  call unite#filters#matcher_default#use('matcher_fuzzy')
  call unite#filters#sorter_default#use('sorter_rank')

  call unite#custom#profile('files', 'matchers', [
  \   'matcher_fuzzy',
  \   'matcher_hide_hidden_files',
  \ ])
  call unite#custom#profile('files', 'converters', [
  \   'converter_relative_abbr',
  \   'converter_relative_word',
  \ ])

  " buffer
  nnoremap <silent> <leader>ub :<C-u>Unite -buffer-name=buffers buffer<CR>

  " file_rec file_rec/async
  " nnoremap <silent> <leader>uf :<C-u>UniteWithCurrentDir -buffer-name=files file_rec<CR>
  nnoremap <silent> <leader>uf :<C-u>UniteWithCurrentDir -buffer-name=files file_rec/async:!<CR>

  " grep
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
    \ '--follow --nocolor --nogroup --hidden --smart-case '.
    \ '--skip-vcs-ignores --ignore ".svn" --ignore ".git"'
    let g:unite_source_grep_recursive_opt = ''
  endif
  nnoremap <silent> <leader>ug :<C-u>Unite -buffer-name=grep grep:.<CR>

  call neobundle#untap()
endif

if neobundle#tap('neomru.vim')
  let g:neomru#file_mru_path = expand('~/vimfiles/tmp/neomru/file')
  let g:neomru#directory_mru_path = expand('~/vimfiles/tmp/neomru/directory')
  nnoremap <silent> <leader>um :<C-u>Unite -buffer-name=files file_mru<CR>
  nnoremap <silent> <leader>uM :<C-u>UniteWithCurrentDir -buffer-name=files file_mru<CR>

  call neobundle#untap()
endif

if neobundle#tap('unite-outline')
  call unite#custom#source('outline', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('outline', 'sorters', 'sorter_nothing')
  nnoremap <silent> <leader>uo :<C-u>Unite -buffer-name=outline outline<CR>

  call neobundle#untap()
endif

if neobundle#tap('unite-help')
  nnoremap <silent> <Leader>uh :<C-u>Unite help<CR>

  call neobundle#untap()
endif

if neobundle#tap('vim-versions')
  nnoremap <silent> <leader>uvs :<C-u>UniteVersions status:!<CR>
  nnoremap <silent> <leader>uvl :<C-u>UniteVersions log:%<CR>
  nnoremap <silent> <leader>uvc :<C-u>UniteVersions changeset<CR>

  call neobundle#untap()
endif

if neobundle#tap('indentLine')
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_indentLevel = 20
  let g:indentLine_color_term = 237

  call neobundle#untap()
endif

if neobundle#tap('vim-trailing-whitespace')
  let g:extra_whitespace_ignored_filetypes = ['unite']

  call neobundle#untap()
endif

if neobundle#tap('vim-quickhl')
  nmap <Space>m <Plug>(quickhl-manual-this)
  xmap <Space>m <Plug>(quickhl-manual-this)
  nmap <Space>M <Plug>(quickhl-manual-reset)
  xmap <Space>M <Plug>(quickhl-manual-reset)

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

if neobundle#tap('syntastic')
  let g:syntastic_check_on_open = 0
  let g:syntastic_auto_jump = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_loc_list_height = 5
  let g:syntastic_error_symbol = 'E'
  let g:syntastic_warning_symbol = 'W'

  call neobundle#untap()
endif

if neobundle#tap('vim-dbgp')
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

  autocmd MyAutoCmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS

  call neobundle#untap()
endif

if neobundle#tap('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  call neobundle#untap()
endif

if neobundle#tap('vim-asterisk')
  map *  <Plug>(asterisk-z*)
  map g* <Plug>(asterisk-gz*)
  map #  <Plug>(asterisk-z#)
  map g# <Plug>(asterisk-gz#)

  call neobundle#untap()
endif

if neobundle#tap('vim-anzu')
  nmap n  <Plug>(anzu-n-with-echo)
  nmap N  <Plug>(anzu-N-with-echo)

  call neobundle#untap()
endif

if neobundle#tap('switch.vim')
  nnoremap <silent> - :<C-u>Switch<CR>

  call neobundle#untap()
endif

if neobundle#tap('vim-submode')
  let g:submode_keep_leaving_key = 1

  " 左スクロール
  call submode#enter_with('zh', 'n', '', '<Leader>h', '2zh')
  call submode#map('zh', 'n', '', 'h', '2zh')

  " 右スクロール
  call submode#enter_with('zl', 'n', '', '<Leader>l', '2zl')
  call submode#map('zl', 'n', '', 'l', '2zl')

  " ウィンドウリサイズ
  call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
  call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
  call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
  call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
  call submode#map('winsize', 'n', '', '+', '<C-w>+')
  call submode#map('winsize', 'n', '', '-', '<C-w>-')
  call submode#map('winsize', 'n', '', '>', '<C-w>>')
  call submode#map('winsize', 'n', '', '<', '<C-w><')

  call neobundle#untap()
endif

if neobundle#tap('caw.vim')
  nmap <Leader>c <Plug>(caw:hatpos:toggle)
  vmap <Leader>c <Plug>(caw:hatpos:toggle)

  call neobundle#untap()
endif

if neobundle#tap('wombat256.vim')
  set background=dark
  autocmd MyAutoCmd InsertEnter             * highlight StatusLine   ctermfg=21   ctermbg=226  cterm=BOLD
  autocmd MyAutoCmd InsertLeave,ColorScheme * highlight StatusLine   ctermfg=226  ctermbg=33   cterm=NONE
  autocmd MyAutoCmd ColorScheme             * highlight StatusLineNC ctermfg=240  ctermbg=253
  autocmd MyAutoCmd ColorScheme             * highlight VertSplit    ctermfg=253  ctermbg=253
  autocmd MyAutoCmd ColorScheme             * highlight ColorColumn  ctermfg=NONE ctermbg=16
  autocmd MyAutoCmd ColorScheme             * highlight MatchParen   ctermfg=201  ctermbg=NONE
  autocmd MyAutoCmd ColorScheme             * highlight NonText      ctermfg=236  ctermbg=16
  autocmd MyAutoCmd ColorScheme             * highlight SpecialKey   ctermfg=16   ctermbg=235
  colorscheme wombat256mod

  call neobundle#untap()
endif

scriptencoding utf-8

" encoding=utf-8 設定時のメニュー等文字化け解消
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" ツールバー、メニュー、左右スクロールバーを非表示
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r

" フォント設定
set guifont=Migu_1M:h12

" ウィンドウの大きさを保存、復元
if has('gui_running')
  let g:window_pos_file = expand('~/vimfiles/tmp/vimwinpos')

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

  autocmd MyAutoCmd VimLeavePre * call s:save_window_pos()
endif

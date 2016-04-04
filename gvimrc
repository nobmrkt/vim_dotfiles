scriptencoding utf-8

set langmenu=ja_jp.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set guioptions-=T	" ツールバーを非表示
set guioptions-=m	" メニューを非表示
set guioptions-=r	" 右スクロールバーを非表示
set guioptions-=L	" 左スクロールバーを非表示

" ビープ音の抑制
set noerrorbells
set visualbell t_vb=

" フォントの設定
set guifont=Migu_1M:h12

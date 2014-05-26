" Vundle ----------------------------------------
set nocompatible              " vi 互換ではなく、Vim のデフォルト設定にする設定 
filetype off
filetype plugin indent off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'gmarik/vundle'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'molokai'
NeoBundle 'JavaScript-syntax'
NeoBundle 'vim-scripts/surround.vim'

call neobundle#end()

filetype plugin indent on
NeoBundleCheck

" Basic ----------------------------------------
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set scrolloff=5                  " スクロール時の余白確保
set ic                           " 検索で大文字小文字を区別しない
set incsearch                    " インクリメンタルサーチ

" Color ----------------------------------------
set t_Co=256
syntax on
colorscheme molokai
" set background=light
" set background=dark
" colorscheme solarized

" highlight Visual ctermbg=green
highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=darkmagenta

" 挿入モード時ステータスラインの色を変える
autocmd InsertEnter * highlight StatusLine ctermbg=red guibg=red
autocmd InsertLeave * highlight StatusLine ctermbg=darkmagenta guibg=darkmagenta

set hlsearch                     " 検索結果をハイライト

" Indent ---------------------------------------
set expandtab                 " タブをスペースに展開する
set tabstop=2                 " <TAB>を含むファイルを開いた際、<TAB>を何文字の空白に変換するか
set softtabstop=2             " キーボードで<TAB>を入力した際、<TAB>を何文字の空白に変換するか
set shiftwidth=2              " vimが自動でインデントを行った際、設定する空白数
set autoindent                " 改行時に前の行のインデントを継続する
set smartindent               " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する 

" Display --------------------------------------
set number

" Appearance -----------------------------------
set showmatch         " 括弧の対応をハイライト
set cursorline        " カーソル行をハイライト

" Buffer ---------------------------------------
noremap <Space> :bn<CR>
noremap <S-Space> :bp<CR>
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>
noremap <Down> :ls<CR>

" Status line ----------------------------------
set laststatus=2
set cmdheight=2               " コマンドラインで利用する行数
set statusline=[%L]\ %t%r%m%=\ [%{&ff}]\ %{'['.(&fenc!=''?&fenc:&enc).']'}\ %c:%l



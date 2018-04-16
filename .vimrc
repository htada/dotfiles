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
NeoBundle 'slim-template/vim-slim'
NeoBundle 'vim-scripts/buftabs'
NeoBundle 'othree/html5.vim'
NeoBundle "tyru/caw.vim"         " コメントアウトプラグイン
NeoBundle "thinca/vim-quickrun"  " 実行
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
NeoBundle 'junegunn/fzf.vim'

call neobundle#end()

filetype plugin indent on
NeoBundleCheck

" Basic ----------------------------------------
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set hidden                       " 編集中でもほかのファイルを開けるようにする
set scrolloff=5                  " スクロール時の余白確保
inoremap <silent> jj <ESC>
set grepprg=git\ grep\ -n\ $*
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin

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

" Search ---------------------------------------
set ic                        " 検索で大文字小文字を区別しない
set incsearch                 " インクリメンタルサーチ

set hlsearch                  " 検索結果をハイライト

" Indent ---------------------------------------
set expandtab                 " タブをスペースに展開する
set tabstop=2                 " <TAB>を含むファイルを開いた際、<TAB>を何文字の空白に変換するか
set softtabstop=2             " キーボードで<TAB>を入力した際、<TAB>を何文字の空白に変換するか
set shiftwidth=2              " vimが自動でインデントを行った際、設定する空白数
set autoindent                " 改行時に前の行のインデントを継続する
set smartindent               " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する 
set smarttab                  " 行頭の余白でタブを押すとshiftwidthだけインデントする

" Display --------------------------------------
set number
set showcmd                   " コマンドをステータス行に表示

" encoding -------------------------------------
set termencoding=utf-8        " ターミナルで使われるエンコーディング
set encoding=utf-8            " デフォルトエンコーディング
set fileencoding=utf-8        " デフォルトのファイルエンコーディング
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp-2,euc-jisx0213,euc-jp,cp932 " vimが表示できるエンコードのリスト
set fileformats=unix,mac,dos  " ファイルの改行タイプ指定

set ambiwidth=double          " ASCIIと同じ文字幅 ◆や◯や●

" Appearance -----------------------------------
set showmatch                 " 括弧の対応をハイライト
set cursorline                " カーソル行をハイライト
set wildmenu                  " コマンド補完メニューを表示
set wildmode=list,full        " <TAB>でリスト <TAB><TAB>で完全保管
set history=1000              " コマンドの履歴数

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


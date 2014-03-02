" Vundle ----------------------------------------
set nocompatible              " vi 互換ではなく、Vim のデフォルト設定にする設定 
filetype off
filetype plugin indent off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'vim-perl/vim-perl'
Bundle 'altercation/vim-colors-solarized'
Bundle 'molokai'
Bundle 'JavaScript-syntax'

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

" Indent ---------------------------------------
set expandtab                 " タブをスペースに展開する
set tabstop=2                 " <TAB>を含むファイルを開いた際、<TAB>を何文字の空白に変換するか
set softtabstop=2             " キーボードで<TAB>を入力した際、<TAB>を何文字の空白に変換するか
set shiftwidth=2              " vimが自動でインデントを行った際、設定する空白数
set autoindent                " 改行時に前の行のインデントを継続する
set smartindent               " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する 

" Display --------------------------------------
set number

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

filetype plugin indent on


export LANG=ja_JP.UTF-8

# Emacsライクキーバインド
bindkey -e

# 新規作成ファイルのパーミッションは 664 、新規作成のディレクトリは 755 になる
umask 002

# history
HISTFILE=$HOME/.zhistory    # ヒストリ保存ファイル これを設定すると、履歴保存が有効になる
HISTSIZE=100000             # メモリ上のヒストリ数(履歴検索の対象になる数)
SAVEHIST=$HISTSIZE          # 保存するヒストリ数
setopt extended_history     # ヒストリファイルにコマンドラインだけでなく実行時刻を保存
setopt hist_expand          # ??? 補完時にヒストリを自動的に展開する
setopt hist_ignore_dups     # 同じコマンドラインを連続で実行した場合はヒストリに登録しない
setopt hist_ignore_all_dups # 履歴中の重複行をファイル記録前に無くす
setopt hist_reduce_blanks   # ヒストリに保存する時に余分な空白を削除して保存
setopt hist_save_no_dups    # 古いコマンドと同じものは無視(ヒストリに追加しない)
setopt hist_no_store        # historyコマンドをヒストリリストから除外
setopt hist_ignore_space    # スペースで始まるコマンドラインはヒストリに追加しない
setopt share_history        # zshプロセス間でヒストリを共有する
setopt inc_append_history   # すぐにヒストリファイルに追記する
setopt no_flow_control      # 出力停止、開始用にC-s/C-qを使わない(C-s/C-q によるフロー制御を使わないようにする)

bindkey '^P' history-beginning-search-backward    # 先頭マッチのヒストリサーチ(進む)
bindkey '^N' history-beginning-search-forward     # 先頭マッチのヒストリサーチ(戻る)

setopt autopushd            # 勝手にpushd

# prompt
unsetopt promptcr           # 改行コード(\n)で終わっていなくても出力されるようにする(いちおう)
setopt prompt_subst         # PROMPT内で変数展開・コマンド置換・算術演算を実行する
# setopt prompt_percent     # PROMPT内で「%」文字から始まる置換機能を有効にする
setopt transient_rprompt    # 常に最後の行のみ右プロンプトを表示する
setopt combining_chars      # Macの濁点・半濁点を <3099> <309a> のように表示させない

PROMPT="%n@%m$ "                # 左側のプロンプト
RPROMPT="[%/]"              # 右側のプロンプト
# PROMPT2="%_%%"
# SPROMPT="%r is corrent? [n,y,a,e]: "

autoload -U colors; colors
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=32:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# completion
autoload -U compinit
compinit -u
setopt auto_list          # 補完時にリストを表示
setopt auto_menu          # 連続した補完実行でメニュー補完
setopt list_packed        # 補完候補リストをできるだけコンパクトに
setopt list_types         # 補完候補の末尾にファイルタイプマークを表示
setopt print_eight_bit    # 標準出力時8bitコードを表示
setopt complete_in_word
setopt mark_dirs          # ディレクトリの表示時末尾に/
setopt auto_param_slash   # 補完された変数がディレクトリであった場合、空白ではなくスラッシュが末尾に付加
setopt auto_param_keys    # 変数名の補完が実行されると後に空白などが挿入
setopt magic_equal_subst  # = 以降も補完

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*:(perldoc|perl):*' matcher 'r:|[:][:]=*'

alias ll="ls -lh"
alias lla="ls -lha"
alias llg="ls -lhG"

## git
alias g="git"
alias gs="git status"
alias gb="git branch"

alias grep="grep --color"

## prioritize homebrew
export PATH=~/bin:~/local/bin:/usr/local/bin:$PATH

if which hub > /dev/null 2>&1; then
  eval "$(hub alias -s)"
fi

## xxenv
if which rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if which plenv > /dev/null 2>&1; then
  eval "$(plenv init - zsh)"
fi

if which goenv > /dev/null 2>&1; then
  eval "$(goenv init -)"
fi

if which pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


export EDITOR=vim # 好きなエディタ
function peco-path() {
  local filepath="$(find . | grep -v '/\.' | peco --prompt 'PATH>')"
  [ -z "$filepath" ] && return
  if [ -n "$LBUFFER" ]; then
    BUFFER="$LBUFFER$filepath"
  else
    if [ -d "$filepath" ]; then
      BUFFER="cd $filepath"
    elif [ -f "$filepath" ]; then
      BUFFER="$EDITOR $filepath"
    fi
  fi
  CURSOR=$#BUFFER
}
if which peco > /dev/null 2>&1; then
  zle -N peco-path
  bindkey '^\' peco-path # Ctrl+\ で起動
fi

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}
if which peco > /dev/null 2>&1; then
  zle -N peco-select-history
  bindkey '^r' peco-select-history
fi

## completions
if [ -e /usr/local/share/zsh-completions ]; then
  # by homebrew
  fpath=(/usr/local/share/zsh-completions $fpath)
elif [ -e ~/.zsh/zsh-completions/src ]; then
  # by manual
  fpath=(~/.zsh/zsh-completions/src $fpath)
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 各環境カスタマイズ用
[ -f ~/.zshrc.local ] && source ~/.zshrc.local


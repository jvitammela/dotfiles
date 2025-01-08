if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias oldvim='/usr/bin/vim'
alias vim='nvim'
alias mvim='nvim -c "vsp|wincmd l|sp|wincmd j|term"'

alias vittu='LASTCOMMAND=(fc -ln -1); echo "redoing last command: sudo $("${LASTCOMMAND[@]}")" && sudo $("${LASTCOMMAND[@]}")'
alias zshreload="source ~/.zshrc"
alias hommiin="~/tmux_initialize.sh"

alias kube="kubectl"

alias ghc="git commit -am"
alias bfg="java -jar /home/jaakko/temp/bfg-repo-cleaner-1.14.0/bfg/target/bfg-1.14.0-unknown.jar"

alias ncgrep='grep -v "#"'


# emacs settings seem to be most bash compatible
bindkey -e
#bindkey -v
#bindkey '^R' history-incremental-search-backward

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

#export GPG_TTY=$(tty)
##export GPG_AGENT_INFO=`gpgconf --list-dirs agent-socket | tr -d '\n' && echo -n ::`
#export GPG_AGENT_INFO=""
#

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

#if [ -z "$SSH_AUTH_SOCK" ] ; then
#    eval $(ssh-agent -s)
#  ssh-add
#fi

#hommiin
#

eval "$(zoxide init --cmd cd zsh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

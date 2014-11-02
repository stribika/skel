autoload -U compinit promptinit
compinit
promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
setopt autocd

source ~/.zsh/keybindings
source ~/.zsh/aliases
source ~/.zsh/path
source ~/.zsh/histconf

eval "$(dircolors -b)"
umask 0027

mkcd() {
    mkdir -p "${1}"
    cd "${1}"
}

init_prompt() {
    local color='green'

    if [ "${USER}" = 'root' ]; then
        color='red'
    fi

    export PS1="${1}%B%F{yellow} *** %F{blue}%~\

%F{yellow}%(1j.[%j] .)%F{red}%(?..(%?%) )%F{${color}}%n@%m %F{blue}%# %f%b"
    export RPS1='%B%F{blue}%D{%Y-%m-%d} %F{green}%D{%H:%M:%S}'
    export PS2='%B%F{red}%n@%m%k %B%F{blue}%_> %b%f%k'
}

init_prompt

if [ "${TERM}" != 'screen' ] && tmux -c true; then
    if tmux list-sessions; then
        exec tmux attach-session
    else
        exec tmux
    fi
fi

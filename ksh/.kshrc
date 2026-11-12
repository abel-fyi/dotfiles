# Shared OpenBSD / NetBSD ksh configuration

# --------------------------------------------------
# Interactive shells only
# --------------------------------------------------

case $- in
    *i*) ;;
    *) return ;;
esac

# --------------------------------------------------
# Command history
# --------------------------------------------------

HISTFILE="$HOME/.ksh_history"
HISTSIZE=10000

# --------------------------------------------------
# Prompt helpers
# --------------------------------------------------

# Terminal escape sequences
_KSH_ESC=$(printf '\033')
_KSH_BEL=$(printf '\007')
_KSH_NP=$(printf '\001')

# Display HOME as ~
__ksh_prompt_pwd() {
    case $PWD in
        "$HOME")
            printf '~'
            ;;
        "$HOME"/*)
            printf '~%s' "${PWD#"$HOME"}"
            ;;
        *)
            printf '%s' "$PWD"
            ;;
    esac
}

# Display a red cross after a failed command
__ksh_prompt_error() {
    if [ "$?" -ne 0 ]; then
        printf '\001\033[1;31m\001✗\001\033[0m\001 '
    fi
}

# --------------------------------------------------
# Prompt
# --------------------------------------------------

case $TERM in
    xterm*)
        PS1="${_KSH_NP}${_KSH_ESC}]0;\${PWD}${_KSH_BEL}${_KSH_NP}"
        PS1="${PS1}${_KSH_NP}${_KSH_ESC}[1;38;5;196m${_KSH_NP}\${USER}"
        PS1="${PS1}${_KSH_NP}${_KSH_ESC}[1;38;5;208m${_KSH_NP}@"
        PS1="${PS1}${_KSH_NP}${_KSH_ESC}[1;38;5;226m${_KSH_NP}\$(hostname -s)"
        PS1="${PS1}${_KSH_NP}${_KSH_ESC}[0m${_KSH_NP} "
        PS1="${PS1}${_KSH_NP}${_KSH_ESC}[1;38;5;46m${_KSH_NP}\$(__ksh_prompt_pwd)"
        PS1="${PS1}${_KSH_NP}${_KSH_ESC}[0m${_KSH_NP}
"
        PS1="${PS1}\$(__ksh_prompt_error)"
        PS1="${PS1}${_KSH_NP}${_KSH_ESC}[1;38;5;75m${_KSH_NP}❯"
        PS1="${PS1}${_KSH_NP}${_KSH_ESC}[0m${_KSH_NP} "
        ;;

    *)
        PS1='\${USER}@$(hostname -s) $(__ksh_prompt_pwd)
$(__ksh_prompt_error)❯ '
        ;;
esac

PS2='> '

# --------------------------------------------------
# Aliases
# --------------------------------------------------

alias ll='ls -lah'
alias la='ls -A'
alias lt='ls -ltr'

alias c='clear'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias reload='. "$HOME/.kshrc"'

# --------------------------------------------------
# Functions
# --------------------------------------------------

mkcd() {
    [ "$#" -eq 1 ] || return 2
    mkdir -p "$1" && cd "$1"
}

# --------------------------------------------------
# BSD ls colors
# --------------------------------------------------

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# --------------------------------------------------
# Editor
# --------------------------------------------------

export EDITOR=vi
export VISUAL=vi

# OpenBSD pdksh interactive configuration
case $- in
*i*) ;;
*) return ;;
esac

. /etc/ksh.kshrc

# Persistent command history
HISTFILE="$HOME/.ksh_history"
HISTSIZE=10000

# pdksh expands \u (user), \h (host), and \w (path; HOME becomes ~).
# \[ and \] mark nonprinting color escapes for line editing.
# Hue order: red user, orange @, yellow host, green path, light-blue input.
# Show a red cross before the prompt after a failed command.
case $TERM in
xterm*)
    PS1='\[\e]0;$PWD\007\]\[\e[1;38;5;196m\]\u\[\e[1;38;5;208m\]@\[\e[1;38;5;226m\]\h\[\e[0m\] \[\e[1;38;5;46m\]\w\[\e[0m\]\n\[$(if [ "$?" -ne 0 ]; then printf "\\033[1;31m✗\\033[0m "; fi)\]\[\e[1;38;5;75m\]❯\[\e[0m\] '
    ;;
*)
    PS1='\u@\h \w\n$(if [ "$?" -ne 0 ]; then printf "✗ "; fi)❯ '
    ;;
esac
PS2='> '

# Small interactive shortcuts
alias ll='ls -lah'
alias la='ls -A'
alias lt='ls -ltr'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias reload='. "$HOME/.kshrc"'

mkcd() {
    [ "$#" -eq 1 ] || return 2
    mkdir -p "$1" && cd "$1"
}

# OpenBSD ls colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

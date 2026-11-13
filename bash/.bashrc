# Shared interactive rc: Bash (Linux), ksh (OpenBSD and NetBSD)
case $- in *i*) ;; *) return ;; esac

# History lives under ~/.local/state (or $XDG_STATE_HOME), not ~/.
HISTSIZE=10000
_dot_state=${XDG_STATE_HOME:-$HOME/.local/state}/shell
if mkdir -p -m 700 "$_dot_state" 2>/dev/null; then
    if [ -n "${BASH_VERSION:-}" ]; then
        HISTFILE=$_dot_state/bash_history
        HISTFILESIZE=10000
    else
        HISTFILE=$_dot_state/ksh_history
    fi
else
    unset HISTFILE
fi

# Prompt colors: red user, orange @, yellow host, green path, blue ❯
_dot_user=${USER:-$(id -un)}
_dot_host=$(hostname)
_dot_host=${_dot_host%%.*}
_dot_esc=$(printf '\033')
_dot_bel=$(printf '\007')
_dot_begin=$(printf '\001')
if [ -n "${BASH_VERSION:-}" ]; then
    _dot_end=$(printf '\002')
    _dot_prefix=
else
    _dot_end=$_dot_begin
    _dot_prefix="$_dot_begin$(printf '\r')"
fi
_dot_reset="${_dot_begin}${_dot_esc}[0m${_dot_end}"
_dot_red="${_dot_begin}${_dot_esc}[1;38;5;196m${_dot_end}"
_dot_orange="${_dot_begin}${_dot_esc}[1;38;5;208m${_dot_end}"
_dot_yellow="${_dot_begin}${_dot_esc}[1;38;5;226m${_dot_end}"
_dot_green="${_dot_begin}${_dot_esc}[1;38;5;46m${_dot_end}"
_dot_blue="${_dot_begin}${_dot_esc}[1;38;5;75m${_dot_end}"
_dot_error="${_dot_begin}${_dot_esc}[1;31m${_dot_end}"
_dot_nl='
'

_dot_prompt() {
    _dot_status=$1
    case $PWD in
        "$HOME") _dot_path='~' ;;
        "$HOME"/*) _dot_path="~${PWD#"$HOME"}" ;;
        *) _dot_path=$PWD ;;
    esac

    case ${TERM:-dumb} in
        xterm*|screen*|tmux*|rxvt*|alacritty*|foot*)
            _dot_text="${_dot_prefix}${_dot_begin}${_dot_esc}]0;${PWD}${_dot_bel}${_dot_end}"
            _dot_text="${_dot_text}${_dot_red}${_dot_user}${_dot_orange}@${_dot_yellow}${_dot_host}"
            _dot_text="${_dot_text}${_dot_reset} ${_dot_green}${_dot_path}${_dot_reset}${_dot_nl}"
            [ "$_dot_status" -eq 0 ] || _dot_text="${_dot_text}${_dot_error}✗${_dot_reset} "
            _dot_text="${_dot_text}${_dot_blue}❯${_dot_reset} "
            ;;
        *)
            _dot_text="${_dot_user}@${_dot_host} ${_dot_path}${_dot_nl}"
            [ "$_dot_status" -eq 0 ] || _dot_text="${_dot_text}✗ "
            _dot_text="${_dot_text}❯ "
            ;;
    esac
    if [ -n "${BASH_VERSION:-}" ]; then
        printf '%s' "$_dot_text"
    else
        print -rn "$_dot_text"  # ksh builtin: no external printf per prompt
    fi
}
PS1='$(_dot_prompt "$?")'
PS2='> '

alias ll='ls -lah'
alias la='ls -A'
alias lt='ls -ltr'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
if [ -n "${BASH_VERSION:-}" ]; then
    alias reload='. "$HOME/.bashrc"'
else
    alias reload='. "$HOME/.kshrc"'
fi
mkcd() { [ "$#" -eq 1 ] || return 2; mkdir -p "$1" && cd "$1"; }

export EDITOR=vi VISUAL=vi
set -o emacs

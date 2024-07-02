# vim:filetype=bash:

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

umask 0022
test -x /usr/bin/stty && stty -ixon  # disable Ctrl-S freezing

HISTSIZE=50000
HISTFILESIZE=1000000
HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignoreboth
shopt -s histappend

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(</etc/debian_chroot)
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

PS1='${BASH[((! $?))]:+$?|}'"$PS1"

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto' # iproute2
bind 'TAB: menu-complete'
bind '"\e[Z": menu-complete-backward'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..;'
alias sl=ls
alias vi=vim
export EDITOR=vim
CDPATH=":~"

if command -v eza >/dev/null; then
  alias ls=eza
  alias la='ls -a'
  alias ll='ls -aalF'
  alias l='ls -GF'
elif command -v exa >/dev/null; then
  alias ls=exa
  alias la='ls -a'
  alias ll='ls -aalF'
  alias l='ls -GF'
fi

export LESS="-iR --mouse --wheel-lines=3"
export SYSTEMD_LESS="-iFR"
export PAGER=less
export GPG_TTY="$(tty)"

test -f ~/.bash_aliases && . ~/.bash_aliases
#test -f ~/.Xauthority && export XAUTHORITY=~/.Xauthority

tm() {
  tmux new-session -A -s "${1:-$TMUX_SESSION}"
}

su() {
  if test "$#" -eq 0; then
    sudo -i
  else
    command su "$@"
  fi
}

SSH_AUTH_SOCK="/run/user/$UID/ssh-agent.sock"
if [ -S "$SSH_AUTH_SOCK" ]; then
  export SSH_AUTH_SOCK
else
  unset SSH_AUTH_SOCK
fi

if [ -f "/usr/share/doc/fzf/examples/key-bindings.bash" ]; then
  . /usr/share/doc/fzf/examples/key-bindings.bash
fi

if [ -n "$SSH_CONNECTION" -a -z "$TMUX" -a "$TERM_PROGRAM" != vscode ]; then
  export TMUX_SESSION=ssh
  export -n SSH_CLIENT SSH_CONNECTION SSH_TTY
  if [ -x ~/run/tmux-new.sh ]; then
    ~/run/tmux-new.sh
  elif ! tmux has-session -t "$TMUX_SESSION" 2>/dev/null; then
    # No existing session, create new
    tmux new-session -d -s "$TMUX_SESSION" -n htop sh -c 'while sudo htop -d 10; do :; done'
    tmux new-window -t "$TMUX_SESSION"
  fi
  tmux attach-session -t "$TMUX_SESSION"
fi

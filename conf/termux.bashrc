#!/data/data/com.termux/files/usr/bin/sh

PS1='${BASH[((! $?))]:+$?|}\w \$ '
shopt -s direxpand

PROMPT_DIRTRIM=2
HISTCONTROL=ignoreboth
shopt -s histappend
CDPATH=":~"

if command -v eza &> /dev/null; then
  alias ls='eza'
  alias l='ls -GF'
  alias la='ls -a'
  alias ll='ls -aalF'
else
  alias ls='ls --color=auto'
  alias l='ls -CF'
  alias la='ls -A'
  alias ll='ls -alF'
fi
alias ..='cd ..;'

alias r='fc -e -'
alias x='exit'
alias diff='diff --color=auto'
alias grep='grep --color=auto'

alias cc='cc -pie'
alias c++='c++ -pie'
alias gcc='gcc -pie'
alias g++='g++ -pie'

alias tb='/system/bin/toolbox '
alias ty='/system/bin/toybox '
alias sudo='sudo '
alias su='tsu '

alias chcon='/system/bin/chcon'

umask 0022

export PATH=$HOME/.local/bin:$PATH
export EDITOR=vim
export GPG_TTY="$(tty)"
export LESS="-iR"

# SELinux Context (for convenience)
SECON="u:object_r:app_data_file:s0:c512,c768"

if test -z "$TMUX" && test -n "$SSH_CONNECTION"; then
  export TMUX_SESSION=ssh
  tmux attach -t "$TMUX_SESSION" 2>/dev/null || tmux new-session -s "$TMUX_SESSION"
fi

#!/data/data/com.termux/files/usr/bin/sh

umask 0022

PROMPT_COMMAND() {
	local e=$?
  PROMPT_ECODE=""
	(( e )) && PROMPT_ECODE="$e|"
	return $e
}
PROMPT_COMMAND=PROMPT_COMMAND
PS1='${PROMPT_ECODE}\w \$ '
shopt -s direxpand

PROMPT_DIRTRIM=2
HISTCONTROL=ignoreboth
shopt -s histappend
CDPATH=":~"

alias ls='ls --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ..='cd ..;'

alias r='fc -e -'
alias x='exit'
alias grep='grep --color=auto'

alias cc='cc -pie'
alias c++='c++ -pie'
alias gcc='gcc -pie'
alias g++='g++ -pie'

alias tb='/system/bin/toolbox '
alias ty='/system/bin/toybox '
alias sudo='sudo '
alias su='tsu'

alias chcon='/system/bin/chcon'

if command -v exa >/dev/null; then
  alias ls=exa
  alias la='ls -a'
  alias ll='ls -aalF'
  alias l='ls -GF'
fi

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

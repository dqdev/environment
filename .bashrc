# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

### Setup PS1 ###

#setup git stuff on prompt
source ~/bin/git-prompt.sh

#partial working path
export MYPS='$(echo -n "${PWD/#$HOME/\~}" | awk -F "/" '"'"'{
if (length($0) > 14) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
else if (NF>3) print $1 "/" $2 "/.../" $NF;
else print $1 "/.../" $NF; }
else print $0;}'"'"')'

# 30 = black, 31 = red, 32 = green, 33 = yellow, 34 = blue, 35 = purple, 36 = cyan, 37 = light gray, 40-47 = background, 1 = bold, 4 = underscore, 5 = blink, 7 = inverse, 8 = concealed
if [ "$TMUX" ] ; then
    export PS1="\[\e[1;33m\]\D{%-I:%M%P} \[\e[32m\][\[\e[35m\]\$(eval \"echo ${MYPS}\")\[\e[32m\]]\[\e[36m\]\$(__git_ps1)\[\e[32m\]\$\[\e[0m\] "
else
    export PS1="\[\e[1;33m\]\D{%-I:%M%P} \[\e[32m\][\h:\[\e[35m\]\$(eval \"echo ${MYPS}\")\[\e[32m\]]\[\e[36m\]\$(__git_ps1)\[\e[32m\]\$\[\e[0m\] "
fi


### COLOR ###
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto --group-directories-first'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

### HISTORY ###
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

### Non-Color Alias definitions ###
# Used for tmux->vim debugging mainly, shows full path to source file
alias gdb='gdb --fullname'
alias l='ls -CF'

### MISC ###
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Need this to have Vim mappings that use Ctrl work properly
# it does this by stopping stty when vim runs and then reloading it
# when it starts again
vim()
{
    # osx users, use stty -g
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}

# If no argument provided to tmux, then it starts with curr dir as
# session, also attaches if it already exists
tmux() {
    if [ $# -ge 1 ]; then
        command tmux "$@"
    else
        session_name=$(basename `pwd`)
        command tmux new-session -A -s $session_name
    fi
}

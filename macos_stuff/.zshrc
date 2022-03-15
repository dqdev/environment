setopt PROMPT_SUBST

# Zsh get home and end keys to work properly
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/david.yang/code/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/david.yang/code/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/david.yang/code/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/david.yang/code/tools/google-cloud-sdk/completion.zsh.inc'; fi

# Env Setup
export PATH=$HOME/code/bin:$PATH

# Node 14
export PATH=/usr/local/opt/node@14/bin:$PATH
export LDFLAGS="-L/usr/local/opt/node@14/lib"
export CPPFLAGS="-I/usr/local/opt/node@14/include"

# CSS
export PATH=${KREW_ROOT:-$HOME/.krew}/bin:$PATH
export PATH=/Users/david.yang/patched-php:$PATH
export GOPROXY=https://proxy.golang.org,https://artifactory.cloudkitchens.internal/artifactory/api/go/go,direct
export GOPRIVATE=css.com
export GONOSUMDB=css.com
export GONOPROXY=none
export JAVA_HOME=/usr/local/lib/java/Contents/Home

# MiniKube Docker setup
# export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.64.2:2376"
export DOCKER_CERT_PATH="/Users/david.yang/.minikube/certs"
export MINIKUBE_ACTIVE_DOCKERD="minikube"

# To point your shell to minikube's docker-daemon, run:
eval $(minikube -p minikube docker-env)

#setup git stuff on prompt
source ~/code/bin/git-prompt.sh

#partial working path
export MYPS='$(echo -n "${PWD/#$HOME/\~}" | awk -F "/" '"'"'{
if (length($0) > 14) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
else if (NF>3) print $1 "/" $2 "/.../" $NF;
else print $1 "/.../" $NF; }
else print $0;}'"'"')'

# 30 = black, 31 = red, 32 = green, 33 = yellow, 34 = blue, 35 = purple, 36 = cyan, 37 = light gray, 40-47 = background, 1 = bold, 4 = underscore, 5 = blink, 7 = inverse, 8 = concealed
# PS1
#export PS1=$'%B%F{yellow}%D{%-I:%M%p} %F{green}%M:%F{5}%3~%F{cyan}$(__git_ps1)%F{green}$ \e[0m'
export PS1=$'%B%F{yellow}%D{%-I:%M%p} %F{green}%M:%F{5}$(eval "echo ${MYPS}")%F{cyan}$(__git_ps1)%F{green}$ %f%b'

#### FZF ####
export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git'
export FZF_DEFAULT_OPTS="--ansi" #enables fd color in fzf

if [ -f '/usr/local/opt/fzf/shell/key-bindings.zsh' ]; then . '/usr/local/opt/fzf/shell/key-bindings.zsh'; fi
if [ -f '/usr/local/opt/fzf/shell/completion.zsh' ]; then . '/usr/local/opt/fzf/shell/completion.zsh'; fi

### COLOR ###
#alias grep='grep --color=auto'
alias grep='rg --column --line-number --hidden --no-heading --color=always --smart-case'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='gls --color=auto --group-directories-first'
alias v='command vim'
alias fzf='fzf-tmux'
alias f='vim $(fzf-tmux --preview "bat --style=numbers --color=always --line-range :500 {}") -c "if !argc() | qa | endif"'
alias cat='bat'
alias python="python3"

# Need this to have Vim mappings that use Ctrl work properly
# it does this by stopping stty when vim runs and then reloading it
# when it starts again
vim()
{
    # osx users, use stty -g
    local STTYOPTS="$(stty -g)"
    stty stop '' -ixoff
    if [ "$TMUX" ] ; then
        command tmux split-window -h "vim $@"
    else
        command vim $@
    fi
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

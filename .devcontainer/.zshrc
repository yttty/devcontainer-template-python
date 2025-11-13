################ oh-my-zsh configuration ################
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
export ZSH=$HOME/.oh-my-zsh

# omz auto update
export UPDATE_ZSH_DAYS=182

# omz themes: https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

# omz completion & correction
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"

# omz plugins: https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(git colored-man-pages)

# activate omz
source $ZSH/oh-my-zsh.sh

################ alias configuration ################
# override those provided by oh-my-zsh libs, plugins, and themes.
alias l='ls -lAh'
alias cls='clear'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -h'
alias df='df -h'
alias g='git'

# alias for git (not included in the official git pulgin)
gclb() { git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done; }
ggraph() { git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative; }
gcmu() { git commit -m "chore: update"; }
gcmm() { git commit -m $1; }
gce() { git credential-cache exit; }

################ git-credential-manager configuration ################
export GCM_CREDENTIAL_STORE=cache
export GCM_CREDENTIAL_CACHE_OPTIONS="--timeout 900"

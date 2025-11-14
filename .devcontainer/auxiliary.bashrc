# export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWUNTRACKEDFILES=1
# export GIT_PS1_SHOWSTASHSTATE=1
# export GIT_PS1_SHOWUPSTREAM="auto"

__git_status() {
    if git rev-parse --git-dir >/dev/null 2>&1; then
        local git_status=""
        local has_changes=$(git status --porcelain 2>/dev/null)

        # if [[ -n "$has_changes" ]]; then
        #     git_status="[x]"  # has changes
        # else
        #     git_status="[o]"  # no changes
        # fi

        # Optional: Display different markers depending on the situation
        if [[ -n "$(git status --porcelain --untracked-files=no 2>/dev/null)" ]]; then
            git_status="[x]"  # tracked changes
        elif [[ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
            git_status="[?]"  # untracked only
        else
            git_status="[o]"  # totally clean
        fi

        echo "$git_status"
    fi
}

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]$(__git_ps1 "(%s)")\[\033[00m\]\[\033[01;36m\]$(__git_status)\[\033[00m\]\$ '

# alias for system utilities
alias l='ls -lAh'
alias cls='clear'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -h'
alias df='df -h'

# alias for git
gclb() { git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done; }
gcmu() { git commit -m "chore: update"; }
gcmm() { git commit -m $1; }
gce() { git credential-cache exit; }
gaa() { git add --all; }
gd() { git diff; }
gdc() { git diff --cached; }
ggraph() { git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative; }
gfind() { git log --grep $1; } # Grep in commit message
ghist() { git log -p -M --follow --stat $1; } # History of a file
glp() { git log -p $1; }
gll() { git log --stat; }
gsha() { git rev-parse HEAD; }
gst() { git status; }
gtop() { git log --stat -n 1; }
gb() { git branch; }
gba() { git branch --all; }
gbd() { git branch --delete $1; }

alias g='git'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -d'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -D'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcb='git checkout -b'
alias gcbd='git checkout -b dev'
alias gcd='git checkout dev'
alias gcB='git checkout -B'
alias gcm='git checkout main'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gclean='git clean --interactive -d'
alias gcl='git clone --recurse-submodules'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'

# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
# alias reloadshell="omz reload"
# alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
# alias ll="/opt/homebrew/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"

# Directories
alias dotfiles="cd $DOTFILES"

# Docker
# alias docker-composer="docker-compose"

# SQL Server
# alias mssql="docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=LaravelWow1986! -p 1433:1433 mcr.microsoft.com/mssql/server:2017-latest"

# Git
# alias gst="git status"
# alias gb="git branch"
# alias gc="git checkout"
# alias gl="git log --oneline --decorate --color"
# alias amend="git add . && git commit --amend --no-edit"
# alias commit="git add . && git commit -m"
# alias diff="git diff"
# alias force="git push --force"
# alias nuke="git clean -df && git reset --hard"
# alias pop="git stash pop"
# alias pull="git pull"
# alias push="git push"
# alias resolve="git add . && git commit --no-edit"
# alias stash="git stash -u"
# alias unstage="git restore --staged ."
# alias wip="commit wip"

alias vi="~/nvim-macos/bin/nvim"
alias r="source ~/.zshrc"
alias tmuxsrc="tmux source ~/.config/tmux/tmux.conf"
alias tat='tmux new-session -As $(basename "$PWD" | tr . -)' # will attach if session exists, or create a new session
alias tmuxkillall="tmux ls | cut -d : -f 1 | xargs -I {} tmux kill-session -t {}" # tmux kill all sessions
alias ct="ctags -R --exclude=.git --exclude=node_modules"
alias dotfiles="ls -a | grep '^\.' | grep --invert-match '\.DS_Store\|\.$'"
alias redux_rspec="HEADLESS=false REDUX_DEVTOOLS_IN_TEST=true bundle exec rspec"
alias rspec="bundle exec rspec"
alias serve="bundle exec rails s"
alias con="bundle exec rails c"
alias prod_console="heroku run rails c -a blitzinsurance-prod -s Standard-2X"
alias dev="bin/dev"
alias devs="bin/dev-static"
alias migrate="rails db:migrate"
alias clean_branches='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias pr='open "https://github.com/$(git remote get-url origin | sed -E "s/.*:(.+)\/(.+).git/\1\/\2/")/pull/new/$(git rev-parse --abbrev-ref HEAD)"'
alias eslint_bundles="npx eslint ./app/javascript/bundles --ext .js,.jsx --fix"
alias gb="git branch"
alias gs="git status"
alias co="git checkout"
alias gc="git commit -m"
alias ga="git add"
alias cb="git checkout -b"
alias gl="git pull"
alias gpo="git pull origin main"
alias gd="git diff"
alias gpu="git push -u origin $(git rev-parse --abbrev-ref HEAD)"
alias gp="git push"
alias blitz="~/blitz_session.sh"
alias blitz_kill="tmux kill-ses -t blitz"
alias blitz_restart="blitz_kill && blitz"

export PATH="$HOME/.local/bin:$PATH"

# autocompletion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z1-A-Z}={A-Z1-a-z}'

# loading other plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# history Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY          # Don't overwrite history
setopt SHARE_HISTORY           # Share history between sessions
setopt HIST_IGNORE_DUPS        # Don't record same line twice
setopt HIST_IGNORE_SPACE       # Don't record commands starting with a space

# variables
export LS_COLORS="$(vivid generate gruvbox-dark)"
export MANPAGER="batman"
export DISPLAY=:0 # x11 compatibility

update() {
  echo "--- Updating System & AUR ---"
  paru -Syu
  echo "--- Updating Flatpaks ---"
  flatpak update
  echo "--- Cleaning up old package cache ---"
  paru -Sc --noconfirm
}

# aliases
alias tt="taskwarrior-tui"
alias nwf="neowofetch"

alias ls='lsd --group-directories-first'
alias l='lsd -l --group-directories-first'
alias la='lsd -a --group-directories-first'
alias lla='lsd -la --group-directories-first'
alias lt="lsd --tree"

# Sudo Plugin (ESC ESC to add sudo)
sudo-command-line() {
    [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"
    [[ $BUFFER == sudo\ * ]] && { BUFFER="${BUFFER#sudo }"; CURSOR=$((CURSOR - 5)) } || { BUFFER="sudo $BUFFER"; CURSOR=$((CURSOR + 5)) }
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

PROMPT='[%B%F{red}%n%f%F{cyan}@%f%F{red}%m%f %F{blue}%~%f]%F{green}$%f%b '

fortune | cowsay -r | lolcat

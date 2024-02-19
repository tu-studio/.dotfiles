# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install

# Great zsh Theme
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
# Standard way to do something conditional on terminal capabilities is to look at TERM environment variable (TERM is usually propagated through ssh connections).
# Zsh knows how to infer terminal capabilities from the value of TERM, so we can just ask zsh if the terminal supports at least 256 colors.
if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
  [[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh
else
  [[ ! -f ~/.zsh/.p10k-portable.zsh ]] || source ~/.zsh/.p10k-portable.zsh
fi

# Use history substring search
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# Bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Costum ones
# Case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit
# No beep sounds from tab completion
setopt nobeep

# Aliases
alias v="source venv/bin/activate"
alias c="cmake -B build"

pathappend() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
}

# For the notify-send script volume_sink and volume_source
export NID_SINK_VOLUME=9998
export NID_SOURCE_VOLUME=9999
export LC_ALL=C.UTF-8

pathappend "$HOME/.local/bin"

# Special shortcuts for jumping words
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# editor selection
export EDITOR=nano

neofetch
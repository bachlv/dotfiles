# zmodload zsh/zprof
setopt histignoredups
bindkey -v

export EDITOR="nvim"
export VISUAL="nvim"
export GPG_TTY=$(tty)
export XDG_CONFIG_HOME="$HOME/.config"

alias vim="nvim"
alias rls=$(which ls)
alias ls="$(which eza) --icons=auto"

export FZF_DEFAULT_OPTS="
  --walker-skip .git,node_modules,target
  --preview '[[ -d {} ]] && eza -1 --icons=always --color=always --no-quotes {} || bat --plain --color=always {}'
  --preview-window hidden
  --bind 'ctrl-/:change-preview-window(right|hidden),ctrl-b:preview-up,ctrl-f:preview-down,ctrl-u:half-page-up,ctrl-d:half-page-down'
  --pointer='' --prompt=' '
  --ansi
  --color=fg:#524f67,bg:-1,hl:#31748f
  --color=fg+:-1,bg+:#26233a,hl+:#9ccfd8
  --color=info:#524f67,prompt:#eb6f92,pointer:#eb6f92
  --color=marker:#9ccfd8,spinner:#ebbcba,header:#87afaf,border:#524f67,gutter:-1
  --height 50% --tmux 65%,70% --layout reverse"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"
command -v go &> /dev/null && export PATH="/opt/homebrew/opt/make/libexec/gnubin:$(go env GOPATH)/bin:$PATH"

# Add .local/bin to PATH
. "$HOME/.local/bin/env"

### Added by Zinit's installer 
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
###

# Zinit config
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

autoload compinit
compinit

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --tmux "65%,65%"
zstyle ':fzf-tab:complete:*' fzf-preview '[[ -d $realpath ]] && eza -1 --icons=always --color=always --no-quotes "$realpath" || bat --plain --color=always "$realpath"'
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

zinit ice wait"1" lucid
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait lucid atload"_zsh_autosuggest_start; bindkey '^ ' autosuggest-accept;"
zinit light zsh-users/zsh-autosuggestions

# zprof

# pnpm
export PNPM_HOME="/Users/bach/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

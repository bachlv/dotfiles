# zmodload zsh/zprof

setopt histignoredups

export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
alias rls=$(which ls)
alias ls="$(which eza) --icons=auto"

export FZF_DEFAULT_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --preview-window hidden
  --bind 'ctrl-/:change-preview-window(right|hidden)'
  --pointer=''
  --prompt=' '
  --ansi
  --color=fg:#524f67,bg:-1,hl:#31748f
  --color=fg+:-1,bg+:#26233a,hl+:#9ccfd8
  --color=info:#524f67,prompt:#eb6f92,pointer:#eb6f92
  --color=marker:#9ccfd8,spinner:#ebbcba,header:#87afaf,border:#524f67,gutter:-1"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# export PATH="/opt/homebrew/opt/make/libexec/gnubin:$(go env GOPATH)/bin:$PATH"

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

# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# zstyle ':fzf-tab:*' fzf-flags --tmux bottom
zstyle ':fzf-tab:*' fzf-preview 'bat --color=always $realpath'
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

zinit ice wait"1" lucid
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait lucid atload"_zsh_autosuggest_start; bindkey '^ ' autosuggest-accept"
zinit light zsh-users/zsh-autosuggestions
zstyle ":history-search-multi-word" highlight-color "bg=0,bold"
zinit ice wait"1" lucid
zinit load atuinsh/atuin

# zprof


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"


# Start the tmux session if not alraedy in the tmux session
if command -v tmux >/dev/null 2>&1 && [[ ! -n $TMUX ]]; then
  # Get the session IDs
  session_ids="$(tmux list-sessions)"

  # Create new session if no sessions exist
  if [[ -z "$session_ids" ]]; then
    tmux new-session
  fi

  # Select from following choices
  #   - Attach existing session
  #   - Create new session
  #   - Start without tmux
  create_new_session="Create new session"
  start_without_tmux="Start without tmux"
  choices="$session_ids\n${create_new_session}:\n${start_without_tmux}:"
  choice="$(echo $choices | fzf | cut -d: -f1)"

  if expr "$choice" : "[0-9]*$" >&/dev/null; then
    # Attach existing session
    tmux attach-session -t "$choice"
  elif [[ "$choice" = "${create_new_session}" ]]; then
    # Create new session
    tmux new-session
  elif [[ "$choice" = "${start_without_tmux}" ]]; then
    # Start without tmux
    :
  fi
fi

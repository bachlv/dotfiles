# zmodload zsh/zprof

setopt histignoredups

export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
alias rls=$(which ls)
alias ls="$(which eza) --icons"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --pointer=""
 --prompt=""
 --color=fg:#524f67,bg:-1,hl:#31748f
 --color=fg+:-1,bg+:#26233a,hl+:#9ccfd8
 --color=info:#524f67,prompt:#eb6f92,pointer:#eb6f92
 --color=marker:#9ccfd8,spinner:#ebbcba,header:#87afaf,border:#524f67,gutter:-1'

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# export PATH="/opt/homebrew/opt/make/libexec/gnubin:$(go env GOPATH)/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

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


# https://zdharma-continuum.github.io/zinit/wiki/Example-Minimal-Setup/
zinit wait lucid for \
atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
atload"_zsh_autosuggest_start; bindkey '^ ' autosuggest-accept;" \
    zsh-users/zsh-autosuggestions \
    Aloxaf/fzf-tab \
    zdharma-continuum/history-search-multi-word \
blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

zstyle ":history-search-multi-word" highlight-color "bg=8,bold"


# zprof

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

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
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
eval "$(zoxide init zsh)"


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



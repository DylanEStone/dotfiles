# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.config/antigen.zsh

export PATH=/opt/homebrew/bin/:$PATH
export PATH="${PATH}:${HOME}/.local/bin/"
PATH+="$PATH:/opt/built/bin/"
PATH+="$PATH:/opt/homebrew/lib/python3.10/site-package/"
PATH+="$PATH:/opt/homebrew/opt/qt5/bin/"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle sudo
antigen bundle tmux
antigen bundle fasd
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

plugins=(
  git
  bundler
  dotenv
  macos
  rake
  rbenv
  ruby
)

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

alias vim="nvim"
alias v="nvim"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
alias code='cd ~/Documents/Code'
alias c='clear'
alias h='history'
alias keka='/Applications/Keka.app/Contents/MacOS/Keka --cli'
alias editvim='v ~/.config/nvim/init.vim'

# qmk autocomplete
autoload -Uz bashcompinit && bashcompinit

# Use Node without SUDO
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH=\"\$NPM_PACKAGES/lib/node_modules:\$NODE_PATH\"
PATH+="$PATH:$NPM_PACKAGES/bin"

# Created by `pipx` on 2022-07-20 23:35:59
export PATH="$PATH:/Users/dylanstone/.local/bin"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;v:imgview'

export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'

#export NNN_OPENER="/Users/dylanstone/.config/nnn/plugins/nuke"

export NNN_OPENER=nvim

export NNN_COLORS='1234'

# nnn config
n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn -c "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

nnn_cd()                                                                                                   
{
    if ! [ -z "$NNN_PIPE" ]; then
        printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
    fi  
}

trap nnn_cd EXIT

fpath+=~/.config/nnn/misc/auto-completion/zsh

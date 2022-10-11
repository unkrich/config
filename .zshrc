## ALIASES ##
alias g="git"

## ZSH SETUP ##
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Homebrew
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# OpenSSL
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

# Ruby
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
chruby ruby-3.1.2

# Java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export NODE_OPTIONS=--openssl-legacy-provider

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

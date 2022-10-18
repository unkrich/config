###################################
# XCODE                           #
###################################

XCODEINSTALLED=`which xcode-select`
if [[ ${XCODEINSTALLED} == "" ]]; then
  echo "Installing Xcode"
  xcode-select --install
fi

###################################
# NIX                             #
###################################

curl -L https://nixos.org/nix/install | sh

# Enable nix-command and flakes to bootstrap
mkdir -p ~/.config/nix
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

# Until this is addressed https://github.com/LnL7/nix-darwin/issues/149
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf

# Build the configuration
nix build .#darwinConfigurations.Kevins-MacBook-Pro.system
./result/sw/bin/darwin-rebuild switch --flake .


###################################
# ZSH                             #
###################################

ln -s ${PWD}/.zshrc ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


###################################
# HOMEBREW                        #
###################################

sh .homebrew

###################################
# XCODE                           #
###################################

XCODEINSTALLED=`which xcode-select`
if [[ ${XCODEINSTALLED} == "" ]]; then
  echo "Installing Xcode"
  xcode-select --install
fi

###################################
# HOMEBREW INSTALL                #
###################################

# if [[ ${BREWINSTALLED} == "" ]]; then
echo "Installing Brew"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

###################################
# NIX                             #
###################################

curl -L https://nixos.org/nix/install | sh

source /etc/zshrc

# Enable nix-command and flakes to bootstrap
mkdir -p ~/.config/nix
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

# Until this is addressed https://github.com/LnL7/nix-darwin/issues/149
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf

# IDK why - some issue: https://github.com/LnL7/nix-darwin/issues/451
printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t


# Build the configuration
nix build .#darwinConfigurations.Kevins-MacBook-Pro.system
./result/sw/bin/darwin-rebuild switch --flake .


###################################
# ZSH                             #
###################################

ln -s ${PWD}/.zshrc ~/.zshrc
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


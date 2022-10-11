# Let's install nix (at the time of writing this is version 2.5.1
curl -L https://nixos.org/nix/install | sh

# Emable nix-command and flakes to bootstrap 
mkdir -p ~/.config/nix
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

# Until this is addressed https://github.com/LnL7/nix-darwin/issues/149
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf

# Build the configuration
nix build .#darwinConfigurations.hostname.system
./result/sw/bin/darwin-rebuild switch --flake .

# 
# Enjoy!

{
  description = "Kevin's darwin system";
  
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Other sources
    comma = { url = github:Shopify/comma; flake = false; };
    
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
  
  let 

    inherit (darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs-unstable.lib) attrValues makeOverridable optionalAttrs singleton;

    # Configuration for `nixpkgs`
    nixpkgsConfig = {
      config = { allowUnfree = true; };
      overlays = attrValues self.overlays ++ singleton (
        # Sub in x86 version of packages that don't build on Apple Silicon yet
        final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          inherit (final.pkgs-x86)
            idris2
            nix-index
            niv
            purescript;
        })
      );
    }; 
  in
  {
    # My `nix-darwin` configs
      
    darwinConfigurations = rec {
      Kevins-MacBook-Pro = darwinSystem {
        system = "aarch64-darwin";
        modules = attrValues self.darwinModules ++ [ 
          # Main `nix-darwin` config
          ./configuration.nix
          # `home-manager` module
          home-manager.darwinModules.home-manager
          {
            # Import other Nix files
            imports = [
              # ./git.nix
              # ./neovim.nix
              # ./tmux.nix
            ];
            nixpkgs = nixpkgsConfig;
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kevinunkrich = import ./home.nix;            

          }
        ];
      };
    };

    # Overlays --------------------------------------------------------------- {{{

    overlays = {
      # Overlays to add various packages into package set
        comma = final: prev: {
          comma = import inputs.comma { inherit (prev) pkgs; };
        };  

      # Overlay useful on Macs with Apple Silicon
        apple-silicon = final: prev: optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          # Add access to x86 packages system is running Apple Silicon
          pkgs-x86 = import inputs.nixpkgs-unstable {
            system = "x86_64-darwin";
            inherit (nixpkgsConfig) config;
          };
        }; 
      };

    # My `nix-darwin` modules that are pending upstream, or patched versions waiting on upstream
    # fixes.
    darwinModules = {
      programs-nix-index = 
        # Additional configuration for `nix-index` to enable `command-not-found` functionality with Fish.
        { config, lib, pkgs, ... }:

        {
          config = lib.mkIf config.programs.nix-index.enable {
            programs.fish.interactiveShellInit = ''
              function __fish_command_not_found_handler --on-event="fish_command_not_found"
                ${if config.programs.fish.useBabelfish then ''
                command_not_found_handle $argv
                '' else ''
                ${pkgs.bashInteractive}/bin/bash -c \
                  "source ${config.programs.nix-index.package}/etc/profile.d/command-not-found.sh; command_not_found_handle $argv"
                ''}
              end
            '';
            };
        };
    };
 };

}

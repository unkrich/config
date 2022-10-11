{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kevinunkrich";
  # home.homeDirectory = "/Users/kevinunkrich";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "$EDITOR";
  };

  # Enables GUI MacOS applications to work
  # Symlink macos applications. This does not happen by default.
  # https://github.com/nix-community/home-manager/issues/1341
  home.activation = lib.mkIf pkgs.stdenv.isDarwin {
    copyApplications = let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        baseDir="/Applications/Home Manager Apps"
        if [ -d "$baseDir" ]; then
          sudo rm -rf "$baseDir"
        fi
        mkdir -p "$baseDir"
        for appFile in ${apps}/Applications/*; do
          target="$baseDir/$(basename "$appFile")"
          $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
          $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
        done
      '';
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Import other Nix files
  imports = [
    # ./git.nix
    # ./neovim.nix
    # ./tmux.nix
  ];

  # pythonPackages = with pkgs.python38Packages; [
  #   bpython
  #   openapi-spec-validator
  #   pip
  #   requests
  #   setuptools
  # ];

  # nodePackages = with pkgs.nodePackages; [
  #   typescript
  # ];

  # ruby27Packages = with pkgs.rubyPackages_2_7; [
  #   jekyll
  #   jekyll-watch
  #   pry
  #   rails
  # ];

  # ruby31Packages = with pkgs.rubyPackages_3_1; [
  #   jekyll
  #   jekyll-watch
  #   pry
  #   rails
  # ];
  
  # gitTools = with pkgs.gitAndTools; [
  #   gh
  # ];


  # Miscellaneous packages (in alphabetical order)
  home.packages = with pkgs; [
    # _1password-gui # multi-platform password manager - ARCH
    # adoptopenjdk-bin # Java
    # arduino # Open source electronics proto platform - ARCH
    # arq - missing
    autoconf # Broadly used tool, no clue what it does
    awscli # Amazon Web Services CLI 
    bash # /bin/bash
    bat # cat replacement written in Rust
    clojure # lisp dialect for JVM
    coreutils # GNU utilities
    # cron - missing
    curl # An old classic
    # dash - missing
    dbus # for spotifyd
    direnv # Per-directory environment variables
    # discord # desktop chat - ARCH
    docker # World's #1 container tool
    docker-compose # Local multi-container Docker environments
    docker-machine # Docker daemon for macOS
    dockutil # Tool for managing dock items
    ffmpeg # audio and video tools
    fzf # Fuzzy finder
    go # Golang
    # google-chrome # browser - ARCH
    google-cloud-sdk # Google Cloud Platform CLI
    gnupg
    heroku
    iterm2 # replacement for terminal
    jq # JSON parsing for the CLI
    # kicad # Open source electronics design
    ngrok # Expose local HTTP stuff publicly
    # ledger-live-desktop # wallet app for ledger nano S - ARCH
    leiningen # clojure tools
    libyaml
    # linear - missing
    # logitech-options - missing
    lua # Programming lang. Lua
    # microsoft-office - missing
    mysql80
    # netlify-cli # netlify
    nerdfonts
    nodejs # node and npm
    # notion - missing
    # notunes - missing
    # obs-studio # video recording / streaming - ARCH
    # openscad # 3d parametric model compiler - UNKNOWN ERR
    openssl
    packer # HashiCorp tool for building machine images
    pgadmin4 # Admin and dev platform for PG
    # pgadmin desktop - missing
    pkg-config # for spotifyd
    portaudio # for spotifyd
    postgresql_14 # Everyone's favorite DB
    postman
    # private-internet-access - missing
    protobuf # Protocol Buffers
    python2 # Gotta catch'em all
    python38 # Have you upgraded yet???
    # qbittorrent # sh - ARCH
    ripgrep # grep replacement written in Rust
    redis # key-value store
    # ruby_2_7 # An old classic
    ruby_3_1 # the new stuff
    rustup # Rust dev environment management
    rust-analyzer # Rust LSP
    slack # desktop client
    # slack-term
    spacebar # minimal status bar for macOS
    # spotify # desktop - ARCH
    spotify-tui # Spotify interface for the CLI
    spotifyd # Spotify server
    skhd # hotkey daemon for macOS
    sqlite # light, useful, and making a comeback
    # sublime4 # text editor - ARCH
    sumneko-lua-language-server # Lua Lang. Server coded by Lua
    # superhuman - missing
    terraform # Declarative infrastructure management
    tig # git TUI
    tree # Should be included in macOS but it's not
    tree-sitter # parser generator tool
    # ultimate-cura - missing
    vault # Secret management
    # vlc # media player/server - ARCH
    yabai # tiling window manager
    yarn # Node.js package manager
    youtube-dl # Download videos
    # zappy - missing
    zoom-us # video conferencing
    zsh-z # Jump quickly to frequent dirs
  ];


  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;  
  xdg.configFile."nvim/lua/base.lua".source = ./nvim/lua/base.lua;  
  xdg.configFile."nvim/after".source = ./nvim/after;  
  xdg.configFile."nvim/after".recursive = true;
  # ] ++ gitTools ++ pythonPackages ++ rubyPackages;
}

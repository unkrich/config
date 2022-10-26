{ pkgs, lib, ... }:
{
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.configureBuildUsers = true;

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  # environment.systemPackages = with pkgs; [
  # ];

  # https://github.com/nix-community/home-manager/issues/423
  programs.nix-index.enable = true;

  services.skhd.enable = true;
  services.yabai.enable = true;

  # Fonts
  # fonts.fontDir.enable = true;

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Enable full keyboard control - tab in modals
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;

  # Delay / Repeat
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  
  # Disable automatic period substitution
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;

  # Disable smart quotes as they're annoying when typing code
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;

  # Disable smart dashes
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;

  # Disable automatic capitalization
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;

  # Disable automatic spelling correciton
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # Add ability to used TouchID for sudo authentication
  # security.pam.enableSudoTouchIdAuth = true;

  imports = [
    # ./neovim.nix
  ];

  #### SCREENSHOTS ####

  # Set screenshot location
  system.defaults.screencapture.location = "~/Pictures";
  # Ideally ~/Pictures/screenshots

  # disable shadow in screenshots
  system.defaults.screencapture.disable-shadow = true;

  # Save screenshots as png
  system.defaults.screencapture.type = "png";


  #### DOCK ####

  # Hide dock and set to left-hand side
  system.defaults.dock.orientation = "left";

  # Don't show recent applications in dock
  system.defaults.dock.show-recents = false;

  # Set icon size of Dock items to 30 pixels
  system.defaults.dock.tilesize = 30;

  # Speed up Mission Control animation 
  system.defaults.dock.expose-animation-duration = 0.1;
  
  # Automatically hide dock
  system.defaults.dock.autohide = true;
  
  # Remove the auto-hiding Dock delay
  system.defaults.dock.autohide-delay = 0.0001;

  # Remove the animation when hiding/showing the Dock
  system.defaults.dock.autohide-time-modifier = 0.0001;

  # Dont rearrange spaces based on recent use
  system.defaults.dock.mru-spaces = false;

  #### FINDER ####

  # Preferences - show filename extensions
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;

  # Enable showing dotfiles (just hold Cmd + Shift + . (dot) in a finder window)
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;

  # Show full path in finder
  system.defaults.finder._FXShowPosixPathInTitle = true;
 
  # Disable the "Are you sure you want to open this application" dialog
  system.defaults.LaunchServices.LSQuarantine = false;

  # Disable the warning when changing a file extension
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  # Use list view in all Finder windows by default
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  
 # Disable animations when opening and closing windows 
  system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;

  # Accelerated playback when adjusting the window size.
  system.defaults.NSGlobalDomain.NSWindowResizeTime = 0.001;
  
  # Finder: allow quitting via command Q
  system.defaults.finder.QuitMenuItem = true;

  # Expand save and print panel by default
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;

  homebrew.enable = true;
  homebrew.taps = [ "homebrew/cask" ];
  homebrew.brews = [
    "homebrew/cask-drivers/logitech-options"
  ];
  homebrew.casks = [
    "google-chrome"
    "notion"
    "discord"
    "spotify"
    "cron"
    "superhuman"
    "linear-linear"
    "ledger-live"
    "qbittorrent"
    "vlc"
    "kicad"
    "openscad"
    "ultimaker-cura"
    "private-internet-access"
    "obs"
    "zappy"
    "muzzle"
    "arq"
    "dash"
    "pgadmin4"
    "hpedrorodrigues/tools/dockutil"
    "arduino"
  ];

  homebrew.masApps = {
    "Paste" = 967805235;
    "Pages" = 409201541;
  };

  # services.skhd.enable = true;
  # services.spacebar.enable = true;
  # services.spotifyd.enable = true;
  # services.yabai.enable = true;
  # services.yabai.enableScriptingAddition = true;

  # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.CustomSystemPreferences
  # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.CustomUserPreferences/
  
  # Autohide menubar
  # system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  
  # Animate opening applications from the dock 
  system.defaults.dock.launchanim = false;

  # Whether to minimize windows into their application icon. The default is false.
  # system.defaults.dock.minimize-to-application = true;
  
  
}

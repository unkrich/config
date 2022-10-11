{ config, lib, pkgs, ... }:

{
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Kevin Unkrich";
    userEmail = "kevin@unkri.ch";

    # Replaces ~/.gitignore
    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "built-in-stubs.jar"
      "dumb.rdb"
      ".elixir_ls/"
      ".vscode/"
      "npm-debug.log"
      "shell.nix"
    ];

    # Replaces aliases in ~/.gitconfig
    aliases = {
      br = "branch";
      co = "checkout";
      cob = "checkout -b";
      ci = "commit";
      cm = "commit -m";
      cp = "commit -p";
      d = "diff";
    };

    # Global Git config
    extraConfig = {
      core = {
        editor = "nvim";
        pager = "delta --dark";
        whitespace = "trailing-space,space-before-tab";
      };


      protocol.keybase.allow = "always";
      credential.helper = "osxkeychain";
      pull.rebase = "false";
    };
  };
}

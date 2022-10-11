{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # Sets alias vim=nvim
    vimAlias = true;

    extraConfig = ''
      :luafile ~/.config/nvim/lua/init.lua
    '';

    # Neovim plugins
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-nvim-lsp
      cmp_luasnip
      ctrlp
      editorconfig-vim
      gitsigns-nvim
      gruvbox
      indent-blankline-nvim
      lualine-nvim
      luasnip
      null-ls-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter
      nvim-web-devicons
      plenary-nvim
      tabular
      telescope-nvim
      telescope-fzy-native-nvim
      vim-commentary
      vim-elixir
      vim-fugitive
      vim-nix
      vim-markdown
      vim-prettier
    ];
  };
}

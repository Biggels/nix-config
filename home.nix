{ pkgs, ... }:

{
  home.username = "biggels";
  home.homeDirectory = "/home/biggels";

  # Match your system.stateVersion
  home.stateVersion = "25.05";

  # User packages (apps and CLI tools)
  home.packages = with pkgs; [
    zed-editor
    ncspot
    ripgrep
    fd
    tree
  ];

  # Neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Emacs configuration
  programs.emacs.enable = true;

  # Git configuration (moved from configuration.nix)
  programs.git = {
    enable = true;
    userName = "Biggels";
    userEmail = "haackra@gmail.com";
  };

  # Manage shell settings (optional starter example)
  programs.zsh.enable = false;

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}

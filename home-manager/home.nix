{ pkgs, username, ... }:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    tokei
  ];
  programs.nvf = {
    enable = true;

    # my most commonly used languages
    settings.vim = {
      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };
      lsp = {
        enable = true;
        # cant turn this on because of bitcoin core
        # formatOnSave = true;
      };
      languages = {
        enableTreesitter = true;

        # most commonly used
        clang.enable = true;
        nix.enable = true;
        rust.enable = true;

        # less frequently used
        # TODO: find a way to turn off type checking with basedpyright
        # without this, the lsp is unusable with the bitcoin core functional
        # test framework due to all of the unknown type errors
        # python.enable = true;
        sql.enable = true;
      };
    };
  };
  programs.git = {
    enable = true;
    userName = "ismaelsadeeq";
    userEmail = "abubakarsadiqismail@proton.me";

    signing = {
      key = "E9F76FD7F0B66653A7D893990E3908F364989888";
      signByDefault = true;
    };
};
  systemd.user.tmpfiles.rules = [
    "d /home/${username}/flakes/bitcoin - ${username} users - -"
    "C /home/${username}/flakes/bitcoin/flake.nix 0744 ${username} users - ${./bitcoin/flake.nix}"
    "C /home/${username}/flakes/bitcoin/flake.lock 0744 ${username} users - ${./bitcoin/flake.lock}"
    "d /home/${username}/setup/bitcoin - ${username} users - -"
    "C /home/${username}/setup/bitcoin/justfile 0744 ${username} users - ${./bitcoin/justfile}"
    "C /home/${username}/setup/bitcoin/.envrc 0744 ${username} users - ${./bitcoin/.envrc}"
    "C /home/${username}/setup/justfile 0744 ${username} users - ${./justfile}"
  ];
}

let
  # nixpkgs (nix extended stdlib)
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/2748d22b45a99fb2deafa5f11c7531c212b2cefa.zip";
    sha256 = "0fdgv5mlk3xx9byaqj1wmaazj8vkr21aqzhqli1j9cz8mik787v8";
  }) {};

  # Variables (additional context)
  variables = {
    env = "devoxx";
  };

  # Declaring repositories
  repositories = {
    # repository A
    repoA = pkgs.fetchzip {
      url = "https://github.com/abryko/treeverse-repoA/archive/main.zip";
      hash = "sha256-E44fEOuBGGnASA+pqkV59PM0BCq2DU77D1OQZZWQ6FQ=";
    };
    # repository B
    repoB = pkgs.fetchzip {
      url = "https://github.com/abryko/treeverse-repoB/archive/main.zip";
      hash = "sha256-5dDxyoLlWcYGXOc1enj+rRThni2GSrcQBIth671MuYE=";
    };
  };

  # fixed-point tree
  treeverseMakerFn = self: {
    pkgs = pkgs;
    variables = variables;
    # for loop on repositories: import with context injection
    repositories = builtins.mapAttrs (_: repo: import repo self) repositories;
  };
in {
  treeverse = pkgs.lib.fix treeverseMakerFn;
}

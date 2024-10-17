{
    description = "Python development environment template";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    inputs.systems.url = "github:nix-systems/default";
    inputs.flake-utils = {
        url = "github:numtide/flake-utils";
        inputs.systems.follows = "systems";
    };

    outputs = { nixpkgs, flake-utils, ... }:
        flake-utils.lib.eachDefaultSystem (
            system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
            in
            {
                devShells.default = pkgs.mkShell {
                    packages = [
                        pkgs.uv
                        pkgs.bashInteractive
                    ];
                    shellHook = ''
                        export alias venventer="source .venv/bin/activate"
                    '';

                };
                # source .venv/bin/activate
                # You should run `uv init` to initialize the package
                # `uv sync --frozen` is useful as well
            }
        );
}
{
    description = "A meltano based system";

    inputs = {
        flake-utils.url = "github:numtide/flake-utils";
        poetry2nix.url = "github:nix-community/poetry2nix";
    };

    outputs = { self, nixpkgs, flake-utils, poetry2nix }: flake-utils.lib.eachDefaultSystem(system: 
        let pkgs = nixpkgs.legacyPackages.${system}; in
        rec {
            packages = {
                fuzzy-octo-barnacle = poetry2nix.mkPoetryApplication {
                    projectDir = ./.;
                };
            };
            defaultPackage = packages.fuzzy-octo-barnacle;

            apps = {
                fuzzy-octo-barnacle = flake-utils.lib.mkApp { drv = packages.fuzzy-octo-barnacle; };
            };
            defaultApp = apps.fuzzy-octo-barnacle;

            devShells = {
                default = pkgs.mkShell {
                    buildInputs = [
                        pkgs.python39
                        pkgs.python3.pkgs.poetry
                    ];
                };
            };

        }
    );
}
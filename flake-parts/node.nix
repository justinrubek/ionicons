{inputs, ...}: {
  perSystem = {inputs', ...}: {
    packages.default = inputs.dream2nix.lib.evalModules {
      modules = [
        ({
          lib,
          config,
          dream2nix,
          ...
        }: {
          imports = [
            dream2nix.modules.dream2nix.nodejs-package-lock-v3
            dream2nix.modules.dream2nix.nodejs-granular-v3
          ];

          mkDerivation = {
            src = ../.;
          };

          deps = {nixpkgs, ...}: {
            inherit (nixpkgs) fetchFromGitHub stdenv typescript;
          };

          nodejs-package-lock-v3 = {
            packageLockFile = "${config.mkDerivation.src}/package-lock.json";
          };

          name = "ionicons";
          version = "7.4.0";
        })
      ];
      packageSets.nixpkgs = inputs'.nixpkgs.legacyPackages;
    };
  };
}

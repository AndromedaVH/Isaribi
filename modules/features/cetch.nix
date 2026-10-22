{ self, inputs, ... }:
{
  flake.nixosModules.cetch = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.cetch.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}

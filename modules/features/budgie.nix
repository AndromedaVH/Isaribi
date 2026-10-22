{ self, inputs, ... }:
{
  flake.nixosModules.budgie = { config, lib, pkgs, ... }: {
    services.xserver.enable = true;
    services.desktopManager.budgie.enable = true;
  };
}


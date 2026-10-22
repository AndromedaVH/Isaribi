{ self, inputs, ... }:
{
  flake.nixosModules.loaf = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.loaf.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    # Loaf como administrador de archivos por defecto
    xdg.mime.defaultApplications = {
      "inode/directory" = "loaf.desktop";
    };
  };
}

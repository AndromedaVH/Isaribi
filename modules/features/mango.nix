{ self, inputs, ... }:
{
  flake.nixosModules.mango = { config, lib, pkgs, ... }:
    let
      mangoSession = pkgs.runCommand "mango-wayland-session" { } ''
       mkdir -p $out/share/wayland-sessions
       cat > $out/share/wayland-sessions/mango.desktop <<EOF
       [Desktop Entry]
       Name=Mango
       Comment=MangoWC Wayland compositor
       Exec=${pkgs.mangowc}/bin/mango
       Type=Application
       EOF
      '';
    in {
      environment.systemPackages = with pkgs; [
        mangowc
        waybar
        rofi
        swaybg
        papirus-icon-theme
        waypaper
      ];

      services.displayManager.sessionPackages = [
        (mangoSession.overrideAttrs (old: {
          passthru.providedSessions = [ "mango" ];
        }))
      ];
    };
}

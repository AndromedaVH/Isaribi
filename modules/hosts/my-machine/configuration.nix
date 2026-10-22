{ self, inputs, ... }: {

  flake.nixosModules.myMachineConfiguration = { config, pkgs, options, ... }:

{
  imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.budgie
      self.nixosModules.mango
      self.nixosModules.cetch
      self.nixosModules.loaf
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Desbloquea límites de potencia para GPUs AMD (descoméntalo si tu gráfica es AMD)
  # boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  networking.hostName = "Isaribi"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  time.timeZone = "America/Costa_Rica";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CR.UTF-8";
    LC_IDENTIFICATION = "es_CR.UTF-8";
    LC_MEASUREMENT = "es_CR.UTF-8";
    LC_MONETARY = "es_CR.UTF-8";
    LC_NAME = "es_CR.UTF-8";
    LC_NUMERIC = "es_CR.UTF-8";
    LC_PAPER = "es_CR.UTF-8";
    LC_TELEPHONE = "es_CR.UTF-8";
    LC_TIME = "es_CR.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Gestión de perfiles de energía (necesario para Dynamic Boost / TGP máximo)
  services.power-profiles-daemon.enable = true;

  # Ajustes de potencia para GPU Nvidia (desbloquea los 45W base y sube hasta 52W con Dynamic Boost)
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    dynamicBoost.enable = true;
  };

  users.users."flauros" = {
    isNormalUser = true;
    description = "flauros";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "audio" "gamemode" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  
  systemd.services.rapl-limits = {
    description = "Aplicar límites de potencia RAPL";
    wantedBy = [ "multi-user.target" "post-resume.target" ];
    after = [ "post-resume.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      echo 80000000 > /sys/class/powercap/intel-rapl:1/constraint_0_power_limit_uw
      echo 80000000 > /sys/class/powercap/intel-rapl:1/constraint_1_power_limit_uw
    '';
  };

  virtualisation.docker.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for dedicated servers
  };

  services.flatpak.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
   xwayland-satellite
   neovim
   chafa
   kitty
   fastfetch
   git
   flatpak
   localsend
   libreoffice-fresh
   netbeans
   spotify
   nautilus
   hydralauncher
   r2modman
   qogir-icon-theme
   brightnessctl
   obs-studio
   spotify-player
   smartmontools
   firefox
   kew
   easyeffects
   librewolf
   mangohud
   jetbrains.idea
   jetbrains.clion
   jetbrains.rider
   xdg-desktop-portal
  
   mapscii
   figlet
   lavat
   cava
   btop
   peaclock
   nerd-fonts.jetbrains-mono
   cbonsai
   cmatrix
 
   python3
   umu-launcher
   wineWow64Packages.stable
 
   gnome-disk-utility
   unrar
   ripgrep
   fd
   unzip
   gcc
   nodejs      

   grim
   slurp
   swappy
   wl-clipboard
   wallust

   gst_all_1.gst-plugins-base
   gst_all_1.gst-plugins-good
  ];

  programs.dconf.enable = true;   # para que guarde preferencias/bookmarks
  services.gvfs.enable = true;    # para papelera, montar USBs, etc — antes lo daba gnome gratis

  programs.nix-ld.enable = true;
  # Librerías nativas para JavaFX (y otros binarios genéricos con GUI)
  programs.nix-ld.libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [
    libx11 libxtst libxxf86vm libxi libxrender libxext
    gtk3 glib pango cairo gdk-pixbuf atk
    libGL freetype fontconfig zlib
  ]);

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Gaming: GameMode (Steam: gamemoderun %command%) y gamescope
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.bash.promptInit = ''
    export PS1='\[\e[37m\][\u@\h:\w]\[\e[0m\] λ '
  '';

  programs.bash.interactiveShellInit = ''
    fastfetch
  '';

  environment.variables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XCURSOR_THEME = "Qogir";
    XCURSOR_SIZE = "24";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  systemd.user.targets.graphical-session.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.settings = {
   General = {
     GreeterEnvironment = "XCURSOR_THEME=Qogir,XCURSOR_SIZE=24";
    };
   Theme = {
     CursorTheme = "Qogir";
     CursorSize = "24";
    };
  };

  programs.qylock = {
    enable = true;
    theme = "clockwork/orbital";
    themeOptions = {
      clockwork.orbital = {
        themeMode = "dark";       # o "light"
        enableWindup = true;
      };
    };
  };

  services.smartd = {
    enable = true;
    devices = [
        {
          device = "/dev/nvme0n1"; 
        }
      ];
    };

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  nix.settings.extra-substituters = [ "https://noctalia.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  system.stateVersion = "26.11";

};

}

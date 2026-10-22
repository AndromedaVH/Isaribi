<div align="center">

# ❄️ Isaribi

**My daily drive NixOS configuration, powered by flakes.**

![NixOS](https://img.shields.io/badge/NixOS-Flakes-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![Wayland](https://img.shields.io/badge/Wayland-niri-FFBC00?style=for-the-badge&logo=wayland&logoColor=black)
![Nix](https://img.shields.io/badge/Nix-100%25-7EBAE4?style=for-the-badge&logo=nixos&logoColor=white)

</div>

---

## ✨ What's inside

- **Compositor:** [niri](https://github.com/YaLTeR/niri), a scrollable-tiling Wayland compositor
- **Shell:** Noctalia (its settings live in `modules/features/noctalia.json`)
- **File manager:** Loaf ([m-uvex/loaf-fm](https://github.com/m-uvex/loaf-fm))
- **Everything declarative:** one flake, split into small modules you can read in a couple of minutes

## 📁 Structure

```
.
├── flake.nix                  # Entry point
├── flake.lock                 # Pinned inputs
└── modules/
    ├── parts.nix              # Flake wiring
    ├── features/              # One file per feature
    │   ├── budgie.nix
    │   ├── cetch.nix
    │   ├── loaf.nix
    │   ├── mango.nix
    │   ├── niri.nix
    │   ├── noctalia.nix
    │   └── noctalia.json
    └── hosts/
        └── my-machine/        # Machine-specific config
            ├── default.nix
            ├── configuration.nix
            └── hardware.nix
```

## 🚀 Usage

Clone the repo:

```bash
git clone git@github.com:AndromedaVH/Isaribi.git ~/myNixOS
cd ~/myNixOS
```

Rebuild the system (replace `HOSTNAME` with the host name defined in `flake.nix`):

```bash
sudo nixos-rebuild switch --flake .#HOSTNAME
```

Update all inputs:

```bash
nix flake update
```

> [!NOTE]
> Flakes only see files that git knows about. If you create a new `.nix` file, run `git add` on it before rebuilding.

## 🖥️ Using it on another machine

`modules/hosts/my-machine/hardware.nix` is specific to my hardware (disks, kernel modules, etc.). On a different computer, generate your own and replace it:

```bash
nixos-generate-config --show-hardware-config > modules/hosts/my-machine/hardware.nix
```

## 📸 Screenshots

<!-- Add your screenshots here, for example:
![Desktop](./screenshots/desktop.png)
-->

*Coming soon.*

## 🙏 Credits

- [niri](https://github.com/YaLTeR/niri) by YaLTeR
- [Loaf](https://github.com/m-uvex/loaf-fm) by m-uvex
- The NixOS community ❤️

---

<div align="center">

*Declarative, reproducible, and probably over-engineered.*

</div>

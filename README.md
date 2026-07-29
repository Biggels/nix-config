# NixOS configuration

A deliberately small, non-flake configuration for one desktop. The goal is to
start with a system that is useful, understandable, and easy to grow only when
there is a real need.

The initial system provides:

- the Plasma desktop
- NetworkManager
- PipeWire audio
- Firefox
- Git

There is no Home Manager, flake, gaming setup, or project-language tooling yet.

## Files

- `configuration.nix` is the file to edit. It contains system settings, enabled
  services, the user account, and installed programs.
- `hardware-configuration.nix` is generated for the computer during NixOS
  installation. Do not copy one from a different computer.

The hardware file is intentionally absent from this repository until it has
been generated on `bixos-ibp-9290`.

## First installation

After partitioning and mounting the target system at `/mnt`, generate the
machine-specific configuration:

```sh
sudo nixos-generate-config --root /mnt
```

Copy this repository's `configuration.nix` over the generated
`/mnt/etc/nixos/configuration.nix`. Leave the generated
`hardware-configuration.nix` in place and review the disk mounts in it. The
starter uses `system.stateVersion = "26.05"` for a new 26.05 installation; if
the generated configuration says this machine was first installed on an older
release, keep that older value instead. Then install:

```sh
sudo cp ./configuration.nix /mnt/etc/nixos/configuration.nix
sudo nixos-install
```

The installer prompts for a root password. Before rebooting, set a separate
password for the normal user:

```sh
sudo nixos-enter --root /mnt -c 'passwd biggels'
```

After the first boot, copy the generated `hardware-configuration.nix` into this
repository and commit it.

## Making a change

Edit `configuration.nix`, then try the new configuration without making it the
default boot entry:

```sh
sudo nixos-rebuild test
```

If it works, make it the current and default configuration:

```sh
sudo nixos-rebuild switch
```

If a change goes wrong, reboot into an older generation from the boot menu, or
run:

```sh
sudo nixos-rebuild switch --rollback
```

## Where new things go

- Add ordinary command-line tools and desktop applications to
  `environment.systemPackages`.
- Prefer a dedicated NixOS option when a program or service has one, as Firefox
  does in the starter configuration.
- Add system behavior next to the related section: boot, networking, desktop,
  audio, users, or programs.
- Split the file into modules only after it becomes difficult to navigate.

Packages and NixOS options can be searched at <https://search.nixos.org/>.

## Project environments

The system configuration does not need language runtimes for every programming
project. To experiment without changing the system, enter a temporary classic
Nix shell:

```sh
nix-shell -p python3
```

When a project needs a repeatable environment, add a `shell.nix` to that
project. Flakes can remain disabled until there is a concrete reason to adopt
them.

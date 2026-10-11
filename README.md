# 000-0-ghostty

<!-- key-information:start -->
## Key information

- **Description:** Runs the Ghostty terminal on RHEL 10 as a Flatpak built from the signed release, with bash integration and the current configuration.
- **Tier:** `0`. Core. Every project must follow its rules, with no exceptions.
- **Needs:** The `update` command from 000-0-ai, Flatpak, and the Nerd Fonts and bash setup from 000-0-dotfiles.
- **Gives:** The Ghostty terminal with current GTK and libadwaita, and its configuration.
- **On a new computer:** set it up step 7 of 7 in the core tier.

This folder is part of the `~/Apps` SOP (Standard Operating Procedure). The
number in the name of each folder is its tier. The SOP map is at
<https://claude.ai/artifact/W1ajTT5RGF5ZmKuJ4cRAwa>. It is a private claude.ai page. Log in to open it.

| Folder | Tier | Goal | GitHub |
|---|---|---|---|
| `000-0-dotfiles` | 0 | Every computer works the same way | [000-0-dotfiles](https://github.com/kairin/000-0-dotfiles) |
| `000-0-ASD-STE100` | 0 | Every document is clear to a reader who is not a developer | [000-0-ASD-STE100](https://github.com/kairin/000-0-ASD-STE100) |
| `000-0-password` | 0 | No key gets to a program that does not need it | [000-0-password](https://github.com/kairin/000-0-password) |
| `000-0-ai` | 0 | AI tools work the same way on every computer and follow the SOP | [000-0-ai](https://github.com/kairin/000-0-ai) |
| `000-0-workspace` | 0 | All repositories in `~/Apps` stay healthy and consistent | [000-0-workspace](https://github.com/kairin/000-0-workspace) |
| `000-0-tables` | 0 | You never research the same database question twice, and what you know links across repositories | [000-0-tables](https://github.com/kairin/000-0-tables) |
| **000-0-ghostty** | 0 | The terminal is current, verified and the same on every computer | [000-0-ghostty](https://github.com/kairin/000-0-ghostty) |
| `000-111-learn` | 111 | Write very small, fast programs that run close to the hardware | [000-111-learn](https://github.com/kairin/000-111-learn) |
<!-- key-information:end -->

This repository holds the Ghostty configuration and the facts about how
Ghostty is installed. It has no install script. The command that installs and
updates Ghostty is in 000-0-ai.

## Contents

| Path | What it is | Install location |
|---|---|---|
| `config.ghostty` | The Ghostty configuration: font, Catppuccin Mocha theme, window, clipboard and keybinds. | `~/.var/app/com.mitchellh.ghostty/config/ghostty/config.ghostty` |
| `bashrc.d/ghostty.bash` | Loads Ghostty's bash integration in the host shell. | `~/.bashrc.d/ghostty.bash` |

## Where each part lives

| Part | Repository | Path |
|---|---|---|
| Install and update command (`update`) | [000-0-ai](https://github.com/kairin/000-0-ai) | `local-bin/update`, installed by `local-bin/install-update.py`. Documentation: README section "Update command" and its "Ghostty" subsection. |
| Agent skill and Claude prompt hook for updates | [000-0-ai](https://github.com/kairin/000-0-ai) | `skills/update/SKILL.md`, `hooks/claude/update_reminder.py` |
| Nerd Fonts | [000-0-dotfiles](https://github.com/kairin/000-0-dotfiles) | `docs/nerd-fonts.md` |
| Bash setup and `~/.bashrc.d` | [000-0-dotfiles](https://github.com/kairin/000-0-dotfiles) | `docs/rhel-10-setup.md` |
| Routine maintenance (run `update`) | [000-0-workspace](https://github.com/kairin/000-0-workspace) | README section "AI harness maintenance" |
| Ghostty configuration | This repository | `config.ghostty`, `bashrc.d/ghostty.bash` |

## Why a Flatpak

Ghostty is not in the RHEL 10 or EPEL 10 repositories. A native build works,
but RHEL 10 has older GTK and libadwaita than Ghostty can use:

| Library | RHEL 10 | GNOME 49 Flatpak runtime | Newest Ghostty use |
|---|---|---|---|
| GTK | 4.16 | 4.20 | 4.20 |
| libadwaita | 1.6 | 1.8 | 1.8 |

GTK 4.20 needs glib 2.82 and pango 1.56. RHEL 10 has glib 2.80 and pango 1.54.
A native GTK 4.20 means you build glib, pango and GTK yourself. The Flatpak
gets them from the GNOME runtime instead. The build uses Ghostty's own
manifest, `flatpak/com.mitchellh.ghostty.yml`, from the release source.

A native build also needs Zig at the exact version that the Ghostty release
names (0.15.2 for 1.3.x). EPEL has a different version. The Flatpak manifest
downloads the correct Zig, so you do not install Zig.

## Install on a new computer

Do the steps for 000-0-dotfiles (Nerd Fonts, bash) and 000-0-ai (`update`)
first.

1. Install the build tools and add the Flathub remote:

   ```bash
   sudo dnf install flatpak-builder minisign
   flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
   ```

   `flatpak` is in RHEL 10. `flatpak-builder` is in AppStream and `minisign`
   is in EPEL.

   Flathub is used only for the GNOME runtime and SDK of this build. This is
   the one exception to the "no Flathub" rule. Other applications stay RPM
   packages. See `docs/decisions.md` in 000-0-dotfiles, entry 2026-10-11.

2. Build and install Ghostty:

   ```bash
   update --only ghostty
   ```

   The command downloads the newest release, checks its minisign signature,
   builds it and installs it as the user Flatpak `com.mitchellh.ghostty`.
   The first build also installs the GNOME runtime and SDK (about 2 GB) and
   takes several minutes. Expect: `ghostty: okay (updated none -> X.Y.Z; ...)`.

3. Install the configuration from this repository:

   ```bash
   mkdir -p ~/.var/app/com.mitchellh.ghostty/config/ghostty ~/.bashrc.d
   cp config.ghostty ~/.var/app/com.mitchellh.ghostty/config/ghostty/config.ghostty
   cp bashrc.d/ghostty.bash ~/.bashrc.d/ghostty.bash
   ```

4. Check the configuration:

   ```bash
   flatpak run com.mitchellh.ghostty +validate-config
   ```

   Expect: no output and exit code 0.

5. Start Ghostty from the application menu, or run
   `flatpak run com.mitchellh.ghostty`.

## Update

Run `update` (all tools) or `update --only ghostty`. The command compares the
installed Flatpak with the newest `vX.Y.Z` tag of `ghostty-org/ghostty`. If
Ghostty is missing or older, it builds and installs the new release in place,
checks that it starts, and removes the build files and unused Flatpak
runtimes. Restart Ghostty to use the new version. `flatpak update` does not
update Ghostty, because it is a local build.

## Facts about the Flatpak

- **Configuration folder.** Inside the Flatpak, `XDG_CONFIG_HOME` is
  `~/.var/app/com.mitchellh.ghostty/config`. Ghostty does not read
  `~/.config/ghostty`. Ghostty 1.3 uses the file name `config.ghostty`.
- **Shell.** Ghostty starts your login shell on the host, not in the sandbox.
- **Bash integration.** Ghostty cannot inject its bash integration from the
  Flatpak, because the sandbox cannot open the Flatpak install folder. It
  logs `shell could not be detected`. `bashrc.d/ghostty.bash` sources the
  same file from the host. This turns on the `sudo`, `ssh-env` and `title`
  features in `config.ghostty`.
- **TERM.** Ghostty sets `TERM=xterm-ghostty` and points `TERMINFO` to a host
  path in the Flatpak install. Programs on the host find it, so no `terminfo`
  install is needed.
- **Home folder.** The Flatpak can read your home folder but cannot write to
  it. Programs that you run in the terminal run on the host and are not
  limited.

## Change the configuration

1. Edit `config.ghostty` in this repository.
2. Copy it to the install location (step 3 above).
3. Run `flatpak run com.mitchellh.ghostty +validate-config`.
4. Press `Ctrl+Shift+,` in Ghostty to reload the file.

Rules for the file:

- Do not add `background-blur`. It causes crashes on Linux.
- Keep `scrollback-limit` at 50000 or lower.
- Use a font that `fc-list : family | grep 'Nerd Font Mono'` shows.

# Changelog

## [2026-10-11] — Core repository for Ghostty on RHEL 10

### Changed

- Renamed the repository from `000-222-ghostty-config-files` to
  `000-0-ghostty` and moved it to the core tier.
- Replaced the Ubuntu setup with the RHEL 10 setup. Ghostty is now the user
  Flatpak `com.mitchellh.ghostty`, built from the signed release with
  Ghostty's own manifest. The `update` command in 000-0-ai installs and
  rebuilds it.
- `config.ghostty`: the configuration for Ghostty 1.3 in the Flatpak. It uses
  the built-in `Catppuccin Mocha` theme and the `JetBrainsMono Nerd Font Mono`
  font from 000-0-dotfiles.

### Added

- `bashrc.d/ghostty.bash`: loads Ghostty's bash integration on the host,
  because the Flatpak cannot inject it.

### Removed

- The install and uninstall scripts, the font picker, the `dev` tmux
  function, and the fish, tmux and starship configuration. The shell is bash
  (000-0-dotfiles). The install command is in 000-0-ai.
- The old `.gitignore` rules for projects that are no longer in this
  repository.

Earlier history is in Git (`git log`).

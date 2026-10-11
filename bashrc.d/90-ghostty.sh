# Ghostty shell integration for bash on the host.
# Install: ~/.bashrc.d/90-ghostty.sh (RHEL's default ~/.bashrc sources ~/.bashrc.d/*).
# It loads after the other tools and before 99-blesh-attach.sh.
# The Ghostty Flatpak sets GHOSTTY_RESOURCES_DIR to a host path but cannot
# inject this file itself, so bash sources it here.
if [[ $- == *i* && -n ${GHOSTTY_RESOURCES_DIR-} \
    && -r $GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash ]]; then
    builtin source "$GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash"
fi

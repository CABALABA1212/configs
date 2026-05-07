if status is-interactive
    if not set -q TMUX; and [ "$TERM" != "linux" ]
        tmux attach-session -t default 2>/dev/null; or tmux new-session -s default
    end
end

fish_vi_key_bindings

# NVIDIA Prime offload alias
alias n='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia '

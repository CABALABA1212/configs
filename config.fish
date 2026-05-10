if status is-interactive; and not set -q TMUX
    tmux new-session -A -s main
end
        
fish_vi_key_bindings

# NVIDIA Prime offload alias
alias n='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia '

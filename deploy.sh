#!/usr/bin/env sh
# chezmoi dotfiles deployment script

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CHEZMOI_SOURCE_DIR="$SCRIPT_DIR"

usage() {
    echo "Usage: $0 <command>"
    echo "Commands:"
    echo "  init      Initialize chezmoi with this directory as source"
    echo "  add       Add a new file to chezmoi source"
    echo "  apply     Apply dotfiles to home directory"
    echo "  diff      Show differences between source and target"
    echo "  status    Show chezmoi status"
    echo "  update    Update dotfiles from home directory"
    echo "  sync      Run git add, commit and push (if in git repo)"
    echo "  init-apply  Initialize and apply in one step"
}

run_chezmoi() {
    chezmoi \
        --source="$CHEZMOI_SOURCE_DIR" \
        --destination="$HOME/.config" \
        --mode=symlink \
        "$@"
}

case "$1" in
    init)
        echo "Initializing chezmoi..."
        run_chezmoi init
        ;;
    add)
        shift
        if [ -z "$1" ]; then
            echo "Error: No file specified"
            usage
            exit 1
        fi
        echo "Adding $1 to chezmoi source..."
        run_chezmoi add "$1"
        ;;
    apply)
        echo "Applying dotfiles..."
        run_chezmoi apply
        ;;
    diff)
        echo "Showing differences..."
        run_chezmoi diff
        ;;
    status)
        echo "Showing status..."
        run_chezmoi status
        ;;
    update)
        echo "Updating dotfiles from home directory..."
        run_chezmoi re-add
        ;;
    sync)
        if [ -d ".git" ]; then
            echo "Syncing with git..."
            git add -A
            git diff --cached --stat
            echo "Commit message:"
            read -r msg
            git commit -m "$msg"
            git push
        else
            echo "Not a git repository. Run 'git init' first."
        fi
        ;;
    init-apply)
        echo "Initializing and applying chezmoi..."
        run_chezmoi init --apply
        ;;
    *)
        usage
        exit 1
        ;;
esac

#!/usr/bin/env bash
# Install coord onto PATH by symlinking into ~/.local/bin.
set -euo pipefail
command -v python3 >/dev/null || { echo "coord needs python3"; exit 1; }
mkdir -p "$HOME/.local/bin"
ln -sf "$(cd "$(dirname "$0")" && pwd)/coord" "$HOME/.local/bin/coord"
echo "✓ coord installed → ~/.local/bin/coord"
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) echo "  add ~/.local/bin to PATH (it's not there yet)";; esac
coord >/dev/null 2>&1 && echo "✓ runs" || echo "  (open a new shell, then: coord register <label>)"

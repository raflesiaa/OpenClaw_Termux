#!/data/data/com.termux/files/usr/bin/bash
# ================================================
#  OpenClaw Installer for Termux (Non-Root)
#  Project: OpenClaw_Termux
#  Author: Raflesia
# ================================================

set -Eeuo pipefail

# Colors
BLUE="\033[1;34m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
MAGENTA="\033[1;35m"
RESET="\033[0m"

echo -e "${MAGENTA}"
echo "██████  █████  ███████ ██      ███████ ███████ ██  █████ "
echo "██   ██ ██   ██ ██      ██      ██      ██      ██ ██   ██"
echo "██████  ███████ █████   ██      █████   ███████ ██ ███████"
echo "██   ██ ██   ██ ██      ██      ██           ██ ██ ██   ██"
echo "██   ██ ██   ██ ██      ███████ ███████ ███████ ██ ██   ██"
echo -e "${RESET}"
sleep 3

echo -e "${CYAN}============================================${RESET}"
echo -e "${CYAN}      OPENCLAW TERMUX AUTO-INSTALLER        ${RESET}"
echo -e "${CYAN}============================================${RESET}"

# Helpers
section() { echo -e "\n${BLUE}[$1/5]${RESET} $2"; }
ok() { echo -e "${GREEN}✔ $1${RESET}"; }
ub() { proot-distro login ubuntu -- bash -lc "$*"; }

# 1. Update Termux
section "1" "Setting up Termux environment..."
pkg update -y && pkg upgrade -y
pkg install -y proot-distro termux-api git
ok "Termux base ready!"

# 2. Setup Ubuntu proot
section "2" "Installing Ubuntu Proot (Container)..."
proot-distro install ubuntu || echo "Ubuntu is already installed, skipping..."
ok "Ubuntu environment ready!"

# 3. Install Dependencies & Latest Node.js
section "3" "Installing Modules & Latest Node.js..."
echo -e "${YELLOW}This may take a few minutes...${RESET}"
ub "
    apt update && apt upgrade -y
    apt install -y curl git build-essential python3 ffmpeg pkg-config make g++
    # Try official NodeSource for latest
    curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
    # On most modern distros, 'nodejs' package includes 'npm'
    # We add 'npm' explicitly in the fallback just in case
    apt install -y nodejs || (apt install -y nodejs npm && echo 'Using fallback nodejs+npm')
"
ok "Dependencies & Latest Node.js installed!"

# --- Android Fix (Hijack) ---
echo -e "\n${BLUE}==>${RESET} Applying Android system fix (uv_interface_addresses)..."
ub 'cat > /root/hijack.js << "EOF"
const os = require("os");
os.networkInterfaces = () => ({});
EOF'
ub 'grep -q "NODE_OPTIONS=.*-r /root/hijack.js" ~/.bashrc || echo '\''export NODE_OPTIONS="-r /root/hijack.js"'\'' >> ~/.bashrc'
ok "System fix applied!"

# 4. Install OpenClaw (Stable Version)
section "4" "Installing OpenClaw Core (v2026.2.12)..."
ub "npm install -g openclaw@2026.2.12"
ok "OpenClaw successfully installed!"

# 5. Finish
echo -e "\n${GREEN}============================================${RESET}"
echo -e "${GREEN}      INSTALLATION PROCESS COMPLETED!       ${RESET}"
echo -e "${GREEN}============================================${RESET}"
echo -e "${YELLOW}Next steps:${RESET}"
echo -e "1. Setup: ${CYAN}proot-distro login ubuntu -- openclaw onboard${RESET}"
echo -e "2. Start: ${CYAN}proot-distro login ubuntu -- openclaw gateway${RESET}"

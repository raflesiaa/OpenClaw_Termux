#!/data/data/com.termux/files/usr/bin/bash
# ================================================
#  OpenClaw Installer for Termux (Root Edition)
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
RED="\033[1;31m"
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
echo -e "${CYAN}    OPENCLAW TERMUX ROOT AUTO-INSTALLER     ${RESET}"
echo -e "${CYAN}============================================${RESET}"

ok() { echo -e "${GREEN}✔ $1${RESET}"; }
die() { echo -e "${RED}[ERROR] $1${RESET}"; exit 1; }

# 1. Check Root Access
echo -e "\n${BLUE}[1/5]${RESET} Checking for Root permissions..."
if ! command -v su > /dev/null 2>&1; then
    die "Root not detected! Please use the non-root installer (install.sh)."
fi
ok "Root access verified!"

# 2. Update Termux & Install Root Tools
echo -e "\n${BLUE}[2/5]${RESET} Setting up Termux environment..."
pkg update -y && pkg upgrade -y
# We install 'proot' because it provides the 'termux-chroot' command
# Added explicit quotes for g++ to prevent terminal misinterpretation
pkg install -y tsu proot git ffmpeg python3 make "g++" ca-certificates
ok "Root tools and dependencies ready!"

# 3. Install Node.js (LTS)
echo -e "\n${BLUE}[3/5]${RESET} Installing Node.js & NPM..."
pkg install -y nodejs-lts
ok "Node.js $(node -v) installed!"

# 4. Install OpenClaw (Stable Version)
echo -e "\n${BLUE}[4/5]${RESET} Installing OpenClaw Core (v2026.2.12)..."
# termux-chroot helps mapping standard Linux paths like /tmp
termux-chroot npm install -g openclaw@2026.2.12 --no-optional
ok "OpenClaw successfully installed!"

# 5. Finish
echo -e "\n${GREEN}============================================${RESET}"
echo -e "${GREEN}      INSTALLATION PROCESS COMPLETED!       ${RESET}"
echo -e "${GREEN}============================================${RESET}"
echo -e "${YELLOW}Next steps:${RESET}"
echo -e "1. Enter Chroot: ${CYAN}termux-chroot${RESET}"
echo -e "2. Setup Bot:   ${CYAN}openclaw onboard${RESET}"
echo -e "3. Run Gateway: ${CYAN}openclaw gateway --verbose${RESET}"
echo ""
echo -e "${BLUE}Tip: Always run 'termux-chroot' before starting OpenClaw to avoid path errors.${RESET}"

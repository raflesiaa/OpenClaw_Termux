# 🌸 OpenClaw Termux Installer

This repository provides automated scripts to run **OpenClaw** on Android via Termux. We support both **Standard (Non-Root)** and **High-Performance (Rooted)** devices.

## ✨ Features
- 🚀 **Two Modes**: Choose between `proot` (safe) or `chroot` (fast).
- 📦 **Stable Version**: Pinned to OpenClaw `2026.2.12` for the best onboarding experience.
- 🛠 **Full Modules**: Includes FFmpeg, Python, and essential build tools.
- 📱 **Android Optimized**: Custom fixes for network and path errors.

---

## 📥 Installation

1. **Download Termux**: Ensure you are using the version from **[F-Droid](https://f-droid.org/packages/com.termux/)**.
2. Open Termux and run the appropriate command for your device:

### 📱 Option A: Standard (Non-Root)
Uses `proot-distro (Ubuntu)` for maximum compatibility. No root required.
```bash
pkg install git -y && git clone https://github.com/raflesiaa/OpenClaw_Termux && cd OpenClaw_Termux && chmod +x install.sh && ./install.sh
```

### ⚡ Option B: Rooted (High Performance)
Uses `termux-chroot` for direct system access. Requires a rooted device.
```bash
pkg install git -y && git clone https://github.com/raflesiaa/OpenClaw_Termux && cd OpenClaw_Termux && chmod +x install_root.sh && ./install_root.sh
```

---

## 🛠 How to Run

### For Standard Mode (Non-Root)
```bash
proot-distro login ubuntu
openclaw gateway
```

### For Root Mode (Rooted)
```bash
termux-chroot
openclaw gateway
```

---

## 🤖 Telegram Bot Setup
1. Get your token from **[@BotFather](https://t.me/BotFather)**.
2. Get your ID from **[@userinfobot](https://t.me/userinfobot)**.
3. Enter your environment (`proot` or `chroot`) and run `openclaw onboard`.
4. Send a message to your bot on Telegram.
5. If a pairing code appears, stop the gateway (`Ctrl+C`) and run:
   ```bash
   openclaw pairing approve telegram <CODE>
   ```

---
**Maintained by:** [Raflesia](https://github.com/raflesiaa)

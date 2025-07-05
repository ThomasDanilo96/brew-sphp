# sphp – Instantly Switch PHP Versions on macOS with Homebrew 🌀

**sphp** is a blazing-fast CLI utility for macOS that lets you **switch between multiple PHP versions (CLI & Apache)** installed via [Homebrew](https://brew.sh).  
No restarts, no hacks, no pain – just one command and you’re running the desired PHP version.

> Supports PHP 7.2 → PHP 8.3 (and upcoming 8.4, 8.5) with automatic installation and Apache integration.

---

## ⚡ What This Tool Does

- ✅ Switches **CLI PHP version** instantly
- ✅ Switches **Apache mod_php version** in `/opt/homebrew/etc/httpd/httpd.conf`
- ✅ Automatically installs missing PHP versions via `brew install php@X.Y`
- ✅ Creates a full **backup** of current config before any change
- ✅ Patches your `~/.zshrc` to persist the change
- ✅ Works seamlessly on Apple Silicon (M1, M2, M3...)

---

## 📦 Installation

```bash
brew tap ThomasDanilo96/sphp
brew install sphp

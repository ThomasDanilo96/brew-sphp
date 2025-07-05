# 🧪 sphp – Switch PHP Versions on macOS (Apache + CLI) with One Command

`sphp` is a lightweight CLI utility to instantly switch PHP versions (CLI + Apache) on macOS with a single command. It supports PHP 7.2 to 8.3 (and upcoming 8.4, 8.5), and is perfect for devs, agencies, and anyone managing multiple PHP projects.

> ⚡️ Works flawlessly with Homebrew and Apple Silicon (M1, M2, M3). Compatible with Apache via `httpd.conf` and CLI via `$PATH`.

---

## ✅ Features

- 🔄 One-command switch between PHP versions
- 📦 Auto-installs missing versions with `brew install php@X.Y`
- 🔧 Automatically updates Apache’s `httpd.conf`
- 💻 Automatically updates CLI `$PATH` in `.zshrc`
- 🛡️ Creates backup of all modified config files
- ⚙️ Handles both `php_module` and `php7_module` loading
- 🍎 Optimized for `/opt/homebrew` on macOS (Intel & Apple Silicon)
- 🔁 Cleans old `opcache` settings to avoid conflicts

---

## 📦 Installation

```bash
brew tap ThomasDanilo96/sphp
brew install sphp

Then switch PHP version (Apache + CLI):
```bash
sphp 8.2

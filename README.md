# sphp – Switch PHP Versions on macOS (Apache + CLI) with One Command

`sphp` is a lightweight CLI utility to instantly switch PHP versions (CLI + Apache) on macOS with a single command. It supports PHP 7.2 to 8.3 (and upcoming 8.4, 8.5), and is perfect for devs, agencies, and anyone managing multiple PHP projects.

> ⚡Works flawlessly with Homebrew and Apple Silicon (M1, M2, M3). Compatible with Apache via `httpd.conf` and CLI via `$PATH`.

---
## Features

- One-command switch between PHP versions
- Auto-installs missing versions with `brew install php@X.Y`
- Automatically updates Apache’s `httpd.conf`
- Automatically updates CLI `$PATH` in `.zshrc`
- Creates backup of all modified config files
- Handles both `php_module` and `php7_module` loading
- Optimized for `/opt/homebrew` on macOS (Intel & Apple Silicon)
- Cleans old `opcache` settings to avoid conflicts
  
---
## Installation

```bash
brew tap ThomasDanilo96/sphp
brew install sphp
```

Then switch PHP version (Apache + CLI):
```bash
sphp 8.2
```
Supports: 7.2, 7.3, 7.4, 8.0, 8.1, 8.2, 8.3

---
## Quick Start

```bash
# Step 1: Tap and install
brew tap ThomasDanilo96/sphp
brew install sphp

# Step 2: Switch version
sphp 7.4
```
Done

---
### How It Works

`sphp` performs the following:

- Unlinks and links correct PHP version:
```bash
brew unlink php && brew link --force php@X.Y
```
- Updates /opt/homebrew/etc/httpd/httpd.conf
- Adds correct LoadModule and PHPIniDir
- Restarts Apache with apachectl
- Rewrites .zshrc path exports
- Forces current terminal switch with export PATH=...
- Cleans up old opcache directives

Backups saved under:

```bash
~/backup_sphp_YYYYMMDD_HHMMSS/
```

---
## SEO Keywords (to index highly in Google)
switch php version macos homebrew

- change php cli version apache mac apple silicon
- install php@8.2 php@7.4 homebrew apachectl
- how to switch php versions on macbook m1 m2
- apache uses wrong php version macOS
- multiple php versions homebrew
- php CLI apache mismatch fix
- how to change php.ini mac
  
---
## Requirements

- macOS (Intel or Apple Silicon)
- Apache installed via Homebrew
- PHP installed via `brew install php@X.Y`
- Shell: ZSH (`.zshrc` must exist)
- Using `/opt/homebrew` as Homebrew prefix
  
---
## Safe by Design

Backs up before doing any change:

- `/opt/homebrew/etc/httpd/httpd.conf`
- `/opt/homebrew/etc/php/X.Y/`

Also:

- Cleans `.zshrc` from old PHP paths
- Idempotent: safe to re-run
- Works even if version was never installed (will install it)
  
---
# Supported Versions

| PHP Version | Supported  | Auto Install |
| ----------- | ---------- | ------------ |
| 7.2         | ✅          | ✅            |
| 7.3         | ✅          | ✅            |
| 7.4         | ✅          | ✅            |
| 8.0         | ✅          | ✅            |
| 8.1         | ✅          | ✅            |
| 8.2         | ✅          | ✅            |
| 8.3         | ✅          | ✅            |
| 8.4         | ✅          | ✅            |
| 8.5         | 🚧 Planned  | ❌            |

Versions provided via [shivammathur/homebrew-php](https://github.com/shivammathur/homebrew-php)

---
## 🔗 Resources
- [Homebrew](https://brew.sh/)
- [Apache HTTP Server](https://httpd.apache.org/)
- [PHP Official Site](https://www.php.net/)
- [shivammathur/homebrew-php](https://github.com/shivammathur/homebrew-php)
  
---
## License
MIT – use it freely, improve it, share it.

---
## Author
[Danilo D’Antoni](https://www.danilodantoni.it/)
GitHub → [@ThomasDanilo96](https://github.com/ThomasDanilo96)

---
## Contribute
Pull requests welcome! Open an issue or PR if you’ve got an idea or fix.



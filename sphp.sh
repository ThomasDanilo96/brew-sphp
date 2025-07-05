#!/bin/bash

VERSION="$1"

# === Create backup of current Apache and PHP configuration ===
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/backup_sphp_$TIMESTAMP"
mkdir -p "$BACKUP_DIR"

HTTPD_CONF="/opt/homebrew/etc/httpd/httpd.conf"
if [[ -f "$HTTPD_CONF" ]]; then
  cp "$HTTPD_CONF" "$BACKUP_DIR/httpd.conf.bak"
fi

PHPINI_DIR="/opt/homebrew/etc/php/$VERSION"
if [[ -d "$PHPINI_DIR" ]]; then
  cp -R "$PHPINI_DIR" "$BACKUP_DIR/php-${VERSION}-etc"
fi

echo "Backup created in $BACKUP_DIR"

# === Validate version argument ===
if [[ -z "$VERSION" ]]; then
  echo "Error: specify the PHP version to use (e.g. 7.4 or 8.2)" >&2
  exit 1
fi

# === Check if the requested version is supported ===
VALID_VERSIONS=(7.2 7.3 7.4 8.0 8.1 8.2 8.3 8.4 8.5)
is_valid_version=false
for v in "${VALID_VERSIONS[@]}"; do
  if [[ "$VERSION" == "$v" ]]; then
    is_valid_version=true
    break
  fi
done

if [[ "$is_valid_version" != true ]]; then
  echo "Error: version '$VERSION' is not supported."
  echo "Supported versions: ${VALID_VERSIONS[*]}"
  exit 1
fi

# === Install PHP version if missing ===
if ! brew list php@"$VERSION" &>/dev/null; then
  echo "PHP $VERSION is not installed. Installing..."
  brew tap shivammathur/php
  brew install php@"$VERSION"
  if [[ $? -ne 0 ]]; then
    echo "Error installing php@$VERSION" >&2
    exit 1
  fi
fi

# === Force link the requested version ===
brew unlink php &>/dev/null
brew link --overwrite --force php@"$VERSION"

# === Setup Apache module paths ===
PHP_PATH="/opt/homebrew/opt/php@$VERSION"
MODULE_STD="$PHP_PATH/lib/httpd/modules/libphp.so"
MODULE7="$PHP_PATH/lib/httpd/modules/libphp7.so"

# === Reinstall PHP if Apache module is missing ===
if [[ ! -f "$MODULE_STD" && ! -f "$MODULE7" ]]; then
  echo "Apache module not found for PHP $VERSION. Reinstalling..."
  brew uninstall php@"$VERSION" --ignore-dependencies
  brew cleanup php@"$VERSION"
  brew install php@"$VERSION"
  brew link --overwrite --force php@"$VERSION"
fi

# === Check again after reinstall ===
APACHE_OK=false
if [[ -f "$MODULE_STD" || -f "$MODULE7" ]]; then
  APACHE_OK=true
fi

echo "Switching Apache and CLI to PHP $VERSION..."

# === Apache configuration update ===
if [[ "$APACHE_OK" == true ]]; then
  INIDIR="/opt/homebrew/etc/php/$VERSION"

  [[ ! -f "$HTTPD_CONF.bak" ]] && cp "$HTTPD_CONF" "$HTTPD_CONF.bak"

  sed -i '' '/LoadModule php/d' "$HTTPD_CONF"
  sed -i '' '/<IfModule php_module>/,/<\/IfModule>/d' "$HTTPD_CONF"

  if [[ "$VERSION" == "7.4" && -f "$MODULE7" ]]; then
    echo "LoadModule php7_module $MODULE7" >> "$HTTPD_CONF"
  elif [[ -f "$MODULE_STD" ]]; then
    echo "LoadModule php_module $MODULE_STD" >> "$HTTPD_CONF"
    echo "<IfModule php_module>" >> "$HTTPD_CONF"
    echo "    PHPIniDir \"$INIDIR\"" >> "$HTTPD_CONF"
    echo "</IfModule>" >> "$HTTPD_CONF"
  fi

  sudo /opt/homebrew/bin/apachectl restart
  echo "Apache is now using PHP $VERSION"
else
  echo "Apache module not found. Apache not updated. CLI only."
fi

# === Update local PATH (current shell) ===
CLEANED_PATH=$(echo "$PATH" | sed -E 's|/opt/homebrew/opt/php@[^:]+/bin:||g' | sed -E 's|/opt/homebrew/opt/php@[^:]+/sbin:||g')
export PATH="$PHP_PATH/bin:$PHP_PATH/sbin:$CLEANED_PATH"
hash -r

# === Update ~/.zshrc with the new PHP path ===
ZSHRC="$HOME/.zshrc"
sed -i '' '/opt\/homebrew\/opt\/php@/d' "$ZSHRC"
echo "export PATH=\"$PHP_PATH/bin:\$PATH\"" >> "$ZSHRC"
echo "export PATH=\"$PHP_PATH/sbin:\$PATH\"" >> "$ZSHRC"

echo "PATH updated in .zshrc (takes effect next terminal)"

# === Cleanup old opcache config ===
OPCACHE_DIR="/opt/homebrew/etc/php/$VERSION/conf.d"
find "$OPCACHE_DIR" -type f -name 'ext-opcache.ini' -exec sed -i '' '/opcache.so/d' {} \;

echo "CLI version is now: $(php -v | head -n 1)"

# === Apply zshrc immediately ===
echo "To activate the new PHP version in your terminal, run: source ~/.zshrc"

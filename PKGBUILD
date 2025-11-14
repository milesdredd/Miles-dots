pkgname=miles-dots-git
pkgver=1.0
pkgrel=1
pkgdesc="Miles's dotfiles for Niri/ eww configs"
arch=('any')
url="https://github.com/milesdredd/Miles-dots"
license=('MIT')
depends=()
makedepends=('git')
source=("git+$url")
md5sums=('SKIP')

package() {
    # Install entire repo into /usr/share/
    install -dm755 "$pkgdir/usr/share/$pkgname"

    cp -r "$srcdir/Miles-dots"/. "$pkgdir/usr/share/$pkgname/"
    rm -rf "$pkgdir/usr/share/$pkgname/.git"

    # Install helper script that applies configs
    install -dm755 "$pkgdir/usr/bin"

    cat << 'EOF' > "$pkgdir/usr/bin/apply-miles-dots"
#!/bin/bash
set -e

SOURCE_DIR="/usr/share/miles-dots-git"

echo "Applying Miles's dotfiles..."

# copy .config
if [ -d "$SOURCE_DIR/.config" ]; then
    echo "Copying .config..."
    mkdir -p "$HOME/.config/"
    cp -r "$SOURCE_DIR/.config/"* "$HOME/.config/" 2>/dev/null
fi

# copy .local
if [ -d "$SOURCE_DIR/.local" ]; then
    echo "Copying .local..."
    mkdir -p "$HOME/.local/"
    cp -r "$SOURCE_DIR/.local/"* "$HOME/.local/" 2>/dev/null
fi

# run install.sh if exists
if [ -f "$SOURCE_DIR/install.sh" ]; then
    echo "Running install.sh..."
    bash "$SOURCE_DIR/install.sh"
fi

echo "Miles dotfiles applied!"
EOF

    chmod +x "$pkgdir/usr/bin/apply-miles-dots"
}


if command -v brew >/dev/null 2>&1; then
  echo "Homebrew is already in PATH; skipping install."
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  printf '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >>~/.bashrc
fi

if [ -d /Applications/Alacritty.app ]; then
  echo "Alacritty is installed"
else
  curl -sLO https://github.com/alacritty/alacritty/releases/download/v0.17.0/Alacritty-v0.17.0.dmg
  hdiutil attach hdiutil attach Alacritty-v0.17.0.dmg
  sudo cp -R /Volumes/Alacritty/Alacritty.app /Applications/
fi
# Install tools required by basic LazyVim setup
brew install jq fd neovim lazygit ripgrep
# Install node since many LSP rely on it
brew install fnm
fnm install 24
# Install a tool so that dark mode can propagate from the OS to neovim
brew install cormacrelf/tap/dark-notify
# Install a nerd font as required by LazyVim
curl -sLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
mkdir -p FiraCode && unzip FiraCode.zip -d ./FiraCode
cp ./FiraCode/FiraCodeNerdFont-Regular.ttf ~/Library/Fonts/
cp ./FiraCode/FiraCodeNerdFont-Bold.ttf ~/Library/Fonts/
cp ./FiraCode/FiraCodeNerdFont-Retina.ttf ~/Library/Fonts/
# Overwrite the LazyVim config with the opinionated setup for usage in WSL
if [ -d ~/.config/nvim ]; then
  zip -r neovim_backup_$(date +%s).zip ~/.config/nvim/
fi

rm -rf ~/.config/nvim
mkdir -p ~/.config
cp -r nvim/ ~/.config/nvim/

echo "When you feel ready, add export EDITOR='nvim' in your ~/.bashrc so that neovim becomes your default editor"

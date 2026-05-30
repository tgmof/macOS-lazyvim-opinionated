if command -v brew >/dev/null 2>&1; then
  echo "Homebrew is already in PATH; skipping install."
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  printf '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >>~/.zshrc
fi

if [ -d /Applications/Alacritty.app ]; then
  echo "Alacritty is installed"
else
  curl -sLO https://github.com/alacritty/alacritty/releases/download/v0.17.0/Alacritty-v0.17.0.dmg
  hdiutil attach hdiutil attach Alacritty-v0.17.0.dmg
  sudo cp -R /Volumes/Alacritty/Alacritty.app /Applications/
fi
# Make Neovim an app-like bundle so that you can start neovim to edit a file from Finder (https://www.reddit.com/r/Ghostty/comments/1hsvjtg/comment/m61htlo/?context=3&share_id=mN8755Rz7x_1gHHC9aVISl)
sudo cp -R ./Neovim.app /Applications/
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

echo "When you feel ready, add export EDITOR='nvim' in your ~/.zshrc and open txt/code/md/csv files (Right Click > Get Info > Open with > Neovim.app > Change All) so that neovim becomes your default editor"

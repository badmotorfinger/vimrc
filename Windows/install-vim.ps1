$vimfiles = "$Env:USERPROFILE\vimfiles"
$vimRcRepoPath = "$vimfiles\symlink-repos\vimrc"
$vimInstallPath = 'C:\tools\vim\vim82'
$sourceCodePath = 'C:\Users\Vince\source\github-badmotorfinger'

if ((Test-Path $vimInstallPath) -eq $false) {
  Write "Vim not found in path $vimInstallPath"
  return;
}

if ((Test-Path $sourceCodePath)-eq $false) {
  Write "Source code path $sourceCodePath not found."
  return;
}

# Prepare ~\vimfiles directory
ri $vimfiles -Recurse -Force -ErrorAction SilentlyContinue
md "$vimfiles\symlink-repos"
cd "$vimfiles\symlink-repos"


# Create a junction to the place where all my other source code lives
junction vimrc "$sourceCodePath\vimrc"

# Get my vimrc from GitHub and symlink it to where Vim looks for it
cd ~\
Remove-Item _vimrc -ErrorAction SilentlyContinue
Remove-Item _gvimrc -ErrorAction SilentlyContinue
cmd /c mklink /H _vimrc "$vimRcRepoPath\_vimrc"
cmd /c mklink /H _gvimrc "$vimRcRepoPath\windows\_gvimrc"


Write 'Installing and configuring Vim...' -ForegroundColor Green
if ((Test-Path $vimInstallPath)) {
    Write 'Vim already installed. Skipped.' -ForegroundColor Magenta
} else {
    choco install vim --limit-output --force -y
}

md "$vimfiles\autoload"
(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',  "$vimfiles\autoload\plug.vim")
c:
cd $vimInstallPath
.\gvim.exe +PlugInstall +qa

Write "Installing Powerline fonts..." -NoNewLine
$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$objFolder.CopyHere("$vimRcRepoPath\resources\PragmataPro.ttf")
$objFolder.CopyHere("$vimRcRepoPath\resources\Inconsolata for Powerline.otf")
$objFolder.CopyHere("$vimRcRepoPath\resources\PragmataPro for Powerline.ttf")
Write "done."

# Write 'Installing powerline for vim...' -ForegroundColor Green
# c:
# cd \python27\scripts
# pip install powerline-status

# $uri = 'https://raw.githubusercontent.com/powerline/powerline/master/powerline/bindings/vim/plugin/powerline.vim'
# (New-Object Net.WebClient).DownloadFile($uri, "$vimInstallPath\plugin\powerline.vim")

# npm packages for vim syntastic javascript checker
npm install -g eslint
npm install -g eslint-plugin-react
npm install -g babel-eslint
npm install -g eslint-config-defaults

# Fuzzy file finder, can be used within Vim
choco install fzf

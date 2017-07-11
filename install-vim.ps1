$currentDir = Split-Path $MyInvocation.MyCommand.Definition

Write-Host 'Installing and configuring Vim...' -ForegroundColor Green
choco install vim --limit-output --force -y

# Install vim-plug
md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, "~\vimfiles\autoload\plug.vim")

# Get my vimrc from GitHub and symlink it to where Vim looks for it
cd ~\
cmd /c mklink /H _vimrc "$currentDir\_vimrc"
cmd /c mklink /H _gvimrc "$currentDir\_gvimrc"
c:
cd 'C:\Program Files (x86)\vim\vim80'
.\gvim.exe +PlugInstall +qa

Write-Host "Installing fonts for vim and powerline..." -NoNewLine
$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$objFolder.CopyHere("$currentDir\resources\PragmataPro.ttf")
$objFolder.CopyHere("$currentDir\resources\Inconsolata for Powerline.otf")
$objFolder.CopyHere("$currentDir\resources\PragmataPro for Powerline.ttf")
Write-Host "done."

Write-Host 'Installing powerline for vim...' -ForegroundColor Green
c:
cd \python27\scripts
pip install powerline-status

$uri = 'https://raw.githubusercontent.com/powerline/powerline/master/powerline/bindings/vim/plugin/powerline.vim'
(New-Object Net.WebClient).DownloadFile($uri, 'C:\Program Files (x86)\vim\vim80\plugin\powerline.vim')

# npm packages for vim syntastic javascript checker
npm install -g eslint
npm install -g eslint-plugin-react
npm install -g babel-eslint
npm install -g eslint-config-defaults
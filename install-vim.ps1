param(
    [string] $sourceCodePath = 'C:\dev'
)

$vimRcRepoPath = "$Env:USERPROFILE\vimfiles\symlink-repos\vimrc"
$vimfiles = "$Env:USERPROFILE\vimfiles"


# This clones the repo on the same drive as symlinks only work on the same drive
ri $vimfiles -Recurse -Force -ErrorAction SilentlyContinue
md "$vimfiles\symlink-repos"
cd "$vimfiles\symlink-repos"
git clone https://github.com/vincpa/vimrc

# Create a junction to the place where all my other source code lives
Remove-Item "$sourceCodePath\vimrc" -Recurse -Force -ErrorAction SilentlyContinue
junction "$sourceCodePath\vimrc" .\vimrc\

# Get my vimrc from GitHub and symlink it to where Vim looks for it
cd ~\
Remove-Item _vimrc -ErrorAction SilentlyContinue
Remove-Item _gvimrc -ErrorAction SilentlyContinue
cmd /c mklink /H _vimrc "$vimRcRepoPath\_vimrc"
cmd /c mklink /H _gvimrc "$vimRcRepoPath\_gvimrc"


Write-Host 'Installing and configuring Vim...' -ForegroundColor Green
choco uninstall vim --limit-output -y | Out-Null
choco install vim --limit-output --force -y

# Install vim-plug
md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, "$vimfiles\autoload\plug.vim")

c:
cd 'C:\Program Files (x86)\vim\vim80'
.\gvim.exe +PlugInstall +qa

Write-Host "Installing fonts for vim and powerline..." -NoNewLine
$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$objFolder.CopyHere("$vimRcRepoPath\resources\PragmataPro.ttf")
$objFolder.CopyHere("$vimRcRepoPath\resources\Inconsolata for Powerline.otf")
$objFolder.CopyHere("$vimRcRepoPath\resources\PragmataPro for Powerline.ttf")
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

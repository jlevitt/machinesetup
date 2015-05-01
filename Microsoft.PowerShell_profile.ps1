Set-Location C:\projects

##### Git helpers
function Grepout($pattern)
{
    git checkout $(git branch | grep $pattern).Trim()
}

Set-Alias grout Grepout

function DeleteMergedLocal()
{
    git branch --merged | grep -v "\*" | grep -v "master" | xargs -n 1 git branch -d
}

Set-Alias dml DeleteMergedLocal

function ViewMergedLocal()
{
    git branch --merged | grep -v "\*" | grep -v "master"
}

Set-Alias vml ViewMergedLocal

function KillSite($keep)
{
    Get-Process iisexpress |? { -Not $keep.Contains($_.Id) } | Stop-Process
}

Set-Alias ks KillSite

function DeleteBinaries($path)
{
    if (-not $path)
    {
        throw "You must supply a path"
    }
    gci $path -Recurse -Include *.exe,*.pdb,*.dll | Remove-Item
}

Set-Alias delbin DeleteBinaries

function OpenSolutions
{
    . $(ls *.sln)
}

Set-Alias sln OpenSolutions

function TortoiseGit($command, $path)
{
    if (-not $path)
    {
        $path = "."
    }
    & "C:\Program Files\TortoiseGit\bin\TortoiseGitProc.exe" /command:$command /path:$path
}

Set-Alias tgit TortoiseGit

function ChangeDirProjects
{
    cd c:\projects
}

Set-Alias projects ChangeDirProjects

function ChangeDirDev
{
    cd c:\dev
}

Set-Alias dev ChangeDirDev

function EditProfile
{
    notepad++.exe c:\projects\personal\machinesetup\Microsoft.PowerShell_profile.ps1
}

Set-Alias edit-profile EditProfile

function UpdateProfile
{
    cp c:\projects\personal\machinesetup\Microsoft.PowerShell_profile.ps1 $PROFILE
}

Set-Alias update-profile UpdateProfile

# Load posh-git example profile
. 'C:\projects\open-source\posh-git\profile.example.ps1'

"New profile copied - Run '. `$PROFILE' to update."

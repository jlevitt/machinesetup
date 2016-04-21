Set-Location C:\projects
Remove-Variable -Force HOME
Set-Variable HOME "C:\Users\jake.levitt"
$env:HOMEDRIVE="C:"
$env:HOMEPATH="\Users\jake.levitt"
$env:PSModulePath += ";C:\projects\cicd-scripts\Modules"
Import-Module Orchestration
Set-OrchestrationUser jlevitt

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

#See possible commands here: https://tortoisegit.org/docs/tortoisegit/tgit-automation.html
function TortoiseGit($command, $path)
{
    if (-not $path)
    {
        $path = "."
    }
    & "C:\Program Files\TortoiseGit\bin\TortoiseGitProc.exe" /command:$command /path:$path
}

Set-Alias tgit TortoiseGit

function ShowUnpushedCommits
{
    git branch |% { $_.Substring(2) } |% { git log origin/$_..$_ }
}

Set-Alias git-show-unpushed-commits ShowUnpushedCommits

function ShowDeletions($rangeSpecification)
{
	git log $rangeSpecification --shortstat | sls "([\d]+) deletions" |% { $_.Matches } |% { $_.groups[1].value } | Measure-Object -Sum
}

Set-Alias git-deletions ShowDeletions

function GitChangeLog($rangeSpecification)
{
	git log --merges --grep="pull request" --pretty=format:'%C(yellow)%h%Creset - %s%n  %an %Cgreen(%cr)%C(bold blue)%d%Creset%n' $rangeSpecification
}

Set-Alias git-cl GitChangeLog

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

function OpenNunit($path)
{
	$dll = $path
	if (-not $path.EndsWith(".dll"))
	{
		$dll = Join-Path $path "bin\debug\$path.dll" -Resolve
	}

    . $(gci *tools*\NUnit\nunit-x86.exe) $dll
}

Set-Alias nunit OpenNunit

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
    gvim c:\projects\personal\machinesetup\Microsoft.PowerShell_profile.ps1
}

Set-Alias edit-profile EditProfile

function UpdateProfile
{
    cp c:\projects\personal\machinesetup\Microsoft.PowerShell_profile.ps1 $PROFILE
}

Set-Alias update-profile UpdateProfile

function RunJavaScriptTests($directory)
{
    C:\projects\cp3\packages\Chutzpah.3.2.4\tools\chutzpah.console.exe $directory
}

Set-Alias jstest RunJavaScriptTests

function Shutdown-ExcedentCom
{
    $comAdmin = New-Object -com ("COMAdmin.COMAdminCatalog.1")
    $comAdmin.ShutdownApplication("Excedent")
}

Set-Alias killcom Shutdown-ExcedentCom

# Load posh-git example profile
. 'C:\projects\open-source\posh-git\profile.example.ps1'

New-Alias which get-command

Set-Location C:\projects
Remove-Variable -Force HOME
Set-Variable HOME "C:\Users\jake.levitt"
$env:HOMEDRIVE="C:"
$env:HOMEPATH="\Users\jake.levitt"
$env:PSModulePath += ";C:\projects\cicd-scripts\Modules"

##### Git helpers
function Grepout($pattern)
{
    git checkout $(git branch | grep $pattern).Trim()
}

Set-Alias grout Grepout

function DeleteMergedLocal()
{
    git branch --merged | grep -v "\*" | grep -v "master" |% { git branch -d $_.Trim() }
}

Set-Alias dml DeleteMergedLocal

function ViewMergedLocal()
{
    git branch --merged | grep -v "\*" | grep -v "master"
}

Set-Alias vml ViewMergedLocal

function Coalesce($a, $b) 
{ 
    if ($a -ne $null) 
    { 
	$a 
    } 
    else 
    { 
	$b 
    } 
}

New-Alias "??" Coalesce

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

function OpenSolutions($path)
{
    $path = ?? $path "."
    . $(ls $path\*.sln)
}

Set-Alias sln OpenSolutions

function OpenAtom
{
    atom .
}

Set-Alias atm OpenAtom

function nunit($path, $Version = "cwd")
{
    $dll = $path
    $dllName = $path | Split-Path -Leaf
    if (-not $path.EndsWith(".dll"))
    {
	$dll = Join-Path $path "bin\debug\$dllName.dll" -Resolve -ErrorAction SilentlyContinue
    }

    if (-not $dll)
    {
	$dll = Join-Path $path "bin\Development\$dllName.dll" -Resolve -ErrorAction SilentlyContinue
    }

    switch($version)
    {
	"cwd" { . $(gci *tools*\NUnit\nunit-x86.exe) $dll }
	"3.6" { . "C:\Program Files\NUnit-Gui-0.3\nunit-gui.exe" $dll } 
    }
}

function ChangeDirProjects
{
    cd c:\projects
}

Set-Alias projects ChangeDirProjects

function ChangeDirThermomix
{
    cd c:\projects\thermomix
}

Set-Alias therm ChangeDirThermomix

function ChangeDirAppsBilling
{
    cd c:\projects\apps-billing
}

Set-Alias ab ChangeDirAppsBilling

function ChangeDirCP3
{
    cd c:\projects\cp3
}

Set-Alias cp3 ChangeDirCP3

function ChangeDirUsage
{
    cd c:\projects\usage
}

Set-Alias usage ChangeDirUsage

function ChangeDirDev
{
    cd c:\dev
}

Set-Alias dev ChangeDirDev

function ChangeDirSql
{
    cd c:\projects\sql
}

Set-Alias sql ChangeDirSql

function ChangeDirNotifications
{
    cd c:\projects\notifications
}

Set-Alias nt ChangeDirNotifications

function ChangeDirHaskell
{
    cd C:\projects\personal\haskell\course\4
}

Set-Alias hk ChangeDirHaskellKatas

function ChangeDirHaskellKatas
{
    cd C:\projects\personal\haskell-katas
}

Set-Alias hs ChangeDirHaskell

function EditProfile
{
    gvim $PROFILE
}

Set-Alias edit-profile EditProfile

function UpdateProfile
{
    cp $PROFILE c:\projects\personal\machinesetup\Microsoft.PowerShell_profile.ps1
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
New-Alias which get-command

function UseOrchestration
{
    Import-Module Orchestration
    Set-OrchestrationUser jlevitt
}

New-Alias Use-Orchestration UseOrchestration

function PullRebase
{
    git save
    git pullr
    git pop
}

New-Alias pull PullRebase

function CopyJSAPI
{
    copy C:\projects\jsapi\package\* C:\projects\cp3\ControlPanel.Web\bower_components\rackspace-cloud-office
}

New-Alias cpjs CopyJSAPI

function Run-Invoicing ($InvoiceDate, [switch]$Advanced, $AccountNumbers = $null)
{
    $runType = ""
    if ($Advanced)
    {
	$runType = "-runtype:AdvancedInvoicing"
    }
    else
    {
	$runType = "-runtype:SmbInvoicing"
    }

    $accountNumbersParam = ""
    if ($AccountNumbers)
    {
	$accountNumbersParam = "-accountNumbers:`"$AccountNumbers`""
    }

    $cmd = "C:\projects\apps-billing\src\Rackspace.Juno.Runner.Invoicing\bin\Debug\Rackspace.Juno.Runner.Invoicing.exe -invoiceDate:$InvoiceDate $runType $accountNumbersParam"
    $cmd
    iex $cmd
}

function Run-Template ($TemplateId)
{
    $cmd = "C:\projects\notifications\Rackspace.Notifications.Console\bin\Debug\Rackspace.Notifications.Console.exe C:\projects\notifications\Artifacts\sample $TemplateId"
    $cmd
    iex $cmd
}

function Run-DNSCheck ($Domains)
{
    if ($Domains)
    {
	$domainsParam = "--domains `"$Domains`""
    }
    
    $cmd = "C:\projects\cp3\ControlPanel.Domains.Renewal.Service\bin\Debug\ControlPanel.Domains.Renewal.Service.exe $domainsParam"
    $cmd
    iex $cmd
}

function Run-Migration ($DbVersion = $null)
{
    $cmd = "C:\projects\sql\Schema\MigrateAdmin.Runner\bin\Debug\MigrateAdmin.Runner.exe $DbVersion"
    $cmd
    iex $cmd
}

function Portion ($Inflection, $Start, $End) 
{
  $inflectionDate = [DateTime]$Inflection
  $startDate = [DateTime]$Start
  $endDate = [DateTime]$End
  $month = $inflectionDate.Month
  ($endDate - $inflectionDate).TotalMilliseconds / ($endDate - $startDate).TotalMilliseconds
}

function smb($d) { Portion $d "11/28/2016" "12/28/2016" }
function adv($d) { Portion $d "2/01/2017" "03/01/2017" }

function Connect-Environment($Like, $Node = "iis")
{
  Get-Environment |? { $_.environment_type.Contains($Like) } | New-RdpSession -Node $Node
}

function Open-Csv($InvoiceID, $Database = "Admin", $Server = ".\SQLEXPRESS", [switch]$xml = $false)
{
  $row = Invoke-SqlServerQuery -Sql "select externFile from admInvoices where invoiceID=$InvoiceID" -Database $Database -Server $Server
  if ($xml)
  {
    $xmlPath = $($row | select -ExpandProperty externFile).Trim()
    gvim $xmlPath
  }
  else
  {
    Get-Process EXCEL -ErrorAction SilentlyContinue | kill
    $csvPath = $($row | select -ExpandProperty externFile).Trim().Replace("xml", "csv")

    . $csvPath
  }
}

function Populate-Invoices
{
  param(
      $Path,
      $SmbAccountNumber = "100003",
      $Database = "Admin",
      $Server = ".\SQLEXPRESS"
  )

  $smbInvoices = gci $Path -r -i *.xml

  $sql = "update admInvoices set void=1 where accountNumber='100003';"
  $result = Invoke-SqlServerQuery -Sql $sql -Database $Database -Server $Server -CUD

  foreach ($invoicePath in $smbInvoices)
  {
      $invoice = [xml](gc $invoicePath)
      $invoiceDate = ([datetime]$invoice.root.invoiceDate).ToShortDateString()
      $dueDate = ([datetime]$invoice.root.dueDate).ToShortDateString()
      $invoiceID = $invoice.root.invoiceID
      $total = $invoice.root.invoiceTotal.Replace(",", "")
      $path = $invoicePath.FullName
      $sql = "delete from admInvoices where invoiceID='$invoiceID' and source='testcase';SET IDENTITY_INSERT admInvoices ON;insert into admInvoices (invoiceID, accountNumber, invoiceDate, paymentDueDate, totalDue, externFile, void, invoiceType, paidInFull, source) values ($invoiceID, '$SmbAccountNumber', '$invoiceDate', '$dueDate', $total, '$path', 0, 'billing', 1, 'testcase');"

      $result = Invoke-SqlServerQuery -Sql $sql -Database $Database -Server $Server -CUD
  }
}

function off 
{
    Stop-Computer -Force -AsJob
}

function db-version 
{ 
    Invoke-SqlServerQuery -Sql "select * from VersionInfo" 
}


# Import git-status-cache-posh-client
Import-Module 'C:\projects\open-source\posh-git-cache-fork\GitStatusCachePoshClient.psm1'

# Load posh-git example profile
. 'C:\Users\jake.levitt\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'


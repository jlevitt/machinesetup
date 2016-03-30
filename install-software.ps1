choco install devbox-rapidee -y
choco install tortoisegit -y
choco install git -params '"/GitAndUnixToolsOnPath /NoAutoCrlf"' -y
choco install notepadplusplus -y
choco install pidgin -y
choco install 7zip.install -y
choco install conemu -y
choco install vim -y
choco install rdcman -y
choco install keepass -y
choco install lockhunter -y
choco install fiddler -y
choco install NuGet.CommandLine
choco install NugetPackageExplorer -y
choco install pandoc -y
choco install hxd -y
choco install kdiff3 -y
choco install haskellplatform -y
choco install virtualbox -y
choco install vagrant -y
choco install logparser -y
choco install mysql -y
choco install mysql.workbench -y
choco install shexview.portable -y
choco install procexp -y
choco install putty -y
choco install pstools -y
choco install windirstat -y
choco install winscp -y
choco install wireshark -y

# Used for contractacon
choco install ruby -Version 1.9.3.55100
choco install ruby.devkit
gem install httparty
gem install json-schema
gem install multi_json
gem install minitest
choco install python2

# Has non choco dependencies
choco install resharper

# Non-choco
(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex

# Other
# * TortoiseGit
# * MSSoap toolkit 3.0
# * WebServiceStudio
# * Android Studio
# * Box
# * Jungle Disk Workgroup
# * Memcache 1.2.5
# * SQL Server
# * SQL Server Express
# * Data tools
# * VS 2008,2010,2012,2013
# * Redgate reflector
# * Log Parser
# * http://slntools.codeplex.com/wikipage?title=SLNTools%20Compare&referringTitle=Home
#  * Open TortoiseGit settings
#  * Click Diff Viewer
#  * Click Advanced…
#  * Click Add…
#  * For Extension, enter .sln
#  * For External Program enter: "C:\Program Files (x86)\Tools for SLN File\SLNTools.exe" CompareSolutions %base %mine
# * Posh git

# Settings
# * Putty
# * Postman
# * Resharper

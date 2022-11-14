FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN powershell "Set-Service -Name wuauserv -StartupType Manual; \
    Install-WindowsFeature -Name NET-Framework-Features -Verbose"

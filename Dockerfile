FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN powershell "Set-Service -Name wuauserv -StartupType Manual; \
    Install-WindowsFeature -Name NET-Framework-Features -Verbose"
RUN powershell "Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
RUN powershell "choco feature enable -n allowGlobalConfirmation; choco feature disable -n showDownloadProgress"
RUN choco install \
    wixtoolset \
    awscli \
    jq \
    git \
    golang
COPY wixtoolset_path.ps1 /Windows/temp/
RUN powershell /Windows/temp/wixtoolset_path.ps1
RUN choco install python --version 3.9
RUN pip install --upgrade pip wheel

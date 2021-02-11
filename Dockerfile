FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN echo 'Invoking some web request to download the packagae management AKA chocolatey'
RUN @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin" -Y


RUN echo 'Installing minikube using chocolatey'
RUN choco install minikube -Y


RUN echo 'Setting up the working directory where the kubectl CLI is located'
WORKDIR C:/ProgramData/chocolatey/lib/kubernetes-cli/tools/kubernetes/client/bin


RUN echo 'refreshing the environment variables after installing applications -- GOOD PRACTICE'
RUN refreshenv


RUN echo 'TRYING TO CONFIRM WHETHER I AM IN THE CORRECT WORKING DIRECTORY'
RUN dir

RUN echo 'WHAT SHOULD OCCUR WHEN THE INSTANCE OF THE IMAGE IS RUNNING'
RUN choco install minikube -Y
WORKDIR C:/ProgramData/chocolatey/lib/kubernetes-cli/tools/kubernetes/client/bin
RUN refreshenv
RUN dir

ENTRYPOINT ["minikube","start"]


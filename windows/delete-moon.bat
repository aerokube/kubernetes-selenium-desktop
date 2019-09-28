@echo off
echo Removing Minikube...
minikube delete

echo Removing Virtual Swich...
PowerShell -Command Remove-VMSwitch MoonSwitch -Force

echo Removing moon.aerokube.local from /etc/hosts...
type C:\Windows\System32\Drivers\etc\hosts | findstr /v moon.aerokube.local >etc_hosts.tmp
move /Y etc_hosts.tmp C:\Windows\System32\Drivers\etc\hosts
del etc_hosts.tmp

echo Removing directories...
rmdir /S /Q %USERPROFILE%\.minikube
rmdir /S /Q %USERPROFILE%\.kube
rmdir /S /Q k8s


@echo off
pushd .
echo Removing Minikube...
cd %USERPROFILE%\moon
minikube delete -p moon

echo Removing Virtual Swich...
PowerShell -Command Remove-VMSwitch MoonSwitch -Force
echo.

echo Removing moon.aerokube.local from /etc/hosts...
type C:\Windows\System32\Drivers\etc\hosts | findstr /v moon.aerokube.local >etc_hosts.tmp
copy etc_hosts.tmp C:\Windows\System32\Drivers\etc\hosts >nul
del etc_hosts.tmp

popd

rmdir /S /Q %USERPROFILE%\moon


@echo off

echo Creating working directory %USERPROFILE%\moon...
mkdir %USERPROFILE%\moon
pushd .
cd %USERPROFILE%\moon

echo Downloading Moon Deploy...
curl -LO https://raw.githubusercontent.com/aerokube/kubernetes-selenium-desktop/master/moon.yaml

echo Downloading kubectl...
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/windows/amd64/kubectl.exe

echo Downloading minikube...
curl -Lo minikube.exe https://github.com/kubernetes/minikube/releases/download/v1.11.0/minikube-windows-amd64.exe

echo Creating Virtual Switch...
PowerShell -Command "New-VMSwitch -name MoonSwitch -NetAdapterName Ethernet -AllowManagementOS $true"

echo Awaiting Virtual Switch...
:loop
  curl -I http://google.com >nul 2>nul
  if %ERRORLEVEL% neq 0 (
	goto :loop
  )
set ERRORLEVEL=
echo.

echo Starting Minikube...
minikube start -p moon --vm-driver=hyperv --hyperv-virtual-switch=MoonSwitch --kubernetes-version=v1.17.7 
minikube -p moon addons enable ingress
minikube -p moon addons enable metrics-server

echo Checking Minikube IP address...
minikube -p moon ip >minikube-ip.tmp
type minikube-ip.tmp
set /p MINIKUBE_IP=<minikube-ip.tmp
del minikube-ip.tmp

echo Adding moon.aerokube.local to /etc/hosts...
echo %MINIKUBE_IP% moon.aerokube.local >> C:\Windows\System32\Drivers\etc\hosts

echo Deploying Moon...
kubectl apply -f moon.yaml

kubectl rollout status deploy/moon -n moon

echo Exposing Moon Service...
kubectl patch svc moon -n moon --patch "{\"spec\":{\"externalIPs\":[\"%MINIKUBE_IP%\"]}}"

set MINIKUBE_IP=
popd

echo.
echo Access Moon Web Interface at: http://moon.aerokube.local
echo Run Tests against: http://moon.aerokube.local:4444/wd/hub
echo.
echo Create session with:
echo curl http://moon.aerokube.local:4444/wd/hub/session -d"{\"desiredCapabilities\":{\"browserName\":\"chrome\", \"enableVNC\":true}}"


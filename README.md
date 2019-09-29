# Kubernetes Selenium on Desktop

This repository contains one-command automation scripts allowing to quickly deploy [Moon](https://aerokube.com/moon/) - Selenium browser automation solution running in [Kubernetes](https://kubernetes.io/) cluster.

## One-command Deployment on Windows

On Windows we are using a [Hyper-V](https://en.wikipedia.org/wiki/Hyper-V) virtual machine to start [Minikube](https://github.com/kubernetes/minikube) and deploy Moon.

1) Open [PowerShell](https://en.wikipedia.org/wiki/PowerShell) with administrator permissions. 
2) Enable Hyper-V:
```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

3) Download and run installation script:
```
C:\Windows\system32>cd %USERPROFILE%
C:\Users\user>curl -Lo moon.bat https://raw.githubusercontent.com/aerokube/kubernetes-selenium-desktop/master/windows/moon.bat
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1824  100  1824    0     0   1824      0  0:00:01 --:--:--  0:00:01  3334
C:\Users\user>moon.bat
Creating working directory C:\Users\user\moon...
Downloading Moon Deploy...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 20165  100 20165    0     0  20165      0  0:00:01 --:--:--  0:00:01 39155
Downdoading kubectl...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 45.0M  100 45.0M    0     0  15.0M      0  0:00:03  0:00:03 --:--:-- 11.2M
Downdoading minikube...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   616    0   616    0     0    616      0 --:--:-- --:--:-- --:--:--  1193
100 56.1M  100 56.1M    0     0  7192k      0  0:00:08  0:00:08 --:--:-- 8161k
Creating Virtual Switch...

Name       SwitchType NetAdapterInterfaceDescription
----       ---------- ------------------------------
MoonSwitch External   Intel(R) 82574L Gigabit Network Connection


Awaiting Virtual Switch...

Starting Minikube...
* [moon] minikube v1.4.0 on Microsoft Windows 10 Pro 10.0.17763 Build 17763
* Downloading VM boot image ...
    > minikube-v1.4.0.iso.sha256: 65 B / 65 B [--------------] 100.00% ? p/s 0s
    > minikube-v1.4.0.iso: 135.73 MiB / 135.73 MiB [] 100.00% 13.50 MiB p/s 10s
* Creating hyperv VM (CPUs=4, Memory=4096MB, Disk=20000MB) ...
* Preparing Kubernetes v1.16.0 on Docker 18.09.9 ...
* Downloading kubeadm v1.16.0
* Downloading kubelet v1.16.0
* Pulling images ...
* Launching Kubernetes ...
* Waiting for: apiserver proxy etcd scheduler controller dns
* Done! kubectl is now configured to use "moon"
* ingress was successfully enabled
* metrics-server was successfully enabled
Checking Minikube IP address...
192.168.3.161
Adding moon.aerokube.local to /etc/hosts...
Deploying Moon...
namespace/moon created
role.rbac.authorization.k8s.io/moon created
rolebinding.rbac.authorization.k8s.io/moon created
service/moon created
ingress.networking.k8s.io/moon created
deployment.apps/moon created
configmap/quota created
secret/users created
secret/licensekey created
Waiting for deployment "moon" rollout to finish: 0 of 2 updated replicas are available...
Waiting for deployment "moon" rollout to finish: 1 of 2 updated replicas are available...
deployment "moon" successfully rolled out
Exposing Moon Service...
service/moon patched
```

4) Access Moon Web Interface at: `http://moon.aerokube.local`. Use the following Selenium URL to run your tests: `http://moon.aerokube.local:4444/wd/hub`.
5) **Optional.** To check that everything works you can also use the following `curl` command:
```
$ curl http://moon.aerokube.local:4444/wd/hub/session -d"{\"desiredCapabilities\":{\"browserName\":\"chrome\", \"enableVNC\":true}}"
```
6) **Optional.** To completely remove Moon - run removal script:
```
C:\Windows\system32>cd %USERPROFILE%
C:\Users\user>curl -Lo moon.bat https://raw.githubusercontent.com/aerokube/kubernetes-selenium-desktop/master/windows/delete-moon.bat
C:\Users\user>delete-moon.bat

```

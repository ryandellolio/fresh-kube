# fresh-kube
A useful externally hosted script that installs Kubernetes and Flannel CNI without a package manager
## Usage
### Install Kubernetes
`sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ryandellolio/fresh-kube/main/install-k8s-master.sh)"`

You can find your join command after by looking through the output of `journalctl | grep -A 1 join`

### Initialize cluster
`sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ryandellolio/fresh-kube/main/k8s-init.sh)"`

## Thanks
Thanks to [this gist](https://gist.github.com/jepio/71d5239c2bf38c142133c76fdf22bec1#file-flatcar-install-k8s-sh) by jipio, I had a great starting point for my purposes

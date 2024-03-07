# Example Rails application with Tilt on Silverblue

Runs a very basic Rails app with Postgres on Tilt.

# Additional setup steps:

## 0. Ensure your Silverblue is up to date

The default installation of Silverblue 39 has a bug that breaks the Kind installation. Updating to the latest version will resolve this.

## 1. Install Kubectl

```
host$ install <(curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl") ~/.local/bin/kubectl
```

## 2. Install Kind

```
toolbox$ sudo dnf install golang
toolbox$ go install sigs.k8s.io/kind@v0.22.0
```

Ensure go is in the path with a `~/.bashrc.d/go.sh`:

```bash
export PATH="$HOME/go/bin:$PATH"
```

## 3. Start Kind with a local registry

I added [kind-with-registry.sh](scripts/kind-with-registry.sh) to my `~/.local/bin` and ran it.

You'll also need to mark the registry as insecure, with this in `~/.config/containers/registries.conf.d/kind.conf`:

```toml
[[registry]]
location = "localhost:5001"
insecure = true
```

## 3. Install Helm

```
host$ install <(curl https://get.helm.sh/helm-$(curl https://get.helm.sh/helm-latest-version)-linux-amd64.tar.gz | tar -xOzf - linux-amd64/helm) ~/.local/bin/helm
```

## 4. Install Tilt

This script just copies the latest stable binary to `~/.local/bin` so you can do that instead if you prefer.

```
host$ curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
```

## 5. Hopefully! It works from here

```
host$ tilt up
```

# Get a Rails console

```
host$ ./bin/tilt-run rails c
```

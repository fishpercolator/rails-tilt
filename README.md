# Example Rails application with Tilt on Silverblue

Currently this just runs a basic Sinatra app, but it's a work in progress!

# Additional setup steps:

## 1. Install Kind

```
toolbox$ sudo dnf install golang
toolbox$ go install sigs.k8s.io/kind@v0.22.0
```

Ensure go is in the path with a `~/.bashrc.d/go.sh`:

```bash
export PATH="$HOME/go/bin:$PATH"
```

## 2. Start Kind with a local registry

I added [kind-with-registry.sh](scripts/kind-with-registry.sh) to my `~/.local/bin` and ran it.

You'll also need to mark the registry as insecure, with `/etc/containers/registries.conf.d/kind.conf`:

```toml
[[registry]]
prefix = "localhost:5001"
location = "localhost:5001"
insecure = true
```

## 3. Install Tilt

This script just copies the latest stable binary to `~/.local/bin` so you can do that instead if you prefer.

```
host$ curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
```

## 4. Hopefully! It works from here

```
host$ tilt up
```

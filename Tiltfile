docker_build('rails-tilt', '.', dockerfile='Containerfile')
k8s_yaml('app.yaml')
k8s_resource('rails-tilt', port_forwards=8080)

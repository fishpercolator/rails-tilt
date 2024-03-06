load('ext://helm_resource', 'helm_resource', 'helm_repo')
load('ext://podman', 'podman_build')
load('ext://secret', 'secret_from_dict')

# Set up secrets with defaults for development
k8s_yaml(secret_from_dict('tiltfile', inputs = {
    'postgres-password' : os.getenv('POSTGRESQL_PASSWORD', 's3sam3')
}))

# Use Helm to spin up postgres
helm_repo('bitnami', 'https://charts.bitnami.com/bitnami')
helm_resource(
    name='postgresql',
    chart='bitnami/postgresql',
    flags=[
        '--set=image.tag=16',
        '--set=global.postgresql.auth.existingSecret=tiltfile',
    ],
    labels=['database']
)

# The Rails app itself is built and served by app.yaml
podman_build('rails-tilt', '.')
k8s_yaml('app.yaml')
k8s_resource('rails-tilt', 
    labels=['app'],
    resource_deps=['postgresql'],
    port_forwards='3000:3000'
)

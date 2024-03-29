load('ext://helm_resource', 'helm_resource', 'helm_repo')
load('ext://podman', 'podman_build')
load('ext://secret', 'secret_from_dict')
load('ext://uibutton', 'cmd_button')

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
  labels=['database'],
  resource_deps=['bitnami'],
)

# The Rails app itself is built and served by app.yaml
podman_build('rails-tilt', '.', live_update=[
  sync('.', '/rails'),
  run('bundle', trigger=['./Gemfile', './Gemfile.lock']),
  run('bundle exec rails assets:precompile', trigger=['./app/assets'])
])
k8s_yaml('app.yaml')
k8s_resource('rails-tilt', 
  labels=['app'],
  resource_deps=['postgresql'],
  port_forwards='3000:3000'
)
cmd_button('rails-tilt:db-migrate',
  argv=['./bin/tilt-run', 'rails', 'db:migrate'],
  resource='rails-tilt',
  icon_name='engineering',
  text='Run migrations',
)
cmd_button('rails-tilt:db-reset',
  argv=['./bin/tilt-run', 'rails', 'db:seed:replant'],
  resource='rails-tilt',
  icon_name='restart_alt',
  text='Reset database',
  requires_confirmation=True,
)

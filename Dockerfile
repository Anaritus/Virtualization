FROM quay.io/jupyterhub/jupyterhub as jupyterhub

CMD jupyterhub \
  --Spawner.notebook_dir="${DIRECTORY}" \
  --Authenticator.allow_all=true \
  # CMD jupyterhub

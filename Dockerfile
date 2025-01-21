FROM quay.io/jupyterhub/jupyterhub as jupyterhub

RUN echo "Test layer"

CMD jupyterhub \
  --Spawner.notebook_dir="${DIRECTORY}" \
  --Authenticator.allow_all=true \
  # CMD jupyterhub

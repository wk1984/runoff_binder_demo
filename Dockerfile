# Dockerfile for binder
# Reference: https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html

FROM wk1984/mhm_model:latest

USER root

# Create user alice with uid 1000
ARG NB_USER=alice
ARG NB_UID=1000
ENV NB_USER alice
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password --gecos "Default user" --uid ${NB_UID} ${NB_USER}

RUN chown -R ${NB_USER}:${NB_USER} ${HOME}

# Make sure the contents of the notebooks directory are in ${HOME}

COPY example_domain/ ${HOME}/
COPY *.ipynb ${HOME}/

# # Switch to the user
USER ${NB_USER}

# Start in the home directory of the user
WORKDIR /home/${NB_USER}

# CMD ["jupyter-lab" ,  "--ip=0.0.0.0"]
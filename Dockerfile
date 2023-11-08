FROM harbor-prod.hinagro.com/base-docker-images/ubuntu:20.04
LABEL maintainer="Srinivas G <srinivas.g@perfios.com>"
SHELL ["bash", "-c"]
RUN groupadd -r -g 999 redmine && useradd -r -g redmine -u 999 redmine
COPY . /perfios/redmine/
COPY oracle/ /opt/oracle
ENV HOME /perfios/redmine
RUN	chown redmine:redmine "$HOME"; \
	chmod 1777 "$HOME"; \
	chown redmine:redmine /opt/oracle/;
WORKDIR /perfios/redmine
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN chmod +x /perfios/redmine/docker-entrypoint.sh
RUN ./docker-entrypoint.sh
ENTRYPOINT ["/bin/bash","-c", " source ~/.bashrc && bundle exec rails server -u webrick -e production" ]
EXPOSE 3000

FROM codercom/code-server:4.96.4

RUN sudo curl -SL https://github.com/docker/compose/releases/download/v2.32.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
RUN sudo chmod +x /usr/local/bin/docker-compose
RUN sudo groupadd -g 968 docker && sudo usermod -aG docker coder

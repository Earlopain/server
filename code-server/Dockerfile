FROM codercom/code-server:4.93.1

RUN sudo curl -SL https://github.com/docker/compose/releases/download/v2.24.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
RUN sudo chmod +x /usr/local/bin/docker-compose
RUN sudo groupadd -g 968 docker && sudo usermod -aG docker coder

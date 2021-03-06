FROM ubuntu:xenial

RUN mkdir -p /opt/muesli4
WORKDIR /opt/muesli4

ENV PYTHONUNBUFFERED=1
ENV MUESLI_PATH=/opt/muesli4

EXPOSE 8080
CMD ["/opt/muesli4/docker-serve-test.sh"]

RUN useradd muesli

RUN apt-get update && apt-get install -y python3.5 python3.5-dev lp-solve postgresql-server-dev-9.5 wget python3-pip libjs-jquery-fancybox locales && rm -rf /var/lib/apt/lists/*

RUN locale-gen de_DE.UTF-8
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8

RUN wget https://www.mathi.uni-heidelberg.de/~jvisintini/lp_solve -O /usr/bin/lp_solve
RUN wget https://www.mathi.uni-heidelberg.de/~jvisintini/libxli_DIMACS.so -O /usr/lib/lp_solve/libxli_DIMACS.so

COPY --chown=muesli:muesli ./requirements.txt /opt/muesli4
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

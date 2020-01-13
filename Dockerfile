FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py
ADD . /tmp/create-pkg

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        python3.8 python3.8-distutils \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN set -e \
      && /usr/bin/python3.8 /tmp/get-pip.py \
      && pip install -U --no-cache-dir pip create-pkg \
      && rm -rf /tmp/get-pip.py /tmp/create-pkg

ENTRYPOINT ["/usr/local/bin/create-pkg"]

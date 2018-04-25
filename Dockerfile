	FROM ubuntu:16.04
LABEL maintainer="jose.a.magana@gmail.com"
LABEL author="Paul Ganzon <paul.ganzon@gmail.com>"

LABEL "name"="datascience"

USER root

# NB user
ENV NB_USER admin 
ENV NB_USER_PASS 14mR00t!

# PORTS
ENV PORT0 8787
ENV PORT1 7777
ENV PORT2 8888
ENV PORT3 6006

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# JUPYTER
ENV NOTEBOOK_HOME /home/$NB_USER


# Install
RUN apt-get update  && \
    apt-get -y install apt-transport-https \
    software-properties-common && \
    apt-add-repository ppa:ansible/ansible

RUN echo "deb https://cran.rstudio.com/bin/linux/ubuntu xenial/" | tee -a  /etc/apt/sources.list
RUN gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
RUN gpg -a --export E084DAB9 | apt-key add -

RUN  apt-get update && apt-get -y install python \
    ansible \
    wget \
    gcc-4.9 \
    gdebi-core \
    r-base \
    build-essential \
    python-dev \
    python-pip \
    git \
    libxml2-dev \
    libcurl4-openssl-dev \
    libnlopt-dev \
    libgsl0-dev \
    libssl-dev \
    libxt-dev \
    libgdal-dev \
    libproj-dev \
    nano \
    pandoc \
    pandoc-citeproc \
    libssh2-1-dev \
    libgmp-dev



# Copy files
COPY venv.sh entrypoint.sh requirements.txt / 
RUN chmod +x entrypoint.sh venv.sh
RUN pip install --upgrade pip
RUN pip install virtualenv
RUN /venv.sh

# R
ENV RSTUDIO_URL https://download1.rstudio.org/rstudio-1.1.447-amd64.deb

# Install java
RUN apt-get -y install r-cran-rjava
RUN R CMD javareconf

COPY rpackages.R /
RUN Rscript rpackages.R

# Install RStudio
RUN wget $RSTUDIO_URL -O rstudioserver.deb
RUN gdebi -n rstudioserver.deb
RUN rm -f rstudioserver.deb

# ZEPPELIN
ENV ZEPPELIN_VERSION zeppelin-0.7.2-bin-all
ENV ZEPPELIN_URL http://apache.mirror.serversaustralia.com.au/zeppelin/zeppelin-0.7.2/$ZEPPELIN_VERSION.tgz
ENV ZEPPELIN_NOTEBOOK_DIR /root
ENV ZEPPELIN_HOME /opt/$ZEPPELIN_VERSION

RUN wget $ZEPPELIN_URL
RUN tar -xvf $ZEPPELIN_VERSION.tgz  -C /opt

RUN rm -f venv.sh $ZEPPELIN_VERSION.tgz requirements.txt  rpackages.R 



ENTRYPOINT ["/entrypoint.sh"]

CMD ["notebook"]

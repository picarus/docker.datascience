# Docker Data Science
Docker image containing the following **Data Science** notebooks Jupyter, RStudio and Apache Zeppelin. 
This docker image is a simplification of **KUWADERNO** by Paul Ganzon, that you can find at: www.github.com/pganzon/kuwaderno
Kuwaderno adds spark and mesos to the configuration that I didn't require.
In exchange I have added tensorflow and keras support.

## Building the Docker image.
To build the image, clone this repo and run code below.
```
docker build -t datascience .
```

If you would not like to build this repository you can use the built image on docker hub.
```
docker run  -d -p 8787:8787 -p 7777:7777  -p 8888:8888 picarus/datascience
```


## Using the Docker image
Using bridge networking
```
docker run  -d -p 8787:8787 -p 7777:7777  -p 8888:8888 datascience
```

or using host networking


```
docker run  -d --net=host datascience
```

If you wish to change the port on host networking you can run the following instead.
```
docker run -d -e PORT0=<rstudio.server.port> -e PORT1=<jupyter.port> -e PORT2=<zeppelin.port> --net=host datascience
```

After the execution of the code above the following applications should now be accessible.
* Rstudio Server  - http://ip.address:8787/
* Jupyter         - http://ip.address:7777/
* Apache Zeppelin - http://ip.address:8888/
* Tensorboard     - http://ip.address:6006/

Default user and password to access the url are as follows:
* User: admin
* Password: 14mR00t!

You can change both of the user name and password by using the environment variables NB_USER and NB_USER_PASS. For example, if you want the user to be *user1* and *password1* then run the following:
```
docker run  -d -e NB_USER=user1 -e NB_USER_PASS=password1 --net=host datascience
```

### Application Versions

|Application|Version|
| ------------- |-------------|
| Rstudio Server | 1.1.447|
| Jupyter        | 4.3.0|
| Apache Zeppelin| 0.7.2|
| Tensorflow| |

### R Packages Installed
As the list is extense and will change often, rather check the file rpackages.R

### Python Packages Installed
As the list is extense and will change often, rather check the file requirements.txt

## Docker hub

This docker image is also available from: 

* https://hub.docker.com/r/picarus/datascience/

## Instructions to run from docker

While more comprehensive documentation is put together let's collect some links on how to do it:

* https://docs.docker.com/machine/examples/aws/#step-3-run-docker-commands-on-the-instance

* https://docs.docker.com/machine/reference/env/

* eval "$(docker-machine env default)"

## Use from AWS

* (Optional?) Get your Dockerhub image locally: docker pull picarus/datascience

To upload and register the Docker Image on AWS follow the instructions at: 

* https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#use-ecr

(to be added)

Steps to launch docker image



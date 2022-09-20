FROM ubuntu:latest as development
MAINTAINER abhijeet.deshpande15@gmail.com
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y apache2 \
    zip \
        unzip
RUN apt-get update
RUN apt-get -y install apache2-utils
ADD https://www.tooplate.com/zip-templates/2130_waso_strategy.zip /var/www/html
WORKDIR /var/www/html
RUN unzip 2130_waso_strategy.zip
RUN cp -rvf 2130_waso_strategy/* .
RUN rm -rf 2130_waso_strategy 2130_waso_strategy.zip
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80

FROM ubuntu:latest as production
MAINTAINER abhijeet.deshpande15@gmail.com
RUN apt-get -y update
RUN apt-get install -y apache2 \
    zip \
        unzip
RUN apt-get update
RUN apt-get -y install apache2-utils
WORKDIR /var/www/html
COPY --from=development /var/www/html/ /var/www/html
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80

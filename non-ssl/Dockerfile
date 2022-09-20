FROM ubuntu:18.04
RUN apt-get update \
	&& apt-get -y upgrade \
	&& apt-get install -y wget bash zip rsync python3-venv python3-dev build-essential\
	lsof lshw sysstat net-tools numactl bzip2 runit sudo

RUN groupadd -g 1000 bangdb && useradd -u 1000 -g bangdb -G root bangdb

ARG BANGDB_TARBALL_LOC=https://bangdb.com/downloads/bangdb_2.0_ubuntu18.tar.gz
ARG BANGDB_TARBALL=bangdb_2.0_ubuntu18.tar.gz
ARG BANGDB_DIR=/bangdb_2.0_ubuntu18

RUN wget $BANGDB_TARBALL_LOC \
	  && tar -xzvf $BANGDB_TARBALL \
		&& chmod -R 775 $BANGDB_DIR


RUN chmod +x $BANGDB_DIR/install.sh \
    && chmod +x $BANGDB_DIR/bangdb-server \
		&& chmod +x $BANGDB_DIR/bangdb-server-ssl

WORKDIR $BANGDB_DIR
RUN ./install.sh

RUN chgrp -R 0 bin \
    && chmod -R g+rwx bin \
    && chown -R 1000:0 bin \
    && chown -R 1000:0 bin \
    && chmod -R 775 bin

USER bangdb

EXPOSE 10101 18080

ENTRYPOINT ["/bangdb_2.0_ubuntu18/docker_entrypoint.sh"]
CMD ["/bangdb_2.0_ubuntu18/bangdb.sh"]

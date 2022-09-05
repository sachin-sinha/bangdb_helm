FROM ubuntu:18.04
RUN apt-get update \
	&& apt-get -y upgrade \
	&& apt-get install -y wget bash zip rsync python3-venv python3-dev build-essential\
	lsof lshw sysstat net-tools numactl bzip2 runit sudo

RUN groupadd -g 1000 bangdb && useradd bangdb -u 1000 -g bangdb -M

ARG BANGDB_TARBALL_LOC=https://bangdb.com/downloads/bangdb_2.0_ubuntu18.tar.gz
ARG BANGDB_TARBALL=bangdb_2.0_ubuntu18.tar.gz
ARG BANGDB_DIR=/bangdb_2.0_ubuntu18

RUN wget --no-check-certificate $BANGDB_TARBALL_LOC \
	  && tar -xzvf $BANGDB_TARBALL \
		&& chmod -R 775 $BANGDB_DIR

RUN mkdir $BANGDB_DIR/bin/data \
    && mkdir $BANGDB_DIR/bin/logdir

VOLUME $BANGDB_DIR/bin/data $BANGDB_DIR/bin/logdir

RUN chown -R bangdb:bangdb $BANGDB_DIR/bin/data \
    && chown -R bangdb:bangdb $BANGDB_DIR/bin/logdir \
    && chmod +x $BANGDB_DIR/install.sh \
    && chmod +x $BANGDB_DIR/bangdb-server \
		&& chmod +x $BANGDB_DIR/bangdb-server-ssl

WORKDIR $BANGDB_DIR
RUN ./install.sh
EXPOSE 10101 18080

ENTRYPOINT ["/bangdb_2.0_ubuntu18/docker_entrypoint.sh"]
CMD ["/bangdb_2.0_ubuntu18/bangdb.sh"]

FROM ubuntu:18.04
RUN apt-get update \
	&& apt-get -y upgrade \
	&& apt-get install -y wget bash zip rsync python3-venv python3-dev build-essential\
	lsof lshw sysstat net-tools numactl bzip2 runit sudo

RUN groupadd -g 1000 bangdb && useradd bangdb -u 1000 -g bangdb -M

ARG BANGDB_TARBALL_LOC=https://bangdb.com/downloads/bangdb_2.0_ubuntu18.tar.gz
ARG BANGDB_TARBALL=bangdb_2.0_ubuntu18.tar.gz
ARG BANGDB_DIR=/bangdb_2.0_ubuntu18

RUN wget $BANGDB_TARBALL_LOC \
	  && tar -xzvf $BANGDB_TARBALL \
		&& chmod -R 775 $BANGDB_DIR

RUN mkdir $BANGDB_DIR/bin/data \
    && mkdir $BANGDB_DIR/bin/logdir \
    && mkdir $BANGDB_DIR/bin/archive \
    && mkdir $BANGDB_DIR/bin/reclaim_dir \
    && chown -R bangdb:bangdb $BANGDB_DIR/bin/data \
    && chown -R bangdb:bangdb $BANGDB_DIR/bin/logdir \
    && chown -R bangdb:bangdb $BANGDB_DIR/bin/archive \
    && chown -R bangdb:bangdb $BANGDB_DIR/bin/reclaim_dir

VOLUME $BANGDB_DIR/bin/data $BANGDB_DIR/bin/logdir $BANGDB_DIR/bin/archive $BANGDB_DIR/bin/reclaim_dir

COPY certificate/cert.pem $BANGDB_DIR/bin/certificate/
COPY certificate/key.pem $BANGDB_DIR/bin/certificate/

RUN chmod +x $BANGDB_DIR/install.sh \
    && chmod +x $BANGDB_DIR/bangdb-server \
		&& chmod +x $BANGDB_DIR/bangdb-server-ssl

WORKDIR $BANGDB_DIR
RUN ./install.sh
EXPOSE 10101 18080

ENTRYPOINT ["/bangdb_2.0_ubuntu18/docker_entrypoint_ssl.sh"]
CMD ["/bangdb_2.0_ubuntu18/bangdb.sh"]

#!/bin/bash

SCALA_VERSION="2.11"
KAFKA_VERSION="0.11.0.0"

KAFKA_DIRECTORY="kafka_${SCALA_VERSION}-${KAFKA_VERSION}"
KAFKA_ARCHIVE="${KAFKA_DIRECTORY}.tgz"
KAFKA_SIGNATURE="${KAFKA_ARCHIVE}.asc"

OPT_KAFKA="/opt/kafka"

cd /tmp

wget -nv http://kafka.apache.org/KEYS
wget -nv http://apache.miloslavbrada.cz/kafka/${KAFKA_VERSION}/${KAFKA_ARCHIVE}
wget -nv https://dist.apache.org/repos/dist/release/kafka/${KAFKA_VERSION}/${KAFKA_SIGNATURE}

gpg --import KEYS
gpg --verify ${KAFKA_SIGNATURE} || exit 1

rm KEYS
rm ${KAFKA_SIGNATURE}
rm -rf /root/.gnupg

tar xvf ${KAFKA_ARCHIVE} ${KAFKA_DIRECTORY}/libs

rm ${KAFKA_ARCHIVE}

mkdir -p ${OPT_KAFKA}
mv ${KAFKA_DIRECTORY}/libs ${OPT_KAFKA}

rmdir ${KAFKA_DIRECTORY}

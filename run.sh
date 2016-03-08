#!/bin/bash
cd `dirname $0`

echo " --- Starting irods virtual machine"
(cd vagrant-irods-server && vagrant up)
if [ $? -ne 0 ]; then
	echo "irods vm failed, exiting"
	exit 1
fi

echo " --- Starting docker virtual machine"
(cd vagrant-docker-server && vagrant up)
if [ $? -ne 0 ]; then
	echo "docker vm failed, exiting"
	exit 1
fi

echo " --- Start watching ../gef-docker"
./onchanged-gef-docker.sh
fswatch -0 -o ../gef-docker/gef-docker | xargs -0 -n 1 -I {} ./onchanged-gef-docker.sh

#!/bin/bash
set -e

export MAGENTO_CONTAINER_NAME=web

docker-compose up -d > /dev/null &

while ! $(curl --output /dev/null --silent --head --fail "${NGROK_URL}"); do
    echo "Waiting for docker container to initialize"
    sleep 5
done

docker exec -it ${MAGENTO_CONTAINER_NAME} install-magento
docker exec -it ${MAGENTO_CONTAINER_NAME} install-sampledata
echo "Installing done!"
sleep 120s
#docker exec -it ${MAGENTO_CONTAINER_NAME} composer require wirecard/magento2-ee
#docker exec -it ${MAGENTO_CONTAINER_NAME} php bin/magento setup:upgrade
#docker exec -it ${MAGENTO_CONTAINER_NAME} php bin/magento setup:di:compile
#docker exec -it ${MAGENTO_CONTAINER_NAME} php bin/magento module:status

#docker exec -it ${MAGENTO_CONTAINER_NAME} bash -c "chmod -R 777 ./"
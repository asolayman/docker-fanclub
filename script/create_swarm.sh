#!/bin/bash

NB_MACHINE=2

function deployCompose()
{
    docker stack deploy --compose-file ../swarm-compose.yml lifprojet
}

function createSwarm()
{
    for i in $(seq 1 $NB_MACHINE) ; do
        docker-machine create -d virtualbox  --virtualbox-cpu-count "1"  --virtualbox-memory "1024" node$i
    done
 
    MANAGER_IP=localhost

    docker swarm init --advertise-addr $MANAGER_IP

    MANAGER_TOKEN=$(docker swarm join-token manager -q)
    WORKER_TOKEN=$(docker swarm join-token worker -q)

    for i in $(seq 2 $NB_MACHINE) ; do
        eval $(docker-machine env node$i)
        docker swarm join --token $WORKER_TOKEN $MANAGER_IP:2377
    done
    eval $(docker-machine env -u)
}

createSwarm




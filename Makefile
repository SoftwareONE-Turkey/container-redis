build-redis-image:
	docker build -t quay.io/opstree/redis:6.2 -f Dockerfile .

build-redis-ocp-image:
	docker build -t quay.io/fatihboy/redis-ocp -f Dockerfile.openshift .

build-redis-exporter-image:
	docker build -t opstree/redis-exporter:1.0 -f Dockerfile.exporter .

setup-standalone-server-compose:
	docker-compose -f docker-compose-standalone.yaml up -d

setup-cluster-compose:
	docker-compose -f docker-compose.yaml up -d
	docker-compose exec redis-master-3 /bin/bash -c "/usr/bin/setupMasterSlave.sh"
	docker-compose exec redis-slave-1 /bin/bash -c "/usr/bin/setupMasterSlave.sh"
	docker-compose exec redis-slave-2 /bin/bash -c "/usr/bin/setupMasterSlave.sh"
	docker-compose exec redis-slave-3 /bin/bash -c "/usr/bin/setupMasterSlave.sh"

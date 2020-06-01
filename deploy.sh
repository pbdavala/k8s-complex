# Build for docker a new client image for k8s-complex project (latest tag & env. var git commit sha id for refreshing builds)
docker build -t pdavala/k8s-complex-client:latest -t pdavala/k8s-complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t pdavala/k8s-complex-server:latest -t pdavala/k8s-complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t pdavala/k8s-complex-worker:latest -t pdavala/k8s-complex-worker:$SHA -f ./worker/Dockerfile ./worker

# Push latest tagged images to docker hub. V r using same instance of docker used in travis.yml and already logged in
docker push pdavala/k8s-complex-client:latest
docker push pdavala/k8s-complex-server:latest
docker push pdavala/k8s-complex-worker:latest

# Push the SHA IDed images as well.
docker push pdavala/k8s-complex-client:$SHA
docker push pdavala/k8s-complex-server:$SHA
docker push pdavala/k8s-complex-worker:$SHA




# Apply all configs in the k8s folder
kubectl apply -f k8s

# Imperatively set the latest git commit SHA IDed images on each deployment. They also happen to be the latest also.
# The name client-deployment comes from the metadata name inside client-deployment.yaml file. and client= is the container name.
kubectl set image deployments/client-deployment client=pdavala/k8s-complex-client:$SHA
kubectl set image deployments/server-deployment server=pdavala/k8s-complex-server:$SHA
kubectl set image deployments/worker-deployment worker=pdavala/k8s-complex-worker:$SHA

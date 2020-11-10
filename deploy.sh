docker build -t theozpal/multicontainer-client:latest -t theozpal/multicontainer-client:$SHA -f ./client/Dockerfile ./client
docker build -t theozpal/multicontainer-server:latest -t theozpal/multicontainer-server:$SHA -f ./client/Dockerfile ./server
docker build -t theozpal/multicontainer-worker:latest -t theozpal/multicontainer-worker:$SHA -f ./client/Dockerfile ./worker
docker push theozpal/multicontainer-client:latest
docker push theozpal/multicontainer-server:latest
docker push theozpal/multicontainer-worker:latest
docker push theozpal/multicontainer-client:$SHA
docker push theozpal/multicontainer-server:$SHA
docker push theozpal/multicontainer-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=theozpal/multicontainer-server:$SHA
kubectl set image deployments/client-deployment server=theozpal/multicontainer-client:$SHA
kubectl set image deployments/worker-deployment server=theozpal/multicontainer-worker:$SHA
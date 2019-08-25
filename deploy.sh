docker build -t jnalewabau/multi-client:latest -t jnalewabau/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jnalewabau/multi-server:latest -t jnalewabau/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jnalewabau/multi-worker:latest -t jnalewabau/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jnalewabau/multi-client:latest
docker push jnalewabau/multi-server:latest
docker push jnalewabau/multi-worker:latest

docker push jnalewabau/multi-client:$SHA
docker push jnalewabau/multi-server:$SHA
docker push jnalewabau/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jnalewabau/multi-client:$SHA
kubectl set image deployments/server-deployment server=jnalewabau/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jnalewabau/multi-worker:$SHA
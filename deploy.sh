docker build -t vectorkat/multi-client:latest -t vectorkat/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -f vectorkat/multi-server:latest -t vectorkat/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -f vectorkat/multi-worker:latest -t vectorkat/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vectorkat/multi-client:latest
docker push vectorkat/multi-server:latest
docker push vectorkat/multi-worker:latest

docker push vectorkat/multi-client:$SHA
docker push vectorkat/multi-server:$SHA
docker push vectorkat/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vectorkat/multi-server:$SHA
kubectl set image deployments/client-deployment server=vectorkat/multi-client:$SHA
kubectl set image deployments/worker-deployment server=vectorkat/multi-worker:$SHA
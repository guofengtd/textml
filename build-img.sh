docker build -t guofengjd/textml:1.0 -t guofengjd/textml:latest .

docker push guofengjd/textml:1.0
docker push guofengjd/textml:latest

docker rmi -f $(docker images --filter "dangling=true" -q --no-trunc)
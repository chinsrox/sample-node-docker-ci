
#!/bin/bash
#docker build -t chins/sample-node .
docker push chins/sample-node

ssh -i ~/.ssh/docker-chinmay.pem deploy@54.210.59.122 << EOF
docker pull chins/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi chins/sample-node:current || true
docker tag chins/sample-node:latest chins/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 chins/sample-node:current
EOF


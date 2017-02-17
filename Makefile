image:
	docker build -t adolphlwq/docker-tensorflow:v1.0.0 .
run: image
	docker run -d --name tensorflow -p 6006:6006 -p 8888:8888 adolphlwq/docker-tensorflow:v1.0.0
image:
	docker build -t adolphlwq/docker-tensorflow:v0.10.0 .
run: image
	docker run -d -p 6006:6006 -p 8888:8888 --name tensorflow adolphlwq/docker-tensorflow:v0.10.0
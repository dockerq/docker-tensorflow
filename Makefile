dev-image:
		docker build -t adolphlwq/docker-tensorflow:dev-image .

prod-image:
		docker build -t adolphlwq/docker-tensorflow:dev-image .

dev: dev-image
		docker run -P adolphlwq/docker-tensorflow:dev-image

test: dev-image
		docker run -P adolphlwq/docker-tensorflow:dev-image

prod: prod-image
		docker run -P adolphlwq/docker-tensorflow:prod-image

retag: prod-image
		docker tag adolphlwq/docker-tensorflow:prod-image adolphlwq/docker-tensorflow

REPO_NAME?=balman
DB_IAMGE_VERSION?=v1
APP_IAMGE_VERSION?=v2

db-build-img:
	docker build . -f Dockerfile.pg -t $(REPO_NAME)/todolist-pg:$(DB_IAMGE_VERSION)

db-push-img:
	docker push $(REPO_NAME)/todolist-pg:$(DB_IAMGE_VERSION)

app-build-img:
	docker build . -t $(REPO_NAME)/todolist:$(APP_IAMGE_VERSION)

app-push-img:
	docker push $(REPO_NAME)/todolist:$(APP_IAMGE_VERSION)

deploy-app:
	kubectl apply -f k8s/config.yml
	kubectl apply -f k8s/db.yml
	kubectl apply -f k8s/app.yml
	@echo "Deployment Completed.."
	kubectl get service

delete-app:
	kubectl delete -f k8s/app.yml
	kubectl delete -f k8s/db.yml
	kubectl delete -f k8s/config.yml
	@echo "Delete completed.."

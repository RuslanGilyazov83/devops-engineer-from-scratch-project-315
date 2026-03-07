IMAGE_NAME ?= ruslangilyazov/project-devops-deploy
DEPLOY_TAG ?= latest

# Установка сторонних ролей из requirements.yml
ansible-requirements:
	ansible-galaxy install -r requirements.yml

# Деплой приложения на сервер
deploy:
	ansible-playbook -i inventory.ini playbook.yml -e app_image_tag=$(DEPLOY_TAG) --ask-vault-pass

# Откат к стабильной версии образа
# Передай тег нужной сборки: make rollback STABLE_TAG=<git-sha>
# Теги всех сборок видны в Docker Hub: https://hub.docker.com/r/ruslangilyazov/project-devops-deploy/tags
rollback:
	ansible-playbook -i inventory.ini playbook.yml -e app_image_tag=$(STABLE_TAG) --ask-vault-pass

.PHONY: ansible-requirements deploy rollback

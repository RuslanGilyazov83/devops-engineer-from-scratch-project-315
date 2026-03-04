IMAGE_NAME ?= ruslangilyazov/project-devops-deploy
DEPLOY_TAG ?= latest

# Установка сторонних ролей из requirements.yml
ansible-requirements:
	ansible-galaxy install -r requirements.yml

# Деплой приложения на сервер
deploy:
	ansible-playbook -i inventory.ini playbook.yml -e app_image_tag=$(DEPLOY_TAG) --ask-vault-pass

.PHONY: ansible-requirements deploy

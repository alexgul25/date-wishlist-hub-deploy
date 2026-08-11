SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -c
.DEFAULT_GOAL := help

MAKEFLAGS += --no-print-directory

SERVICES := gateway-svc notify-svc place-svc user-svc
MIGRATABLE_SERVICES := notify-svc place-svc user-svc

WORKSPACE := ..

.PHONY: help build migrate run run-only clean

help: ## Показать список доступных команд
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z0-9_-]+:.*##/ {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Собрать бинарники всех сервисов
	@for svc in $(SERVICES); do \
		$(MAKE) -C "$(WORKSPACE)/$$svc" build || exit 1; \
	done

migrate: ## Применить миграции для всех сервисов
	@for svc in $(MIGRATABLE_SERVICES); do \
		$(MAKE) -C "$(WORKSPACE)/$$svc" migrate || exit 1; \
	done

run: migrate build ## Применить миграции, собрать бинарники и запустить все сервисы
	@command -v goreman >/dev/null 2>&1 || { echo "❌ goreman не найден. Установите: go install github.com/mattn/goreman@latest"; exit 1; }
	@echo "🚀  Запуск системы..."
	goreman -f Procfile start

run-only: ## Запустить все сервисы
	@command -v goreman >/dev/null 2>&1 || { echo "❌ goreman не найден."; exit 1; }
	@echo "🚀  Запуск системы..."
	goreman -f Procfile start

clean: ## Очистить артефакты (bin/, .jwt, .user_id) во всех сервисах
	@for svc in $(SERVICES); do \
		echo "🧹  Очистка $$svc..."; \
		$(MAKE) -C "$(WORKSPACE)/$$svc" clean || exit 1; \
	done
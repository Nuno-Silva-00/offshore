STACKS = traefik ghost minecraft code dockhand pdf outline

.PHONY: up down restart ps logs update

up:
	@for stack in $(STACKS); do \
		echo "▶ Starting $$stack"; \
		docker compose -f $$stack/docker-compose.yml up -d; \
	done

down:
	@for stack in $(STACKS); do \
		echo "⏹ Stopping $$stack"; \
		docker compose -f $$stack/docker-compose.yml down; \
	done

restart:
	@for stack in $(STACKS); do \
		echo "🔁 Restarting $$stack"; \
		docker compose -f $$stack/docker-compose.yml restart; \
	done

ps:
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

logs:
	@read -p "Stack name: " stack; \
	docker compose -f $$stack/docker-compose.yml logs -f

update:
	@for stack in $(STACKS); do \
		echo "⬆ Updating $$stack"; \
		docker compose -f $$stack/docker-compose.yml pull; \
		docker compose -f $$stack/docker-compose.yml up -d; \
	done

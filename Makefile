postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path ./migrations -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

pgadmin:
	docker run -p 8082:80 -e 'PGADMIN_DEFAULT_EMAIL=dasd@dasd.com' -e 'PGADMIN_DEFAULT_PASSWORD=Secret' -d dpage/pgadmin4

migratedown:
	migrate -path ./migrations -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

.PHONY: postgres createdb dropdb pgadmin
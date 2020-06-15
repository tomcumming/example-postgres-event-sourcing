# Example eventsourcing setup with PostgreSQL an Typescript

[schema.sql](db/scripts/schema.sql) sets up the database for:

- Writing to a table like an append only log
- Basic permissions for workers

Then I can write my workers so that they only have to store their position in
the queue, and `LISTEN` for changes.

create schema if not exists events;

create table if not exists events.messages (
    id int not null primary key,
    msg text not null
);

create or replace procedure events.add_message(msg text)
language plpgsql
security definer
as $$
begin
    lock table events.messages in exclusive mode;
    insert into events.messages (id, msg) values ((select coalesce(max(id) + 1, 0) from events.messages), msg);
    notify events_messages;
end
$$;

create role worker with login password 'worker';

grant usage on schema events to worker;
grant select on all tables in schema events to worker;
grant execute on all procedures in schema events to worker;

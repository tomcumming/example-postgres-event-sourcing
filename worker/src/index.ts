import * as pg from 'pg';

async function main() {
    const client = new pg.Client({
        host: 'db',
        database: 'postgres',
        user: 'worker',
        password: 'worker'
    });
    await client.connect();

    client.query('LISTEN events_messages');
    client.on('notification', async e => {
        console.log('Messages added!');
    });

    setTimeout(
        async () => {
            await client.query(`call events.add_message('Hello World 2');`);
        },
        5000
    );
}

main();

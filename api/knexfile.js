require('dotenv').config();

module.exports = {

  development: {
    client: 'pg',
    connection: {
      database: 'insight',
      user:     'postgres',
      password: 'pG@1120256'
    },
    pool: {
      min: 2,
      max: 2
    },
    migrations: {
      directory: './data/migrations',
    },
    seeds: { directory: './data/seeds' },
  },

  staging: {
    client: 'pg',
    connection: process.env.DB_URL,
    migrations: {
      directory: './data/migrations',
    },
    seeds: { directory: './data/seeds' },
  },

  production: {
    client: 'pg',
    connection: process.env.DB_URL,
    migrations: {
      directory: './data/migrations',
    },
    seeds: { directory: './data/seeds' },
  },
};
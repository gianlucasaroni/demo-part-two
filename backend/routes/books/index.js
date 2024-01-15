'use strict'

const mock = require('../../mockdata/mockdata')

module.exports = async function (fastify, opts) {
  fastify.get('/', async function (request, reply) {
    return mock.books;
  })
}

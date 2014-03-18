irc = require('irc')
Mock = require('./mockCS')

class MockIrcClient extends Mock
  constructor: () ->
    super(irc.Client::)

module.exports = MockIrcClient

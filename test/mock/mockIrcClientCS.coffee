irc = require 'irc'
Mock = require './mockCS'

# A mock implementation of the irc.Client class.
class MockIrcClient extends Mock
    constructor: () ->
        super(irc.Client::)

module.exports = MockIrcClient

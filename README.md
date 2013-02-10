NexBot
======

Node.js IRC bot

## Install and Setup

Install Node.JS
```bash
git clone https://github.com/joyent/node
cd node
./configure
make
make install
```

Install the required packages for NexBot
```bash
npm install irc lastfm bitly
```

Setup the database.
```bash
mysql -u <user> -p <database> < db.sql
```

Edit the data/config.js file to match your details.


## Usage
* !last.fm - Output the last listened track from last.fm
* !last.fm foobar - Will get the last track listened to by the user "foobar"
* !last.fm set user foo - Will map the IRC nick to the Last.fm user "foo"
* !groove - Output the last listened track from last.fm in the form of a grooveshark URL.
* !groove foo - Will get the first result from Grooveshark which matches "foo"
* !remember foo | !save foo | !note foo - Will add "foo" to the database
* s/foo/bar - Last line you wrote will replace "foo" with "bar"
* s/foo/bar/user - Last line written by "user" will replace "foo" with "bar"

### Private messaging the bot
* !remember | !save | !note - Output all records.

Packages
---------
* node-irc https://github.com/martynsmith/node-irc
* lastfm-node https://github.com/jammus/lastfm-node
* node-bitly https://github.com/tanepiper/node-bitly

Install them via npm using:
```bash
npm install irc lastfm bitly
```

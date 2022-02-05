// load env vars from .env file
require('dotenv').config({path: require('path').resolve('.sf-env')});

// load jsforce module
const jsforce = require('jsforce');

// make a connection to salesforce
const conn = new jsforce.Connection();
conn.login(process.env.SF_USERNAME, process.env.SF_PASSWORD, function(err, res) {
  if (err) { return console.error(err); }

  console.log('Listening for AccountUpdate__e events...');

  conn.streaming.topic("/event/AccountUpdate__e").subscribe(function(message) {
      console.log(message);
    const { payload: { AccountNotification__c } }  = message;
    console.log(AccountNotification__c);
  });
});
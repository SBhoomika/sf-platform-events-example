# Salesforce Platform Events (an example)

- This is a trivial (not production ready) example of how we can create and subscribe to Saleforce Platform Events in external systems.
- Platform events if used properly can offer a scalable enterprise solution to keep other systems updated with Salesforce in near real-time.
- This example is trivial in many aspects but one that stands out in the context is the handling of `replayId`. We should track the `replayId` in production systems in case of subscriber failures/ network failures.
- Please watch this repo for updates as I improve the example with more scenarios that mimic production.

## Runnning the example

Please clone the repo :)

There are two folders in the repo root:

- `sf-org` - This contains the SFDX project with necessary metadata:
  - `AccountTrigger` that captures `after update` on `Account` and `AccounTriggerHandler` publishes `AccountUpdate__e` platform event.
- `mock-subscriber` - This is a mock external system written in `node.js` and uses `jsforce` library to make a connection to Salesfoce, listen to Platform events via CometD.

### sf-org

> Note: following steps are easier with using VSCode Salesforce Extension Pack

- `cd ../sf-org`
- Make sure you have SFDX installed on your computer
- [Authorize your org](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_auth_web_flow.htm)
- Deploy the metadata in `package.xml` using - `sfdx force:source:deploy -x path/to/package.xml`
  
### mock-subscriber

> Please make sure you have [node.js installed](https://nodejs.org/en/download/)

- `cd ../mock-subscriber`
- `npm install`
- Update your salesforce credentials in `.sf-env` file. Append security token to password.
- `npm start`

### Simulation

- Login to your org
- Update one or more accounts
- Notice the terminal where you are running mock subscriber, you will receive the Platform event messages.

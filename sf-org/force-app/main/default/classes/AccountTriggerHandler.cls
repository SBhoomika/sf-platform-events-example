public without sharing class AccountTriggerHandler extends TriggerHandler{

    private Map<Id, Account> newAccountMap;
    private List<Account> newAccountList;


    public AccountTriggerHandler() {
        this.newAccountMap = (Map<Id, Account>) Trigger.newMap;
        this.newAccountList = (List<Account>) Trigger.new;
    }

    public override void afterUpdate() {
        List<AccountUpdate__E> accountNotificationEvents = new List<AccountUpdate__E>();
        for(Account acc : this.newAccountList) {

            accountNotificationEvents.add(new AccountUpdate__E(AccountNotification__c = 'Account ' + acc.name + ' Updated'));
        }

        // Call method to publish events
        List<Database.SaveResult> results = EventBus.publish(accountNotificationEvents);

        // Inspect publishing result for each event
        for (Database.SaveResult sr : results) {
            if (sr.isSuccess()) {
                System.debug('Successfully published event.');
            } else {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('Error returned: ' +
                                err.getStatusCode() +
                                ' - ' +
                                err.getMessage());
                }
            }       
        }
    }
}
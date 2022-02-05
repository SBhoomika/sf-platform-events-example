trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete) {
    new AccountTriggerHandler().run();
}
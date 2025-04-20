public class librarylogin {
    @AuraEnabled(cacheable=true)
    public static List<Book__c> testBooks() {
        return [SELECT Id, Name, Book_Name__c, Author__c FROM Book__c LIMIT 10];
    }
}
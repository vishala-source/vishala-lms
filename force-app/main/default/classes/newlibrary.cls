public without sharing class newlibrary {
    @AuraEnabled(cacheable=true)
    public static List<Book__c> getFilesForRecord() {
        try {
            // Query all books related to the given record
            List<Book__c> books = [SELECT Id, Name FROM Book__c];
            return books;
        } catch (Exception e) {
            System.debug('Error fetching books: ' + e.getMessage());
            return new List<Book__c>();
        }
    }

}
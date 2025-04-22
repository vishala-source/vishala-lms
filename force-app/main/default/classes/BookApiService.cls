public with sharing class BookApiService {

    public class BookInfo {
        public String title;
        public String authors;
    }

    public static BookInfo getBookByISBN(String isbn) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.googleapis.com/books/v1/volumes?q=isbn:' + isbn);
        request.setMethod('GET');

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            // Log full response for debugging
            System.debug('API Response: ' + response.getBody());

            Map<String, Object> jsonResp = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            if (jsonResp.containsKey('items')) {
                List<Object> items = (List<Object>) jsonResp.get('items');

                if (!items.isEmpty()) {
                    Map<String, Object> volumeInfo = (Map<String, Object>) ((Map<String, Object>)items[0]).get('volumeInfo');

                    if (volumeInfo != null) {
                        BookInfo book = new BookInfo();
                        book.title = (String) volumeInfo.get('title');
                        book.authors = String.valueOf(volumeInfo.get('authors'));
                        return book;
                    }
                }
            }

            // If no book data was found
            System.debug('No book data found for ISBN: ' + isbn);
            return null;
        } else {
            System.debug('HTTP Error: ' + response.getStatusCode());
            return null;
        }
    }
}

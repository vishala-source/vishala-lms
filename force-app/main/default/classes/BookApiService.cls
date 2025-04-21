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
            // Parse JSON response
            Map<String, Object> jsonResp = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> items = (List<Object>) jsonResp.get('items');

            if (items != null && items.size() > 0) {
                Map<String, Object> volumeInfo = (Map<String, Object>) ((Map<String, Object>)items[0]).get('volumeInfo');
                BookInfo book = new BookInfo();
                book.title = (String) volumeInfo.get('title');
                book.authors = String.valueOf(volumeInfo.get('authors'));
                return book;
            }
        }
        return null;
    }
}

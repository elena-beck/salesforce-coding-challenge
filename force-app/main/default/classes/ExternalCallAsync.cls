public class ExternalCallAsync
{
     // TODO:define basic information for later, store these in a protected custom setting
     private static string endpoint = 'https://salesforce-coding-challenge.herokuapp.com/orders';
     private static string username = 'tmondo';
     private static string password = 'Noy84LRpYvMZuETB';
     private static string method = 'POST';
     public static List<String> outcomeMsg = new List<String>();

     @future(callout=true)
     public static void doRequest(String description){

         // TODO:check for credentials error
         System.debug('I am creating the post request');
         String message = '';

          // define transaction variables
         HttpRequest req = new HttpRequest();
         HttpResponse res = new HttpResponse();
         Http h = new Http();

         // Configure the request
         req.setEndpoint(endpoint);
         req.setMethod(method);
         req.setTimeout(120000);

         Blob headerValue = Blob.valueOf(username + ':' + password);
         String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
         req.setHeader('Authorization', authorizationHeader);

         // Configure standard headers
         req.setHeader('Accept', '*/*');
         req.setHeader('Content-Type', 'application/json');

         req.setBody(description);

         // Perform callout and set response
         res = h.send(req);

         // check response
         if ((res.getStatusCode() == 200) && res.getBody() != null) {
             System.debug('Response+++' + res.getBody());
             System.debug('Header+++' + res);


             if (res.getBody()=='SUCCESS') {
                 message = 'Success!!!';
             } else {
                 message ='Error: Verify key not found in response';
             }
         } else {
         // callout failed
             message = 'Error: Callout failed. Please review the debug log for additional details.';
         }
         outcomeMsg.add(message);
     }
}
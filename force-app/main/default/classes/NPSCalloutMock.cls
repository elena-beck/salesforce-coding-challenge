@isTest
global class NPSCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        System.assertEquals('https://salesforce-coding-challenge.herokuapp.com/orders', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status":"SUCCESS"}');
        res.setStatusCode(200);
        return res;
    }
}
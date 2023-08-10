public with sharing class NPSCall {

    @InvocableMethod(label ='NPS API call' description='sends the data to the NPS API')
        public static List<String> executeCall(List<String> orderIds){
        String message = '';
        String description = buildDescription(orderIds);

        // check to ensure a callout can be performed using the Limits class.
        if (Limits.getCallouts() >= Limits.getLimitCallouts()) {
            message ='Maximum number of callouts has been reached.';
        } else {
            try {
                ExternalCallAsync.doRequest(description);
                message = '' + ExternalCallAsync.outcomeMsg;
            } catch(Exception e) {
                message ='Error: An exception has been encountered while calling out to Integration:  ' + e.getMessage();
            }
        }
        return new List<String>{message};
    }

    public static String buildDescription(List<String> orderIds) {
        List<Map<String, String>> data = new List<Map<String, String>>();
        //TODO: if email is empty, try to get email over contract.
        for (Order order: [SELECT Id,OrderNumber,AccountId FROM Order WHERE Id IN :orderIds]) {
            String email = [SELECT Email FROM Contact WHERE AccountId = :order.AccountId].Email;
            Map<String, String> dataMap = new Map<String, String>();
            dataMap.put('sfId', order.Id);
            dataMap.put('orderNumber', order.orderNumber);
            dataMap.put('customerEmail',email);
            data.add(dataMap);
        }

        String description = JSON.serialize(data);
        return description;
    }
}
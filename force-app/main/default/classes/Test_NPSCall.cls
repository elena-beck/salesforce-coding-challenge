@IsTest
private class Test_NPSCall {
  @IsTest
  private static void testSendOrders() {
    Test.setMock(HttpCalloutMock.class, new NPSCalloutMock());
    List<String> ordersId = new List<String>{'8017Y000002bWxjQAE','8017Y000002bWxtQAE'};

    Test.startTest();
      List<String> outcome = NPSCall.executeCall(ordersId);
    Test.stopTest();

    System.assertEquals('SUCCESS', outcome + '');
  }

  @IsTest
  private static void testSendOrdersFuture() {
    Test.setMock(HttpCalloutMock.class, new NPSCalloutMock());
    String description = '[{"sfId": "8017Y000002bWxjQAE","orderNumber": "00000100","customerEmail": "elena.beck@gmx.de"}]';
    String message =  ExternalCallAsync.outcomeMsg + '';

    Test.startTest();
      ExternalCallAsync.doRequest(description);
    Test.stopTest();

    System.assertEquals('SUCCESS', message);
  }
}
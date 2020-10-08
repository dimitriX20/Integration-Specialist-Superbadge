global class BillingCalloutServiceMockFailure implements WebServiceMock {
    global void doInvoke ( Object stub,
                          Object request,
                          Map<String, Object> response,
                          String endpoint,
                          String soapAction,
                          String requestName,
                          String responseNS,
                          String responseName,
                          String responseType){
                              BillingServiceProxy.billProjectResponse_element El = new BillingServiceProxy.billProjectResponse_element();
                              El.status = 'ERROR';
                              response.put('response' , El);
                          }   
}

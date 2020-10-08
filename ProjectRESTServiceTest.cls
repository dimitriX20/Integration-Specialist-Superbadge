@isTest
private class ProjectRESTServiceTest {
    
    @TestSetup
    static void createRecs(){
        Opportunity opp = new Opportunity();
        opp.StageName= 'Submitted Project';
        opp.Name = 'Test Opp';
        opp.CloseDate = Date.today();
        insert opp;
        
        
    }
    
    @isTest static void positiveResult(){
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/project/';
        request.httpMethod = 'POST';
        RestContext.request = request;  
        Opportunity OP = [SELECT Id FROM Opportunity WHERE Name = 'Test Opp'];
        
        String Res = ProjectRESTService.postProjectData('2131231345', 'TestPr', Op.Id, Date.today(), Date.today().addDays(2), 123, 'Running');
        Project__c pro = [SELECT ProjectRef__c , Name FROM Project__c WHERE Opportunity__c =: Op.ID ];
        System.assertEquals('2131231345', pro.ProjectRef__c);
        System.assertEquals('OK', Res);
        
        
    }
    
    @isTest static void negativeResult(){
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/project/';
        request.httpMethod = 'POST';
        RestContext.request = request;  
        String Res = ProjectRESTService.postProjectData('2131231345', 'TestPr', '2', Date.today(), Date.today().addDays(2), 123, 'Running');
        
        System.assertEquals('2', Res);  
    }   
}

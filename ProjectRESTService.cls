@RestResource(urlMapping='/project/*')
global with sharing class ProjectRESTService {
    
    private static final String SUCCESS = 'OK';
    
    @HttpPost
    global static String postProjectData(String ProjectRef, String ProjectName, String OpportunityId, Date StartDate, Date EndDate, Double Amount, String Status) {
        
        Savepoint Save = Database.setSavepoint();
        
        try {
            Project__c p = new Project__c(Name=ProjectName,
                                          Opportunity__c=OpportunityId,
                                          ProjectRef__c=ProjectRef,
                                          Start_Date__c=StartDate,
                                          End_Date__c=EndDate,
                                          Billable_Amount__c=Amount,
                                          Status__c=Status);
            
            // projectRef is the External Id
            upsert p ProjectRef__c;
            
            Opportunity oppo = [SELECT DeliveryInstallationStatus__c FROM Opportunity WHERE Id = :OpportunityId]; 
            oppo.DeliveryInstallationStatus__c = 'In Progress';
            update oppo;
            
            return SUCCESS;
        } catch (Exception error) {
            Database.rollback(Save);
            return error.getMessage();
        }
    }
}

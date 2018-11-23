public class TDF_Batch implements Database.Batchable<Account>, Database.Stateful{
 	
    private Integer recordsProcessed = 0;

    public Iterable<Account> start(Database.BatchableContext info){ 
        System.debug('START');
        List<Account> accL = TDF_4Alex.createAccList(1000);
        system.debug('*** accL' + accL);
        return accL; 
   }
    
    public void execute(Database.batchableContext info, List<Account> accL){ 
        System.debug('EXECUTE');
        recordsProcessed = recordsProcessed + accL.size();
        System.debug('*** recordsProcessed: ' + recordsProcessed);
        insert accL;	 
   } 
    
    public void finish(Database.BatchableContext bc){
        System.debug('FINISH');
        System.debug('*** recordsProcessed: ' + recordsProcessed);
        if(recordsProcessed < 5000){
            TDF_Batch batch = new TDF_Batch(); 
			Id batchId = Database.executeBatch(batch, 100); 
        } 
        
    }
}
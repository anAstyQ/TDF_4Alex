public class TDF_4Alex {
	private final Integer accNumber = 1000;
    private final Integer oppNumber = 1000;
       
 /*   public static void mainCreator(String sObj, List<String> accIdList){
        if(sObj.toLowerCase() == 'account'){
            TDF_Batch myBatchObject = new TDF_Batch(); 
			Id batchId = Database.executeBatch(myBatchObject, 100);
        } else if(sObj.toLowerCase() == 'opportunity'){
            
        }
    }*/

    public static void mainCreator(String sObj, List<String> accIdList, Integer num){
      String result;
      if(sObj.toLowerCase() == 'account'){
            result = insertAccs(num);
            System.debug(result);
        } else if(sObj.toLowerCase() == 'opportunity'){
            result = insertOpps(num, accIdList);
            System.debug(result);
        }
    }

    public static String insertAccs(Integer num){
        String result;
        List<Account> accL = createAccList(num);
        try{
            insert accL;
            result = 'done!';
        }catch(DMLException e){
            result = 'some ERROR occured inserting Accounts: ' + e.getMessage();
        }
        System.debug(result);
        return result;
    }

    public static String insertOpps(Integer num, List<String> accIdList){
        String result;
        List<Opportunity> oppL = createOppList(num, accIdList);
        try{
            insert oppL;
            result = 'done!';
        }catch(DMLException e){
            result = 'some ERROR occured inserting Opportunities: ' + e.getMessage();
        }
        return result;
    }

    public static List<Account> createAccList(Integer num){
        List<Account> accountL = new List<Account>();
        Account acc = new Account();
        
        List<String> AccountSourceVal = Randomizer.getPickListValues1(acc, 'AccountSource', false);
        List<String> IndustryVal = Randomizer.getPickListValues1(acc, 'Industry', false);
        List<String> OwnershipVal = Randomizer.getPickListValues1(acc, 'Ownership', false);
        List<String> RatingVal = Randomizer.getPickListValues1(acc, 'Rating', false);
        
        if(num <= 10000){
            for(Integer i = 0; i < num; i++){
                acc = createAcc(i, AccountSourceVal, IndustryVal, OwnershipVal, RatingVal);
                accountL.add(acc);
            }
        }
        return accountL;        
    }
    
    public static List<Opportunity> createOppList(Integer num, List<String> accIdList){
        List<Opportunity> oppL = new List<Opportunity>();
        Opportunity opp = new Opportunity();
        
        List<String> typeVal = Randomizer.getPickListValues1(opp, 'Type', false);
        List<String> leadSourceVal = Randomizer.getPickListValues1(opp, 'LeadSource', false);
        List<String> stageNameVal = Randomizer.getPickListValues1(opp, 'StageName', false);
        
        if(num <= 10000){
            for(Integer i = 0; i < num; i++){
                opp = createOpp(i,typeVal, leadSourceVal, stageNameVal, accIdList);
                oppL.add(opp);			
            }
        }
        return oppL;        
    }
     /*i'm not sure what fields are standart. 
     Thare is a difference from org to org. 
     For recent Scratch Org some of fields were called custom and not available. 
     So it's up to u, to make it visible or not. 
     U can also change fields and fill it with neended data with help of Randomizer.Class and String methods get...().*/
	
    public static Opportunity createOpp(Integer index, List<String> typeVal, List<String> leadSourceVal, List<String> stageNameVal, List<String> accIdL){
        Opportunity opp = new Opportunity();
        opp.Amount = Randomizer.getRandomNumber(10000000);
        opp.CloseDate = Date.today().addDays(Randomizer.getRandomNumber(250));        
        opp.Type = Randomizer.getRandomString(typeVal);
        opp.LeadSource = Randomizer.getRandomString(leadSourceVal);
        opp.StageName = Randomizer.getRandomString(stageNameVal);
        
        //opp.DeliveryInstallationStatus__c = Randomizer.getRandomPickListValue(opp, 'DeliveryInstallationStatus__c', false);
        opp.Name = String.valueOf(getOppName() + ' ' + index);
        opp.Probability = Randomizer.getRandomNumber(100);
        //opp.TrackingNumber__c = String.valueOf(Randomizer.getRandomNumber(100000));
        //opp.OrderNumber__c = String.valueOf(Randomizer.getRandomNumber(10000000));
        //opp.CurrentGenerators__c = getOppManagerName();
        //opp.MainCompetitors__c = getOppManagerName(); 
        if(accIdL != null){
            if(accIdL.size() > 0){
                opp.AccountId = Randomizer.getRandomString(accIdL);
            }
        }
        
        return opp;
    }

   
     public static Account createAcc(Integer index, List<String> AccountSourceVal, List<String> IndustryVal, List<String> OwnershipVal, List<String> RatingVal){
         /**/
        Account acc = new Account();
        acc.Name = getName() + ' ' + index;
        acc.AccountSource = Randomizer.getRandomString(AccountSourceVal);
        //acc.Active__c = Randomizer.getRandomPickListValue(acc, 'Active__c', false);
        acc.AnnualRevenue = Randomizer.getRandomNumber(100000000);
        //acc.BillingCity = getCity();
        //acc.BillingCountry = 'USA';
        //acc.CustomerPriority__c = Randomizer.getRandomPickListValue(acc, 'CustomerPriority__c', false);
        acc.NumberOfEmployees = Randomizer.getRandomNumber(15000) ;
        //acc.NumberofLocations__c = Randomizer.getRandomNumber(10);
        acc.Industry = Randomizer.getRandomString(IndustryVal);
        acc.Ownership = Randomizer.getRandomString(OwnershipVal); 
        acc.Phone = index + '-' + 2*index;
        acc.Rating = Randomizer.getRandomString(RatingVal);
        acc.ShippingCity = getCity();
        acc.ShippingCountry = 'USA';
        //acc.SLA__c = Randomizer.getRandomPickListValue(acc, 'SLA__c', false);
        //acc.SLAExpirationDate__c = Date.today().addDays(Randomizer.getRandomNumber(100));
        //acc.SLASerialNumber__c = '02FBI' + Randomizer.getRandomNumber(100) + '69'; 
        //acc.Type = Randomizer.getRandomPickListValue(acc, 'Type', false);
        //acc.UpsellOpportunity__c = Randomizer.getRandomPickListValue(acc, 'UpsellOpportunity__c', false);
        Integer year = Date.today().year() - Randomizer.getRandomNumber(10);
        acc.YearStarted = String.valueOf(year);
         
        return acc;
    }
    
    private static String getOppName(){
        List<String> namesList = new List<String>();
            namesList.add('Uncommon Opportunity');
            namesList.add('Competitive Opportunity');
            namesList.add('GreenLight Opportunity');
            namesList.add('Route Opportunity');
            namesList.add('Opportunity Rewards');
            namesList.add('Bold Opportunity');
            namesList.add('Insta Opportunity');
            namesList.add('Opportunity Shield');
            namesList.add('Millennial Opportunity');
            namesList.add('Crossover Opportunity');
            namesList.add('Intuition Opportunity');
            namesList.add('Opportunity Wave');
            namesList.add('Pepper Opportunity');
            namesList.add('BlackBox Opportunity');
        
        return Randomizer.getRandomString(namesList);
    }
    
    private static String getOppManagerName(){
        List<String> namesList = new List<String>();
            namesList.add('John Deere');
            namesList.add('Charles R. Shelton');
            namesList.add('Christine A. Tobin');
            namesList.add('Herman B. Kim');
            namesList.add('Lucy A. Phillips');
            namesList.add('Victor S. West');
            namesList.add('Jason F. Juarez');
            namesList.add('Sharon D. Alexander');
            namesList.add('Edgar T. Grossman');
            namesList.add('Susan L. Sandoval');
            namesList.add('James C. Henry');
            namesList.add('Leatha F. Gonzales');
            namesList.add('Joseph T. Harkey');
            namesList.add('Lillie S. Warner');
        
        return Randomizer.getRandomString(namesList);
    }
    
    private static String getName(){
        List<String> namesList = new List<String>();
            namesList.add('Bulb Hunters');
            namesList.add('Bulb Bulb Wish');
            namesList.add('Reaction Bulb');
            namesList.add('Bulb Glory');
            namesList.add('Ultra Bulb');
            namesList.add('Miracle Bulb');
            namesList.add('Planetary Bulb');
            namesList.add('Obsidian Bulb');
            namesList.add('Yellow Bulb');
            namesList.add('TrueBlue Bulb');
            namesList.add('Valencia Bulb');
            namesList.add('Verve Bulb');
            namesList.add('Praxis Bulb');
            namesList.add('Liberation Bulb');
        
        return Randomizer.getRandomString(namesList);
    }
    
    private static String getCity(){
        List<String> city = new List<String>();
        	city.add('NY');
        	city.add('LA');
        	city.add('Chicago');
        	city.add('San Diego');
        	city.add('Houston');
        	city.add('Phoenix');
        	city.add('Philadelphia');
        	city.add('San Antonio');
        	city.add('Dallas');
        	city.add('San Jose');
        	city.add('Austin');
        	city.add('Jacksonville');
        	city.add('Denver');
        	city.add('Boston');
        	city.add('Washington');
        	city.add('Oklahoma City');
        
        return Randomizer.getRandomString(city);
    }    
	/*
	Best Wishes for grandpa, 
	Nasty Nastya :)
	*/
}

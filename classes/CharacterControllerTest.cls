@isTest 
public class CharacterControllerTest {
    private static Integer NUM_RECORDS = 30;
    
    public static CharacterController ccInit() {
        //
        PageReference pageRef = Page.Characters;
        
        Test.setCurrentPage(pageRef);
        
        CharacterController cc = new CharacterController();
        
        //
        //String nextPage = cc.save().getUrl();
        //System.assertEquals('', nextPage);
        
        return cc;
    }
    
    //-------------------------Test Methods--------------------------
    static testMethod void animalInsertion() {
        CharacterController cc = ccInit();
        
        String animalNickname = 'Fox';
        String animalType = 'Red';
        
        Animal__c testAnimal = AnimalFactory.buildAnimal(animalNickname, animalType);
        insert testAnimal;
        
        Set<Id> animalIds = new Set<Id>();
        animalIds.add(testAnimal.Id);
   
        //test.startTest();
        Animal__c retrieveAnimal = [SELECT Nickname__c, Type__c 
                                    FROM Animal__c
                                    WHERE Id IN :animalIds];
        
        System.assertEquals(retrieveAnimal.Nickname__c, animalNickname);
        System.assertEquals(retrieveAnimal.Type__c, animalType);
        
        //test.stopTest();
    }
    
    static testMethod void animalInsertionBulk() {
        CharacterController cc = ccInit();
        
        List<String> typeStrings = new String[3];
        typeStrings[0] = 'Hound';
        typeStrings[1] = 'Mother';
        typeStrings[2] = 'Red';
        
        List<Animal__c> animals = new List<Animal__c>();
                
        Set<Id> animalIds = new Set<Id>();
        for(Integer i=0; i<NUM_RECORDS; ++i) {
            Integer mod = math.mod(i,3);
            Animal__c anim = AnimalFactory.buildAnimal('test' + i, typeStrings[mod]);
            animalIds.add(anim.Id);
            animals.add(anim);
        }
        insert animals;
        
        List<Animal__c> retrieveAnimals = new List<Animal__c>();
        retrieveAnimals = [SELECT Nickname__c, Type__c 
                            FROM Animal__c
                            WHERE Id IN :animalIds
                            ORDER BY Type__c ASC];
                
        Integer i = 0;                  
        for(Animal__c anim : retrieveAnimals) {
            Integer index = (i<(NUM_RECORDS*1/3) ? 0 : 
                            i<(NUM_RECORDS*2/3) ? 1 : 2);
            System.assertEquals(anim.Type__c, typeStrings[index]);
            ++i;
        }
    }
    
    static testMethod void sometest() {
        CharacterController cc = ccInit();
        
        String characterNickname = 'TheFox';
        String animalNickname = 'Fox';
        String animalType = 'Red';
        Animal__c testAnimal = AnimalFactory.buildAnimal(animalNickname, animalType);
        insert testAnimal;  //testAnimal needs to be in object for reference lookup to work
        Character__c testCharacter = CharacterFactory.buildCharacter(characterNickname, testAnimal.Id);
        
        Set<Id> charIds = new Set<Id>();
        charIds.add(cc.newCharacter.Id);
        
        cc.newCharacter.Nickname__c = testCharacter.Nickname__c;
        cc.newCharacter.AnimalFieldName__c = testCharacter.AnimalFieldName__c;
        
        cc.addCharacter();
        System.assertNotEquals(testCharacter.Nickname__c, cc.newCharacter.Nickname__c); //New newCharacter set
        System.assertEquals(cc.getHasCharacters(), true);
        
        Character__c retrieveCharacter = [SELECT Nickname__c, AnimalFieldName__r.Nickname__c, AnimalFieldName__r.Type__c
                                            FROM Character__c 
                                            //WHERE Id IN :charIds];
                                            ];
        System.assertEquals(retrieveCharacter.Nickname__c, characterNickname);
        System.assertEquals(retrieveCharacter.AnimalFieldName__r.Nickname__c, animalNickname);
        System.assertEquals(retrieveCharacter.AnimalFieldName__r.Type__c, animalType);
    }
}
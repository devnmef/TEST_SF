public class CharacterController 
{	
    public List<Character__c> characters{get; set;}
    public Character__c newCharacter{get; set;}
    public Animal__c knownAnimals{get; set;}
    
    public CharacterController()
    {
        Boolean thing = true;
        selectCharacters();
        //selectAnimals();
        
        newCharacter = new Character__c();
    }
    
    public PageReference addCharacter()
    {
        insert newCharacter;
        newCharacter = new Character__c();
        
        selectCharacters();
        return null;
    }
   /* public PageReference save() 
    {
        for(Character__c character : characters) {
            
        }
        return null;   
    }*/
    
    public void selectCharacters()
    {
        characters = [SELECT id, Nickname__c, AnimalFieldName__c, AnimalFieldName__r.Nickname__c, AnimalFieldName__r.Type__c
                     FROM Character__c];
    }
    /*public void selectAnimals()
    {
        knownAnimals = [SELECT id, Name, Type__c
                  		FROM Animal__c];
    }*/
    
    public Boolean getHasCharacters() 
    {
        selectCharacters();
        return !characters.isEmpty();
    }
}
@isTest 
public class CharacterFactory {
	public static Character__c buildCharacter(String charNickname, String animFieldName) {
		Character__c result = new Character__c();
		result.Nickname__c = charNickname;
		result.AnimalFieldName__c = animFieldName;
		
		return result;
	}
}
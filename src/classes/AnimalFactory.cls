@isTest
public class AnimalFactory {
	public static Animal__c buildAnimal(String animalNickname, String animalType) {
		Animal__c result = new Animal__c();
		result.Nickname__c = animalNickname;
		result.Type__c = animalType;
		
		return result;
	}
}
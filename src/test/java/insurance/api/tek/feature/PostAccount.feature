
@Regression
Feature: TEK Insurance POST api

  Background:
    Given url 'https://qa.insurance-api.tekschool-students.com'
    * def tokenGenerator = call read('GenerateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue

    Scenario: POST an Account - Primary Person
      * def generator = Java.type('insurance.api.tek.Utility.DataGenerator')
      * def email = generator.getEmail()
      * def firstName = generator.getFirstName()
      * def lastName = generator.getLastName()
      * def title = generator.getTitle()
      * def gender = generator.getGender()
      * def employmentStatus = generator.getEmploymentStatus()
      * def maritalStatus = generator.getMaritalStatus()
      * def dateOfBirth = generator.getDateOfBirth()
      * path '/api/accounts/add-primary-account'
      * request
      """
      {
  "id": 0,
  "email": "#(email)",
  "firstName": "#(firstName)",
  "lastName": "#(lastName)",
  "title": "#(title)",
  "gender": "#(gender)",
  "maritalStatus": "#(maritalStatus)",
  "employmentStatus": "#(employmentStatus)",
  "dateOfBirth": "#(dateOfBirth)",
  "new": true
   }
      """
      * method post
      * status 201
      * print response

      #this line of the code will store the JSON response into a json file for reusability
      * karate.write(response, 'createdAccount.json')

      @postPhone
      Scenario: Add Phone for the person
     * def generator = Java.type('insurance.api.tek.Utility.DataGenerator')
        * def primaryPersonIdValue = read('file:./target/createdAccount.json')
        * def phoneNumber = generator.getPhoneNumber()
        * def Extension = generator.getExtension()
        * def PhoneType = generator.getPhoneType()
        * param primaryPersonId = primaryPersonIdValue.id
        * path '/api/accounts/add-account-phone'
       # * param primaryPersonId = 3662

        * request
        """
        {
  "phoneNumber": "#(phoneNumber)",
  "phoneExtension": "#(extension)",
  "phoneTime": "anytime ",
  "phoneType": "#(phoneType)"
}
        """
        * method post
        * status 201
        * print response
        * def phoneId = response.id
        * print phoneId

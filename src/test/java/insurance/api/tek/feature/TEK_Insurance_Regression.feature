Feature: TEK Insurance Regression Suite


  Background:
    Given url appURL
    * def tokenGenerator = callonce read('GenerateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue




    #Scenario: Post an account
   #Scenario : post a car
  # scenario : update  the car
  # scenario : delete the care

  Scenario: post an Account - Primary Account
    * def primaryPersonIdValue = read('file:./target/createdAccount.json')
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
    * match response.email == email
    * print response
    * karate.write(response, 'RegressionCreatedAccount.json')


    Scenario: Post a car
      * path '/api/accounts/add-account-car'
      * def primaryPersonIdValue = read('file:./target/RegressionCreatedAccount.json')
      * def primaryPersonId = primaryPersonIdValue.id
      * request
      """
      {
  "make": "BMW",
  "model": "XM",
  "year": "2024",
  "licensePlate": "Raptors2024"
}
      """

      * method post
      * status 201
      * print response
      * match response.licensePlat == 'Raptors2024'






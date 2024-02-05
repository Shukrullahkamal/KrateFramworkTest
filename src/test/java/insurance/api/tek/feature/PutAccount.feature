Feature: TEK Insurance PUT Account api


  Background:
    Given url appURL
    * def tokenGenerator = call read('GenerateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue



    Scenario: Put API- Update phone number primary person
      * path 'api/accounts/update-account-phone'
      * def primaryPersonIdValue = read('file:./target/createdAccount.json')
      * param primaryPersonId = primaryPersonIdValue.id
      * def phoneIdExtraction = call read('PostAccount.feature@postPhone')
      * def PhoneIdValue = phoneIdExtraction.phoneId
      * print PhoneIdValue
      * request
      """
      {
  "id": #(PhoneIdValue),
  "phoneNumber": "8989898989",
  "phoneExtension": "001",
  "phoneTime": "Morning",
  "phoneType": "CellPhone"
}

      """
      * method put
      * status 200
      * print response


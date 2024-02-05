
@Regression
Feature: Generate Access Token for TEK Insurance Application

  
  #url we pass base url
  #path we pass th endpoint of service
  #request we pass json body POST and PUT method
  #method we pass HTTP/HTTPS method the (GET,POST,PUT,DELETE)
  #status validation the response status cod expected response code
  #print used for printing  the response fo variable into console
  # response this keyword prints API Response.
  Background:
    Given url appURL

  @GenerateToken
  Scenario: Generate Token
    
    * path '/api/token'
    * request {"username":"supervisor","password":"tek_supervisor"}
    * method post
    * status 200
    * print  response
    * def tokenValue = response.token
    * print tokenValue


    Scenario: Verify Token
      * path '/api/token/verify'
      * def tokenGenerator = call read('GenerateToken.feature@GenerateToken')
      * def userValue = tokenGenerator.response.username
      * def getTokenValue = tokenGenerator.response.token
      * param username = userValue
      * param token = getTokenValue
      * method get
      * status 200
      * print response

      Scenario: Generate My Account Token
        * path '/api/token'
        * request {"username":"ahmadkamal","password":"09Fw11098"}
        * method post
        * status 200
        * print response
        * def ValueToken = response.token
        * print response







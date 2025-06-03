# Random Data Generator API

This API provides various endpoints to generate random data, useful for testing, mocking, or just for fun! It's built with Ruby on Rails and utilizes the faker gem for data generation.

----

## Table of Contents
* [Features](#features)
* [Technologies Used](#technologies-used)
* [Getting Started](#getting-started)
    * [Prerequisites](#prerequisites)
    * [Setup](#setup)
    * [Database Setup](#database-setup)
    * [Running the API](#running-the-api)
* [API Endpoints](#api-endpoints)
  * [Authentication](#authentication)
  * [Random Data Generation](#random-data-generation)
  * [Error Simulation](#error-simulation)
* [Testing the API with Postman](#testing-the-api-with-postman)
* [Contributing](#contributing)
* [License](#license)

----

## Features
* **Diverse Data Generation**: Generate random numbers, strings, names, addresses, dates, emails, UUIDs, quotes, credit card numbers, phone numbers, bank account details, product information, company details, images, and Lorem Ipsum words/sentences.
* **Parameter Control**: Most endpoints support parameters to control the generated data (e.g., number range, string length, date range, quote category).
* **API Versioning**: All endpoints are under /api/v1/ for future extensibility.
* **Token-Based Authentication (JWT)**: Secure endpoints requiring a valid JSON Web Token.
* **Error & Delay Simulation**: An endpoint to simulate HTTP error codes and network delays for robust client testing.

----

## Technologies Used
* **Ruby**: 3.3.x (or latest stable version)
* **Rails**: ~> 7.1 (or latest stable version)
* **Faker Gem**: For generating diverse random data.
* **BCrypt Gem**: For secure password hashing.
* **JWT Gem**: For JSON Web Token authentication.
* **SQLite3**: Default database for development.

----

## Getting Started

Follow these steps to get the API up and running on your local machine.

### Prerequisites
* Ruby: Install Ruby
* Rails: gem install rails
* Bundler: gem install bundler
* Git: Install Git
#### Setup
* Clone the repository:
```bash
git clone https://github.com/stkossman/random-data-api.git
cd random-data-api
```
* Install dependencies:
```bash
bundle install
```
* Configure JWT Secret key:
  For development, you can set the JWT_SECRET_KEY environment variable. Create a .env file in your project root
```bash
# .env
JWT_SECRET_KEY=your_super_secret_jwt_key_for_development
```
For production, you should manage this securely via config/credentials.yml.enc or your hosting provider's environment variables.

### Database Setup
This project uses SQLite3 by default, so no external database server is required for development.
* Create the database:
```bash
rails db:create
```

* Run migrations:
```bash
rails db:migrate
```

* Seed initial data (create a test user):
You'll need a user to test authentication. Open the Rails console and create one:
```bash
rails console
```
```ruby
User.create!(username: 'testuser', password: 'password123', password_confirmation: 'password123')
```
Exit the console:
```ruby
exit
```

### Running the API
Start the Rails server:
```bash
rails server
```

## API Endpoints
All API endpoints are prefixed with /api/v1/.
### Authentication
* Post `/api/v1/auth/login`
  - **Description**: Authenticates a user and returns a JWT token.
  - **Request Body**:
    ```json
    {
      "username": "your_username",
      "password": "your_password"
      }
    ```
  - **Response**:
      ```json
      {
      "token": "YOUR_JWT_TOKEN",
      "message": "Login successful"
      }
    ```
#### Random Data Generation
All these endpoints require JWT Authentication. Include the Authorization: Bearer YOUR_JWT_TOKEN header.
* GET /api/v1/random_data/number
    - **Parameters**:
        - `min`: Minimum value (default: 1)
        - `max`: Maximum value (default: 100)
    - **Example**:
        `
        /api/v1/random_data/number?min=10&max=50
        `
* GET /api/v1/random_data/string
    - **Parameters**:
        - `length`: Length of string (integer, default: 10)
        - `alpha`: If true, only letters (boolean, optional)
        - `numeric`: If true, only numbers (boolean, optional)
    - **Example**:
        `
        /api/v1/random_data/string?length=20&alpha=true
        `

* GET /api/v1/random_data/name
    - **Parameters**:
        - `gender`: Gender of name (string: "male" or "female")
    - **Example**:
        `
        /api/v1/random_data/name?gender=male
        `

* GET /api/v1/random_data/address
    - **Example**:
        `
        /api/v1/random_data/address
        `

* GET /api/v1/random_data/date
    - **Parameters**:
        - `from`: Start date (string in YYYY-MM-DD format)
        - `to`: End date (string in YYYY-MM-DD format)
    - **Example**:
        `
        /api/v1/random_data/date?from=2023-01-01&to=2023-12-31
        `

* GET /api/v1/random_data/email
    - **Example**:
        `
        /api/v1/random_data/email
        `

* GET /api/v1/random_data/uuid
    - **Example**:
        `
        /api/v1/random_data/uuid
        `

* GET /api/v1/random_data/quote
    - **Parameters**:
        - `category`: Quote category (string: "yoda", "chuck_norris", "singular")
    - **Example**:
        `
        /api/v1/random_data/quote?category=chuck_norris
        `

* GET /api/v1/random_data/credit_card
    - **Example**:
        `
        /api/v1/random_data/credit_card
        `

* GET /api/v1/random_data/phone_number
    - **Example**:
        `
        /api/v1/random_data/phone_number
        `

* GET /api/v1/random_data/bank_account
    - **Example**:
        `
        /api/v1/random_data/bank_account
        `

* GET /api/v1/random_data/product
    - **Example**:
        `
        /api/v1/random_data/product
        `

* GET /api/v1/random_data/company
    - **Example**:
        `
        /api/v1/random_data/company
        `

* GET /api/v1/random_data/image
    - **Parameters**:
        - `width`: Image width in pixels (integer, default: 640)
        - `height`: Image height in pixels (integer, default: 480)
    - **Example**:
        `
        /api/v1/random_data/image?width=800&height=600
        `

* GET /api/v1/random_data/lorem_words
    - **Parameters**:
        - `count`: Number of words (integer, default: 5, max: 200)
    - **Example**:
        `
        /api/v1/random_data/lorem_words?count=10
        `

* GET /api/v1/random_data/lorem_sentences
    - **Parameters**:
        - `count`: Number of sentences (integer, default: 3, max: 50)
    - **Example**:
        `
        /api/v1/random_data/lorem_sentences?count=5
        `
### Error Simulation
* GET /api/v1/random_data/error_simulation
 - **Description**: Simulates an HTTP error response or a delay.
 - **Params**: `status` (integer, e.g., 400, 401, 403, 404, 429, 500, 502, 503), delay (float, delay in seconds)
 - **Example (404 error with 2 seconds delay)**:
   `
   /api/v1/random_data/error_simulation?status=404&delay=2
   `
 - **Example (Success with 1-second delay)**:
   `
   /api/v1/random_data/error_simulation?delay=1
   `

## Testing the API with Postman
You can use Postman to interact with and test all the API endpoints.
* Download Postman
* Import Collection
* Authentication Flow:
  1. First, send a `POST` request to `/api/v1/auth/login` with `username` and `password` in the JSON body to get a JWT token.
  2. Set up a Postman collection variable (e.g., `jwt_token`) to store this token automatically using a "Tests" script on the login request.
  3. For all other protected endpoints, add an `Authorization` header with the value `Bearer {{jwt_token}}` (using your Postman variable).

## Contributing
Contributions are welcome.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
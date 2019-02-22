# Are your colleagues on holiday?

This is a Rails application powered by Nexmo's Voice API that creates a phone service that lets users dial in to see if there a national holiday in either a specific country or worldwide. 

## Requirements

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* Rails 5.2+
* [Holidays Gem](https://github.com/holidays/holidays)
* [ngrok](https://ngrok.io)

## Installation

* Clone this repository
* Provision a Nexmo virtual number from the Nexmo dashboard
* Rename `.env.sample` to `.env` and insert your credentials in the file
* Start up the Rails server
* Make your server externally accessible with ngrok

## Usage

* Dial your phone number and follow the prompts on the phone call

## License

This application is under the [MIT License](LICENSE)
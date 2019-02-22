require 'json'
class HolidaysController < ActionController::API

    def answer
        render json:
        [
            { 
                :action => 'talk', 
                :text => 'Find out if your colleagues are on a holiday. Press 1 to enter a date or 2 for today.'
            },
            {
                :action => 'input',
                :eventUrl => ["http://d747a877.ngrok.io/date_type"]
            }
        ].to_json
    end

    def date_type
        dtmf = params['dtmf'] || parsed_body['dtmf']

        if dtmf == '1'
            render json:
            [
                {
                    :action => 'talk',
                    :text => 'Please enter a date on your keypad in the following format: four digits for the year, 
                    followed by two digits for the month and two digits for the day, followed by the hash symbol. 
                    For example, January 2nd, 2019 would be 2 0 1 9 0 1 0 2.',
                    :bargeIn => true
                },
                {
                    :action => 'input',
                    :submitOnHash => true,
                    :maxDigits => 8,
                    :eventUrl => ["http://d747a877.ngrok.io/country_choice"]
                }
            ].to_json
        elsif dtmf == '2'
            render json:
            [
                {
                    :action => 'talk',
                    :text => 'Please enter 1 for the US, 2 for the UK or 3 for worldwide holidays.'
                },
                {
                    :action => 'input',
                    :eventUrl => ["http://d747a877.ngrok.io/holiday_output"]
                }
            ].to_json
        else
            render json:
            [{:action => 'talk', :text => 'I did not recognize your selection. Please call back and try again.'}].to_json
        end
    end

    def country_choice
        date = ((params['dtmf'] || parsed_body['dtmf']) || '')

        render json:
        [
            {
                :action => 'talk',
                :text => 'Please enter 1 for the US, 2 for the UK or 3 for worldwide holidays.'
            },
            {
                :action => 'input',
                :eventUrl => ["http://d747a877.ngrok.io/holiday_output?date=#{date}"]
            }
        ].to_json
    end

    def holiday_output
        country_input = params['dtmf'] || parsed_body['dtmf']
        date_input = ((params['date'] || parsed_body['date']) || '')

        if country_input == '1'
            @holidays = holiday_lookup(date_input, :us) 
        elsif country_input == '2'
            @holidays = holiday_lookup(date_input, :gb)
        elsif country_input == '3'
            @holidays = holiday_lookup(date_input, :all)
        else
            render json:
        [
            { 
                :action => 'talk', 
                :text => 'I did not recognize the number you entered. Please call back and try again.'
            }
        ].to_json
        end

        if (@holidays.length == 0 || @holidays.nil?)
            render json:
            [
                {
                    :action => 'talk',
                    :text => 'Your colleagues are not on a holiday today. Feel free to message them on Slack! Goodbye.'
                }
            ].to_json
        else
            render json:
            [
                {
                    :action => 'talk',
                    :text => "Your colleagues are not at their desk today. It is #{@holidays[0][:name]}. Goodbye."
                }
            ].to_json
        end
    end

    def event
        puts params
    end

    private

    def holiday_lookup(date_input, country)
        with_date = false
        (date_input != '' || !date_input.nil?) ? with_date = true : with_date = false

        if with_date
            @year = date_input[0, 4].to_i
            @month = date_input[4..5].to_i
            @day = date_input[6..7].to_i
        end

        if country != :all
            with_date ? Holidays.on(Date.civil(@year, @month, @day), country) : Holidays.on(Date.today, country)
        else
            with_date ? Holidays.on(Date.civil(@year, @month, @day)) : Holidays.on(Date.today)
        end
    end
end

require 'json'
class HolidaysController < ActionController::API

    def answer
        render json:
        [
            { 
                :action => 'talk', 
                :text => 'Are your colleagues on a holiday today? Please enter 1 for the US, 2 for the UK or 3 for worldwide.'
            },
            {
                :action => 'input',
                :eventUrl => ["http://d747a877.ngrok.io/dtmf"]
            }
        ].to_json
    end

    def dtmf
        dtmf = params['dtmf'] || parsed_body['dtmf']

        if dtmf == '1'
            @holidays = holiday_lookup(:us) 
        elsif dtmf == '2'
            @holidays = holiday_lookup(:gb)
        elsif dtmf == '3'
            @holidays = holiday_lookup(:all)
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

    private

    def holiday_lookup(country)
        if country != :all
            Holidays.on(Date.today, country)
        else
            Holidays.on(Date.today)
        end
    end
end

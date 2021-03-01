require_relative './scraper.rb'
require_relative './tvshow.rb'

class ShowManager

    def user_interaction
        puts "Welcome to My Last Episode!"
        puts "Please enter the TV Show you are watching"
        show_user_input = gets.chomp
        until show_user_input.downcase == "exit"
            self.lookup_tvshow(show_user_input)
            puts "Please enter another TV Show you would like to recap on, otherwise please enter 'Exit' "
            show_user_input = gets.chomp
        end
    end

    def lookup_tvshow(show_user_input)
        begin
            puts "You have selected #{show_user_input}"
            tv_show = self.storage_checker(show_user_input)
            puts "Please enter the last episode you watched - in the format of Season & Episode i.e. S3, E4"
            episode_user_input = gets.chomp
            puts "You have selected #{show_user_input} - #{episode_user_input}"
            user_tv_summary = tv_show.tv_summary(episode_user_input)
            puts user_tv_summary
        rescue 
            puts "Sorry, this doesn't exist in our database - please ensure your spelling is correct or ask us about another TV Show."
        end
        #this rescue will stop the code from freaking out when it can't open the false http - we can put our error message here. 
    end 

    def storage_checker(show_user_input)
        website_tv_show = show_user_input.downcase.gsub(/[:'#\.]/, "").gsub(" ", "-")
        tv_show = TVShow.find_by_name(website_tv_show)
        if tv_show.nil? 
            puts "Searching for new show..."
            show_data = self.get_show(website_tv_show)
            tv_show = TVShow.new(website_tv_show, show_data)
        end
        return tv_show
    end

    def find_website(website_tv_show)
        url = "https://thetvdb.com/series/"
        return "#{url}#{website_tv_show}/allseasons/official"
    end

    def get_show(website_tv_show)
        return Scraper.tvshow_scraping(self.find_website(website_tv_show))
    end

end
require 'open-uri'
require 'nokogiri'

class Scraper 

    def self.tvshow_scraping(tvshow_url)
        doc = Nokogiri::HTML(open(tvshow_url))
        tvshow_url_data = doc.css("div.container div.row li.list-group-item")
        tvshow_data = {}
        tvshow_url_data.each do |episode_row|
            episode_id = episode_row.css("h4.list-group-item-heading span.episode-label").text
            episode_summary = episode_row.css("div.list-group-item-text p").text
            if episode_id.length > 0 && episode_summary.length > 0 
                #checks that neither are blank i.e. not released or a special 
                tvshow_data[episode_id] = episode_summary
            end
        end
        return tvshow_data
    end

end
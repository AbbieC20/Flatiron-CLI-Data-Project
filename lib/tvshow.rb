class TVShow
    attr_reader :name, :tvshow_data

    @@all = []

    def initialize(name, tvshow_data)
        @name = name 
        @tvshow_data = tvshow_data
        @@all << self 
    end

    def self.all
        @@all 
    end

    def self.find_by_name(name)
        self.all.find { |show| show.name == name }
    end

    def season_number(episode_user_input)
        return episode_user_input.scan(/[\d]+/)[0].to_i
    end

    def episode_number(episode_user_input)
        return episode_user_input.scan(/[\d]+/)[1].to_i
    end

    def tv_summary(episode_user_input)
        summary_season_number = self.season_number(episode_user_input)
        summary_episode_number = self.episode_number(episode_user_input)
        if summary_season_number < 10
             summary_season_number = "0#{summary_season_number}" 
        end 
        if summary_episode_number < 10 
            summary_episode_number = "0#{summary_episode_number}"
        end 
        return @tvshow_data["S#{summary_season_number}E#{summary_episode_number}"]
    end

end


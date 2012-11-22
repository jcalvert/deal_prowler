require 'open-uri'
class WootOff < ActiveRecord::Base
  attr_accessible :end_date, :woot_id, :offers, :podcast_mp3_url, :podcast_ogg_url, :podcast_teaser, :podcast_title, :site, :start_date, :subtitle, :title, :type, :write_up

  def self.fetch
    woot_offs_json=JSON.parse open("http://api.woot.com/2/events.json?key=47db9c89c1434acc901e078b39c001ce&eventType=WootOff").read
    woot_offs = woot_offs_json.collect do |woot_off_json|      
      woot_off=WootOff.new(Hash[woot_off_json.keys.collect!{|key| 
        case key
          when "Id" then "woot_id"
          when "Offers" then "offers"
          else key.tableize.singularize
        end
        }.zip(woot_off_json.values)])
    end
    recent_woot_offs=WootOff.find(:all,'created_at < ?', woot_offs.last.start_date)
    woot_offs.reject!{|wo| recent_woot_offs.include?(wo)}
    woot_offs.each{|wo| wo.save }
  end
end
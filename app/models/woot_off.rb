require 'open-uri'
class WootOff < ActiveRecord::Base
  attr_accessible :end_date, :woot_id, :offers, :podcast_mp3_url, :podcast_ogg_url, :podcast_teaser, :podcast_title, :site, :start_date, :subtitle, :title, :type, :write_up

  def self.fetch
    woot_offs_json=JSON.parse open("http://api.woot.com/2/events.json?key=#{ENV['WOOT_API_KEY']}&eventType=WootOff").read
    woot_offs = woot_offs_json.collect do |woot_off_json|      
      woot_off=WootOff.new(Hash[woot_off_json.keys.collect!{|key| 
        case key
          when "Id" then "woot_id"
          when "Offers" then "offers"
          else key.tableize.singularize
        end
        }.zip(woot_off_json.values)])
    end
    return if woot_offs.empty?
    recent_woot_off_ids=WootOff.find(:all,'created_at < ?', woot_offs.last.start_date).collect{|wo| wo.woot_id}
    woot_offs.reject!{|wo| recent_woot_off_ids.include?(wo.woot_id)}
    woot_offs.each{|wo| wo.save }
  end
end
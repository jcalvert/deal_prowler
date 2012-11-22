require 'test_helper'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr'
  c.hook_into :webmock # or :fakeweb
end

class WootOffTest < ActiveSupport::TestCase

	context "fetch" do
		should "not have duplicates" do
 			VCR.use_cassette('woot_off_fetch', :allow_playback_repeats => true) do
 				count_first = WootOff.count
 				WootOff.fetch
 				assert_equal count_first+5, WootOff.count
 				count = WootOff.count
 				WootOff.fetch
 				assert_equal count, WootOff.count
     		end
		end
	end

end

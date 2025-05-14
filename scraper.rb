# encoding: utf-8
require 'bundler/setup'

Bundler.require(:default)

require 'scraperwiki'
require 'selenium-webdriver'

# Set up Selenium WebDriver
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless') # Run in headless mode (no browser window)
options.add_argument('--disable-gpu')
options.add_argument('--no-sandbox')

driver = Selenium::WebDriver.for(:chrome, options: options)

url = "https://portal.planbuild.tas.gov.au/external/advertisement/search"

#records = []
driver.navigate.to(url)
sleep 10
rows = driver.find_elements(css: '.row.advertisement-result-row')

rows.each do |row|
    # Extract the ID from the row's 'id' attribute
    advertisement_id = row.attribute('id')
    next unless advertisement_id

    # Construct the detail page URL
    detail_url = "https://portal.planbuild.tas.gov.au/external/advertisement/#{advertisement_id}"
    puts "Fetching details for ID: #{advertisement_id} from #{detail_url}"
  
end
  #record = {
  #      'council_reference' => council_reference,
  #      'address' => address,
  #      'description' => description,
  #      'on_notice_to' => Date.parse(on_notice_to).to_s,
  #      'date_scraped' => Date.today.to_s,
  #      'info_url' => detail_url,
  #      'comment_authority' => "City of Hobart",
  #      'comment_email' => "representation@hobartcity.com.au"
  #    }


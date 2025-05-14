# encoding: utf-8
require 'scraperwiki'
require 'mechanize'

a = Mechanize.new

url = "https://portal.planbuild.tas.gov.au/external/advertisement/search"

#records = []

site = a.get(url)
site.search('.advertisement-result-row').each do |row|
  appl = a.get("https://portal.planbuild.tas.gov.au/external/advertisement/#{row.id}")
  puts appl.inspect    
  
  record = {
        'council_reference' => council_reference,
        'address' => address,
        'description' => description,
        'on_notice_to' => Date.parse(on_notice_to).to_s,
        'date_scraped' => Date.today.to_s,
        'info_url' => detail_url,
        'comment_authority' => "City of Hobart",
        'comment_email' => "representation@hobartcity.com.au"
      }


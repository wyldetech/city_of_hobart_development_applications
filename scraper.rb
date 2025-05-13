# encoding: utf-8
require 'scraperwiki'
require 'mechanize'

a = Mechanize.new

url = "https://portal.planbuild.tas.gov.au/external/advertisement/search"

records = []

a.get(url) do |page|
  page.search('.advertisement-result-row').each do |row|
    address = row.at('.col-xs-8').text.strip
    council_reference = row.at('.col-xs-4').text.strip
    id = row['id']

    # Fetch the detailed page for each advertisement
    detail_url = "https://portal.planbuild.tas.gov.au/external/advertisement/#{id}"
    
    begin
      puts "Fetching details from: #{detail_url}"  # Debugging information
      detail_page = a.get(detail_url)

      description = detail_page.at('.toastui-editor-contents p[data-nodeid="32"]').text.strip
      on_notice_to = detail_page.at('#advertisementEndDate').text.strip

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

      records << record

      # Print the first 5 records to the console for validation
      # --- Start of print code ---
      if records.size <= 5
        puts record
      end
      # --- End of print code ---
          
      ScraperWiki.save_sqlite(['council_reference'], record)
    rescue Mechanize::ResponseCodeError => e
      puts "Failed to fetch #{detail_url}: #{e.message}"
    end
  end
end

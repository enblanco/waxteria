require 'rebay'

module Discovery
  class EbayAdapter
    RECORDS_CATEGORY_ID = 176985

    def initialize(settings)
      Rebay::Api.app_id = settings[:app_id]
      Rebay::Api.sandbox = settings[:sandbox]
    end

    def seek(terms)
      response = fetch_items_for(terms)
      items_from_response(response)
    end

     private

     def rebay_finding
       @rebay_finding ||= Rebay::Finding.new
     end

     def fetch_items_for(terms)
       rebay_finding.find_items_advanced({:categoryId => RECORDS_CATEGORY_ID, :keywords => terms})
     end

     def items_from_response(response)
       response.results.map do |result|
         Item.new(:title => result['title'])
       end
    end
  end
end

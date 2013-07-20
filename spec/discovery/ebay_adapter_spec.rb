require 'spec_helper'

module Discovery
  describe EbayAdapter do
    it "configures rebay api with given settings" do
      config = double(:config)
      expect(Rebay::Api).to receive(:app_id=).with('EBAYAPPID')
      expect(Rebay::Api).to receive(:sandbox=).with(false)
      EbayAdapter.new(:app_id => 'EBAYAPPID', :sandbox => false)
    end

    describe "#seek" do
      it "searches on ebay records category and returns items" do
        terms = "wimple winch"
        ebay_settings = { :app_id => 'EBAYAPPID', :sandbox => false }
        adapter = EbayAdapter.new(ebay_settings)

        rebay_finding = double(:rebay_finding)
        allow(Rebay::Finding).to receive(:new) { rebay_finding }

        items = [
          {
            "itemId" => "12345678",
            "title" => "Wimple Winch LP",
            "primaryCategory" => { "categoryId"=>"176985", "categoryName"=>"Records" }
          },
          {
            "itemId" => "2345671",
            "title" => "Wimple Winch - Save My Soul",
            "primaryCategory" => { "categoryId"=>"176985", "categoryName"=>"Records" }
          }
        ]
        response_results = items

        rebay_response = double(:rebay_response, :results => response_results)
        allow(rebay_finding).to receive(:find_items_advanced).
          with(:categoryId => 176985, :keywords => terms).
          and_return(rebay_response)

        items = adapter.seek(terms)
        items.size.should == 2
        items.should include(Item.new(:title => "Wimple Winch LP"))
        items.should include(Item.new(:title => "Wimple Winch - Save My Soul"))
      end
    end
  end
end

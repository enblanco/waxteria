$: << './lib'
require 'discovery'

module Discovery
  describe Seeker do
    describe "#seek" do
      it "retrieves items matching given terms" do
        items = [Item.new(:title => 'Wimple Winch Save My Soul 45 Single'), Item.new(:title => 'Wimple Winch Collection')]
        seek_adapter = double(:seek_adapter)
        seek_adapter.stub(:seek).with('wimple winch').and_return(items)
        seeker = Seeker.new(seek_adapter)
        seeker.seek('wimple winch').should == items
      end
    end
  end
end

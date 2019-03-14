require_relative '../lib/gilded_rose.rb'

describe GildedRose do

  context "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "should not chnage the SellIn or Quality of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
      expect(items[0].quality).to eq 50
    end

    it "shoud not reduce the quality of an item below 0" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 0
    end
  end
end

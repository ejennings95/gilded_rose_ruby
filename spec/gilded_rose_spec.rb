require_relative '../lib/gilded_rose.rb'

describe GildedRose do

  context "#Item_name" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  context "#Sulfuras" do
    it "should not chnage the SellIn or Quality of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
      expect(items[0].quality).to eq 50
    end
  end

  context "#Quality_of_item_0_of_normal_item" do
    it "shoud not reduce the Quality of an item below 0" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 0
    end
  end

  context "#Normal_items_in_SellIn_date" do
    it "should lower the Quality by 1 each day" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_quality()
      expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by -1
    end

    it "should lower the SellIn by 1 each day" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_quality()
      expect { GildedRose.new(items).update_quality() }.to change { items[0].sell_in }.by -1
    end
  end

  context "#SellIn_of_item_0_normal_item" do
    it "should reduce the SellIn of an item twice as fast" do
      items = [Item.new("foo", 0, 10)]
      expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by -2
    end
  end
end

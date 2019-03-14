require_relative '../lib/gilded_rose.rb'

describe GildedRose do

  describe "Item Name" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe "Update SellIn after each day" do
    context "#Normal_items" do
      it "should lower the SellIn by 1 each day" do
        items = [Item.new("foo", 10, 10)]
        GildedRose.new(items).update_quality()
        expect { GildedRose.new(items).update_quality() }.to change { items[0].sell_in }.by -1
      end
    end

    context "#Sulfuras" do
      it "should not change the SellIn of Sulfuras" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
      end
    end
  end

  describe "Update Quality after each day" do
    context "#Sulfuras" do
      it "should not change the Quality of Sulfuras" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    context "#Normal_items_in_SellIn_date" do
      it "should lower the Quality by 1 each day" do
        items = [Item.new("foo", 10, 10)]
        GildedRose.new(items).update_quality()
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by -1
      end
    end

    context "#SellIn_0_normal_item" do
      it "should reduce the Quality of an item twice as fast" do
        items = [Item.new("foo", 0, 10)]
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by -2
      end
    end

    context "#Quality_0_normal_item" do
      it "should not reduce the Quality of an item below 0" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 0
      end
    end

    context "#Quality_of_item_max" do
      it "should not increase the Quality of an item beyond 50" do
        items = [Item.new("Aged Brie", 10, 50)]
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 0
      end
    end

    context "#Backstage_passes" do
      it "should increase in Quality as the SellIn date approaches" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 20)]
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 1
      end

      it "should increase in Quality by 2 as the SellIn date is between 6 and 10 inclusive" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)]
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 2
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 2
      end

      it "should increase in Quality by 3 as the SellIn date is between 0 and 5 inclusive" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 3
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 3
      end

      it "should drop Quality to 0 when the SellIn date has passed" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "#Aged_brie" do
      it "should increase in Quality as the SellIn date approaches" do
        items = [Item.new("Aged Brie", 20, 20)]
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 1
      end

      it "should increase Qualityby 2 after the SellIn has past" do
        items = [Item.new("Aged Brie", -2, 20)]
        expect { GildedRose.new(items).update_quality() }.to change { items[0].quality }.by 2
      end
    end
  end
end

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if decrease_quality_as_sell_in_approaches?(item)
        reduce_quality_by_1(item)
      else
        item_quality_less_than_50(item)
        under_10_sell_in_value(item)
      end
      reduce_sell_in_by_1(item)
      sell_in_less_than_0?(item)
    end
  end

  private

  def decrease_quality_as_sell_in_approaches?(item)
    (item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert") ? true : false
  end

  def item_quality_less_than_50(item)
    item.quality += 1 if item.quality < 50
  end

  def reduce_quality_by_1(item)
    item.quality -= 1 if (item.name != "Sulfuras, Hand of Ragnaros" && item.quality > 0)
  end

  def sell_in_less_than_0?(item)
    if item.sell_in < 0
      item.quality = 0 if item.name == "Backstage passes to a TAFKAL80ETC concert"
      item_quality_less_than_50(item) if item.name == "Aged Brie"
      reduce_quality_by_1(item) if item.name != "Aged Brie"
    end
  end

  def reduce_sell_in_by_1(item)
    item.sell_in -= 1 if item.name != "Sulfuras, Hand of Ragnaros"
  end

  def under_10_sell_in_value(item)
    item_quality_less_than_50(item) if (item.name == "Backstage passes to a TAFKAL80ETC concert" && item.sell_in < 11)
    item_quality_less_than_50(item) if (item.name == "Backstage passes to a TAFKAL80ETC concert" && item.sell_in < 6)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

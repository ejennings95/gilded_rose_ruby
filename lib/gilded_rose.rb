class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            reduce_quality_by_1(item)
          end
        end
      else
        item_quality_less_than_50?(item)
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          if item.sell_in < 11
            item_quality_less_than_50?(item)
          end
          if item.sell_in < 6
            item_quality_less_than_50?(item)
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                reduce_quality_by_1(item)
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
        item_quality_less_than_50?(item)
        end
      end
    end
  end

  private

  def item_quality_less_than_50?(item)
    item.quality += 1 if item.quality < 50
  end

  def reduce_quality_by_1(item)
    item.quality -= 1
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

# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy
from scrapy.item import Field


class Ln2Item(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    name = scrapy.Field()           # Tên tác phẩm
    author = scrapy.Field()         # Tác giả
    artist = scrapy.Field()         # Hoạ sĩ
    heart = scrapy.Field()          # Lượt tim theo dõi
    view = scrapy.Field()           # Số lượt xem
    star = scrapy.Field()           # Đánh giá
    gernes = scrapy.Field()         # Thể loại
    words =scrapy.Field()           # Số lượng từ
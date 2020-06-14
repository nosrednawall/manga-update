import scrapy

class MangaupdatesItem(scrapy.Item):
    volume = scrapy.Field()
    chapter = scrapy.Field()
    date = scrapy.Field()
    url = scrapy.Field()
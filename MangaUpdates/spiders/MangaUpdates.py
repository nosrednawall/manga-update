# -*- coding: utf-8 -*-
import scrapy
import re
from MangaUpdates.items import MangaupdatesItem

class MangaUpdates(scrapy.Spider):
    name = 'MangaUpdates'
    allowed_domains = ['https://dropescan.com']
    start_urls = ['https://dropescan.com/manga/mairimashita-iruma-kun/']

    def parse(self, response):
        site_url = response.css('body.manga-page .page-content-listing.single-page .listing-chapters_wrap > ul.main.version-chap a::attr(href)').re("[^\\t\\n\\[\\'\\,]+")
        site = response.css('body.manga-page .page-content-listing.single-page .listing-chapters_wrap > ul.main.version-chap li ::text').re("[^\\t\\n\\[\\'\\,]+")
        volume = site[0]
        last_chapter = site[1]
        date_last_chapter = site[2]
        url = site_url[1]
        update = MangaupdatesItem(volume=volume,chapter=last_chapter,date=date_last_chapter,url=url)

        yield update
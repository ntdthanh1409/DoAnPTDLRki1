import scrapy
import re
from ..items import Ln2Item
import time
import csv

class LnSpider(scrapy.Spider):      #spider để crawl thông tin chi tiết của từng LN/WN
    name = 'ln'
    # allowed_domains = ['https://ln.hako.re']
    start_urls = ['https://ln.hako.re/']
    base_url = 'https://ln.hako.re'
    with open('link.csv') as f:     # truy cập vào file csv chứa link LN/WN
        reader = csv.reader(f)
        list = [link for link in reader] # Chuyển link vào list để crawl

    all_urls = []  # tạo list mới
    for i in list:
        all_urls.append(i[0])
    del all_urls[0] # Xoá index của nó

        
    def parse(self, response):  # truy cập vào từng bộ với thời gian nghỉ là 3 giây để chống lỗi truy cập quá nhiều
      
        for url in self.all_urls:
            yield scrapy.Request(url, callback = self.parse_ln)
            time.sleep(3)


    def parse_ln(self, response): 
        name = response.xpath('//span[@class="series-name"]/a/text()').get()
        fields = response.css('main.section-body')
        heart = fields.css('span.block.feature-name::text').get()
        star = 0                                             
        view = 0
        words = 0
        gernes = []
        author = 'None'
        artist = 'None'
        sv = fields.css('div.statistic-value::text')
        if len(sv) == 3:
            words = sv.get().replace(".", "")
            star = sv[1].get()
            view = sv[2].get().replace(".", "")

        aa = fields.css('span.info-value > a ::text')
        if len(aa) == 3:
            author = aa.get()            
            artist = aa[1].get()
            if artist == 'N/A':
                artist = 'None'
        elif len(aa) == 2:
            author = aa.get()
            artist = 'None' 
        else:
            author = aa.get()
            artist = 'None'
        gerne = response.xpath('//div[@class="series-information"]/div/a/text()').getall()
        for i in gerne:
           a = i
           b = str.replace(a, "\n", "") 
           gernes.append(b)

        item = Ln2Item()
        item["name"] = name
        item['heart'] = heart
        item['star'] = star
        item['view'] = view
        item['words'] = words
        item['author'] = author
        item['artist'] = artist
        item['gernes'] = gernes
        yield item
        # time.sleep(1)
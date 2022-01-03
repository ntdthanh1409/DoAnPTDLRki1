import scrapy


class CrawllinkSpider(scrapy.Spider):     # spider để crawl toàn bộ link LN/WN của trang hako
    name = '48link'
    start_urls = ['https://ln.hako.re/danh-sach?truyendich=1&sapxep=capnhat&page=1']
    base_urls = 'https://ln.hako.re'
    list1 = []
    for i in range(2,48):     # lấy link của 46 trang hako
        urls = str.replace('https://ln.hako.re/danh-sach?truyendich=1&sapxep=capnhat&page=1', 'page=1', 'page='+ str(i))
        list1.append(urls) # cho hết vào 1 list 

    def parse(self, response):
        for half_urls in response.xpath('//div[@class="col-12 float-left col-lg-9"]/section/main/div/div[@class="thumb_attr series-title"]/a/@href'):
            half_url = half_urls.get()
            links = self.base_urls +  half_url
            yield {'link': links}   # lấy toàn bộ link truyện của từng trang

        for i in self.list1:      
            if i is not None:
                yield scrapy.Request(i, callback= self.parse)    # qua trang tiếp theo 
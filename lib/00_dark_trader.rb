require 'rubygems'
require 'pry'
require 'nokogiri'
require 'open-uri'



def search_ccy(page)
	return ccy = page.xpath('//*[@class="text-left col-symbol"]/text()')
end

def search_prices(page)
	return prices = page.xpath('//*[@class="price"]/text()')
end

def create_database(ccy, prices)
sym_prices=[]
for i in 0...ccy.size
	sym_prices << {ccy[i].to_s => prices[i].to_s.delete("$").to_f}
end
return sym_prices
end

def perform
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	return create_database(search_ccy(page),search_prices(page)).to_a
end




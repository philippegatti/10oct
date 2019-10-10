require 'rubygems'
require 'pry'
require 'nokogiri'
require 'open-uri'

def get_city_list ()
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	return city_list = page.xpath('///a[starts-with(@href,"./95/")]/text()').to_a
end

def get_townhall_urls (city_list)
	return urls_list = city_list.map {|city| city = "http://annuaire-des-mairies.com/95/#{city.to_s.downcase.tr(" ","-")}.html"}
end

def get_single_townhall_email(townhall_url)
	begin
	 	page = Nokogiri::HTML(open(townhall_url))
		return email = page.xpath('//section[2]//tr[4]/td[2]/text()').to_s	
	 rescue => e
	 	return email = "n/a"
	 end
end

def get_email_list (townhall_urls)
	return email_list = townhall_urls.map { |url| url = get_single_townhall_email(url) }
end

def create_database(city_list, email_list)
email_per_city=[]
for i in 0...city_list.size
	email_per_city << {city_list[i].to_s.downcase.capitalize => email_list[i].to_s}
end
return email_per_city
end

def perform
	return create_database(get_city_list, get_email_list(get_townhall_urls(get_city_list))).to_a
end





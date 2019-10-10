require 'rubygems'
require 'pry'
require 'nokogiri'
require 'open-uri'

def get_MP_list ()
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
	return list_of_MP = page.xpath('///a[starts-with(@href,"/deputes/fiche")]/text()')
end

def get_email_list ()
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
	url_list = page.xpath('///a[starts-with(@href,"/deputes/fiche")]/@href')
	mail_list = []
	for i in 0...url_list.size
		begin
			page_depute = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/#{url_list[i].to_s}"))
			mail_list << {"email" => page_depute.xpath('/html/body/div/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl//ul/li[2]/a/text()').to_s}
		rescue => e
			mail_list << {"email" => "n/a"}	
		end
	end
	return mail_list
end

#def split_name_and_email (full_name) alternative qui permet de reconstituer les adresse mails sans les scraper
#	full_name = full_name.split(' ')
#	return {"first_name" => full_name[1], "last_name" => full_name[2..full_name.size-1].join(' '), "email" => full_name[1].downcase+"."+full_name[2..full_name.size-1].join('').downcase+"@assemblee-nationale.fr"}
#end

def split_single_name (full_name)
	full_name = full_name.split(' ')
	return {"first_name" => full_name[1], "last_name" => full_name[2..full_name.size-1].join(' ')}
end

def name_base (list_of_MP)
	name_list = []
	for i in 0...list_of_MP.size
	name_list << split_single_name(list_of_MP[i].to_s)
	end
	return name_list
end

def merge_lists (name_list, email_list)
	global_list=[]
	for i in 0...name_list.size
		global_list << name_list[i].merge(email_list[i])
	end
	return global_list
end

def perform
	list_depute = get_MP_list
	name_list = name_base(list_depute)
	mail_list = get_email_list()
	return print final_list = merge_lists(name_list, mail_list).to_a
end












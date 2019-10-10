require_relative '../lib/01_mairie_christmas'

describe "should return the list of the cities" do
	it "should return the 185 cities of Val d'oise" do
       expect(get_city_list().size).to eq(185)
    end
end

describe "get get_single_townhall_email to return emails for each city" do
    it "should return good email adresses " do
    	expect(get_single_townhall_email("http://annuaire-des-mairies.com/95/argenteuil.html")). to eq("christian.bournery@ville-argenteuil.fr")
    end
end




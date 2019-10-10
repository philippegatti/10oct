require_relative '../lib/02_deputes'

describe "mp list should return the list of french members of parliament" do
   it "should split a name in first_name / last_name" do
       expect(split_single_name("M. Florian Bachelier")).to eq({"first_name"=>"Florian", "last_name"=>"Bachelier"})
   end

   it "should split all the names of a liste" do
       expect(name_base(["M. ABC DEF","Mme XYZ MNP"])).to eq([{"first_name"=>"ABC", "last_name"=>"DEF"},{"first_name"=>"XYZ", "last_name"=>"MNP"}])
   end

   it "should merge two arrays of ashes" do 
   		expect(merge_lists([{"a" => 1, "b" => 2},{"x" => 23, "y" => 76}],[{"c" => 3},{"z" => 79}])).to eq([{"a"  => 1,"b" => 2,"c" => 3},{"x" => 23, "y" => 76, "z" => 79}])
   	end
end

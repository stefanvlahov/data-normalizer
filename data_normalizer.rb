def normalize_data(input)
  input.each do
    normalized_hash = {:year => year_normalizer(input[:year]), :make => make_normalizer(input[:make]), :model => model_normalizer(input[:model]), :trim => trim_normalizer(input[:model], input[:trim])}
    return normalized_hash
  end
  # examples[0][0][:year]
end

def year_normalizer(year)
  year.length != 4 && !(year.to_i.between?(1900, Time.new.year + 2)) ? normalized = year : normalized = year.to_i
  return normalized
end

def make_normalizer(make)
  list_of_accepted_makes = {"Ab" => "Abarth", "Ac" => "Acura", "Al" => "Alfa Romeo", "Ar" => "Ariel", "As" => "Aston Martin", "Be" => "Bentley", "Bo" => "Bowler",
  "BM" => "BMW", "Br" => "Briggs", "Bu" => "Buick", "Ca" => "Cadillac", "Ch" => "Chevrolet", "Ci" => "Citoren", "Da" => "Datsun", "Do" => "Dodge", "Fe" => "Ferrari",
  "Fi" => "Fiat", "Fo" => "Ford", "Gi" => "Ginetta", "Ho" => "Honda", "Hy" => "Hyundai", "In" => "Infiniti", "Is" => "Isuzu", "Ja" =>"Jaguar", "Je" => "Jeep",
  "Jo" => "Joss", "Ka" => "Kamaz", "Ki" => "Kia", "Ko" => "Koenigsegg", "La" => "Land Rover", "Le" => "Lexus", "Li" => "Lincoln", "Lo" => "Lotus",
  "Ma" => "Mazda", "Mc" => "McLaren", "Me" => "Mercedes-Benz", "Mi" => "Mitsubishi", "Mo" => "Morgan", "Ni" => "Nissan", "No" => "Noble", "Op" => "Opel", "Pa" => "Pagani",
  "Pe" => "Peugeot", "Po" => "Porsche", "Pr" => "Proton", "Re" => "Renault", "Ro" => "Rolls-Royce", "Sa" => "Saab", "Se" => "Seat", "Sk" => "Skoda", "Sm" => "Smart",
  "Su" => "Subaru", "Ta" => "Tata", "Te" => "Tesla", "To" => "Toyota", "Va" => "Vauxhall", "Vo" => "Volkswagen"}

  make_start = make[0..1].capitalize

  if list_of_accepted_makes.include?(make_start)
    return list_of_accepted_makes[make_start[0..1]]
  elsif make.eql?("blank")
    return nil
  else
    return make
  end

end

def model_normalizer(model)
  model_array = model.split

  normalized_model = model_array[0].capitalize

  if normalized_model == "blank"
    return nil
  elsif model.length < 4
    return model
  else
    return normalized_model
  end

end

def trim_normalizer(model, trim)
  if model.match(" ")
    model_array = model.split
    model_trim = model_array[1].upcase
    return model_trim
  elsif trim == "blank"
    return nil
  elsif trim.length > 2
    return trim
  else
    return trim.upcase
  end

end

examples = [
  [{ :year => '2018', :make => 'fo', :model => 'focus', :trim => 'blank' },
   { :year => 2018, :make => 'Ford', :model => 'Focus', :trim => nil }],
  [{ :year => '200', :make => 'blah', :model => 'foo', :trim => 'bar' },
   { :year => '200', :make => 'blah', :model => 'foo', :trim => 'bar' }],
  [{ :year => '1999', :make => 'Chev', :model => 'IMPALA', :trim => 'st' },
   { :year => 1999, :make => 'Chevrolet', :model => 'Impala', :trim => 'ST' }],
  [{ :year => '2000', :make => 'ford', :model => 'focus se', :trim => '' },
   { :year => 2000, :make => 'Ford', :model => 'Focus', :trim => 'SE' }]
]

examples.each_with_index do |(input, expected_output), index|
  if (output = normalize_data(input)) != expected_output
    puts "Example #{index + 1} failed,
          Expected: #{expected_output.inspect}
          Got:      #{output.inspect}"
  end
end

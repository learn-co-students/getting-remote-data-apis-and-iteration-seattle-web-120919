def welcome
  puts "welcome! may the fourth be with you!!"
end

def get_character_from_user
  puts "please enter a character name"
  gets.chomp.split.map(&:capitalize).join(' ')
  # gets.chomp captures input, chomp off newline that gets added with return 
  # ie:  user inputs luke, hits enter  => gets = luke\n
end

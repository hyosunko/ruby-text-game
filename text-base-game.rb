class Player
  def initialize name
  @name = name
  @points = {'social' => 0, 'frontend' => 0, 'backend' => 0, 'ux_ui' => 0}

  end
  attr_accessor :points
  attr_reader :name

  def update_score type, value
    @points[type] += value
  end

end


class Story
  def initialize player
  @story = "A Day At Learn"
  @story_running_order = []
  @player = player
  @score = []
  end

  def add_story story_hash
    @story_running_order << story_hash
  end

  def run_story_board
    
    @story_running_order.each do |question_object|
      array_of_answers = question_object.ask_question
      @player.points[array_of_answers[0]] += array_of_answers[1]
      @score << array_of_answers
    end
    
    cls
    puts
    puts
    puts
    
    give_advice

  end

  def give_advice
    puts "   Your skills scores were:"
    puts
    puts "     Social    : #{@player.points["social"]}"
    puts "     Front End : #{@player.points["frontend"]}"
    puts "     Back End  : #{@player.points["backend"]}"
    puts "     UX/UI     : #{@player.points["ux_ui"]}"
    result = @player.points.max_by{|k,v| v}
    # p result
    puts

    case result[0]
    when "social"
      puts "   You should work at a bar"
    when "frontend"
      puts "   You have been offered a job at Facebook"
    when "backend"
      puts "   You have been offered a job at Notch 8"
    when "ux_ui"
      puts "   You have been offered a role at Cozy"
    else
      puts "   You've been fired"
    end
      puts

    # print "   #{@score}, "
  end

end



class Questions
  def initialize new_story
    @new_story = new_story

    @q_no = new_story[0]
    @question = new_story[1]
    @type_of_question = new_story[2]
    @answer_hash = new_story[3]
  end

  attr_reader :question,:type_of_question,:answer_hash, :q_no, :new_story

  def print_out_possible_answer
    i = 1
    puts
    puts "   Choose from the below answers:"
    puts
    @answer_hash.each do |answer_object|
      print "   #{i}-#{answer_object["answer"]}"
      puts
      i += 1
    end
  end

  def ask_question
    cls
    puts
    puts
    puts "   Question #{q_no} : #{@question}"
    puts
    # display possible answers
    print_out_possible_answer()
    puts
    print "   What is your answer? : "
    # Get response from user
    while
      answer = gets.chomp
      # Create index for array searcg
      index = answer.to_i - 1
      if index <= @answer_hash.length-1 and index >=0
        break;
      else
        puts
        puts "   You entered invalid answer."
        print "   Please enter number between 1 and #{@answer_hash.length} :  "
      end
    end
    puts

    if @type_of_question != "social"
        if @answer_hash[index]["correct_answer"]
          puts "   Correct Answer!"
          print"   Press enter to continue..."
          gets.chomp
        else
          correct_answer_array = @answer_hash.select {|object| object["correct_answer"] == true }
          print "   The was incorrect, the correct answer was: "
          puts correct_answer_array[0]["answer"]
          puts
          print"   Press enter to continue..."
          gets.chomp
        end
    end
    # Find out type of question so we know what score to update
    type_of_question = @type_of_question
    # Find out how many points to assign
    points_value = @answer_hash[index]["points"]
    # Print selected answer to screen

    [type_of_question, points_value,@q_no, @question, @answer_hash[index]["answer"], @answer_hash[index]["correct_answer"]]

  end
end


def cls
    print "\e[2J\e[f"
end

def get_player_name
  puts
  puts
  puts "   #######################################################"
  puts "   #                                                     #"
  puts "   #        Welcome to World of coding school            #"
  puts "   #                                                     #"
  puts "   #                     v 1.1                           #"
  puts "   #                                                     #"
  puts "   #           by enrique, eric, mike, sam               #"
  puts "   #                                                     #"
  puts "   #######################################################"
  puts
  print "   Enter your name: "
  name = gets.chomp


  puts
  puts
  puts "   Welcome to Learn Academy #{name.upcase}!!!"
  puts
  print "   Press enter to continue..."
  gets
  player1 = Player.new(name)
end

story_list =[

  [1, "It's your first day at Learn, your alarm goes off, do you hit snooze?", "social",
    [ {'answer' => "Wake Up", 'points' => Random.new.rand(0..1), 'correct_answer'=>nil},
      {'answer' => "Hit Snooze Button", 'points' => Random.new.rand(-1..0), 'correct_answer'=>nil}]],

  [2, "What did you have for breakfast?", "social",
    [ {'answer' => "Eggs", 'points' => Random.new.rand(0..2), 'correct_answer'=>nil},
      {'answer' => "Coffee / Tea", 'points' => Random.new.rand(0..0), 'correct_answer'=>nil},
      {'answer' => "Porridge / Oatmeal", 'points' => Random.new.rand(0..3), 'correct_answer'=>nil}]],

  [3, "Do all HTML tags come in a pair?", "ux_ui",
    [ {'answer' => "Yes", 'points' => -1, 'correct_answer'=>false},
      {'answer' => "No", 'points' => 3, 'correct_answer'=>true}]],
    
  [4, "Where did you go for Lunch?", "social",
    [ {'answer' => "Chipotle", 'points' => Random.new.rand(0..2), 'correct_answer'=>nil},
      {'answer' => "Nectar", 'points' => Random.new.rand(0..5), 'correct_answer'=>nil}, 
      {'answer' => "Grapes deli", 'points' => Random.new.rand(0..3), 'correct_answer'=>nil}, 
      {'answer' => "Jack in the Box", 'points' => Random.new.rand(-2..1), 'correct_answer'=>nil}]],

  [5, "Which of the following are examples of closures?", "frontend",
    [ {'answer' => "Objects", 'points' => -1, 'correct_answer'=>false},
      {'answer' => "Variables", 'points' => -1, 'correct_answer'=>false},
      {'answer' => "Functions", 'points' => -1, 'correct_answer'=>false},
      {'answer' => "All the above", 'points' => 3, 'correct_answer'=>true}]],

  [6, "What is the extension used for saving the ruby file?","backend",
    [ {'answer' => ".ruby extension", 'points' => -1, 'correct_answer'=>false},
      {'answer' => ".rrb extension", 'points' => -1, 'correct_answer'=>false},
      {'answer' => ".rub extension", 'points' => -1, 'correct_answer'=>false},
      {'answer' => ".rb extension", 'points' => 2, 'correct_answer'=>true}]],

  [7, "Class is over and we are heading to pub, what's your move?", "social",
    [ {'answer' => "Order water", 'points' => Random.new.rand(-4..1), 'correct_answer'=>nil},
      {'answer' => "Order shots", 'points' => Random.new.rand(-1..1), 'correct_answer'=>nil},
      {'answer' => "Order a light beer", 'points' => Random.new.rand(0..2), 'correct_answer'=>nil},
      {'answer' => "Order a Martini", 'points' => Random.new.rand(0..3), 'correct_answer'=>nil} ]]

]


cls
# create player game begins

player1 = get_player_name()
main_story = Story.new(player1)
  # add story list to main story 1.Question, 2.Catogary, 3.Hash - possible, amount of point, correct answer
for i in 0..story_list.length-1
  main_story.add_story(Questions.new(story_list[i]))
end

main_story.run_story_board

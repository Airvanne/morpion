class Board
  include Enumerable
  #TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases
  attr_accessor :array_cases

  def initialize
    #TO DO :
    #Quand la classe s'initialize, elle doit créer 9 instances BoardCases
    @array_cases = Array.new
    #Ces instances sont rangées dans une array qui est l'attr_accessor de la classe
    9.times do |i|
      @array_cases.push(BoardCase.new(nil,i+1))
    end
  end

  def to_s
  #TO DO : afficher le plateau

    @array_cases.length.times do |i|
      if @array_cases[i].valeur == nil
        print "#{@array_cases[i].case_number}        "
        else
        print "#{@array_cases[i].valeur}        "
      end

      if i+1 == 3
        puts " "
        elsif i+1 == 6
        puts " "
        else
      end
    end
    puts " "
  end

  def play (case_selec, valeur_player)
    #TO DO : une méthode qui change la BoardCase jouée en fonction de la valeur du joueur (X, ou O)
      @array_cases[case_selec-1].valeur = valeur_player
  end

  def victory?
    #TO DO : qui gagne ?
  end

end

class BoardCase
  #TO DO : la classe a 2 attr_accessor, sa valeur (X, O, ou vide), ainsi que son numéro de case)
  attr_accessor :valeur, :case_number

  def initialize (valeur, case_number)
    #TO DO doit régler sa valeur, ainsi que son numéro de case
    @valeur = valeur
    @case_number = case_number
  end

  def to_s
    #TO DO : doit renvoyer la valeur au format string
    return @valeur.to_s
  end

end

class Player
  #TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?
attr_accessor :nom_player, :valeur_player
attr_writer :status
attr_reader :list_case_p

  def initialize (nom_player, valeur_player)
    #TO DO : doit régler son nom, sa valeur, son état de victoire
      @nom_player = nom_player
      @valeur_player = valeur_player
      @status = "il a gagné ?"

      @list_case_p = Array.new
  end

  def list_case(case_num)  #Liste des cases que les joueurs ont jouées

      @list_case_p.push(case_num)
  end
end

class Game
  def initialize
    #TO DO : créé 2 joueurs
    puts "Quel est le prénom du joueur 1 ?"
    print ">"
    nom_1 = gets.chomp

    puts "Quel est le prénom du joueur 2 ?"
    print ">"
    nom_2 = gets.chomp

    @player_1 = Player.new(nom_1, "X")
    @player_2 = Player.new(nom_2, "O")

    #Créé un board
    @board = Board.new

  end

  def go
    # TO DO : lance la partie


  end

  def turn
    #TO DO : affiche le plateau,
    @board.to_s
    gameover = 0
    player_1_turn = true
    #demande au joueur il joue quoi
    while gameover == 0
      #Tour du player_1
      if player_1_turn
        puts "#{@player_1.nom_player.capitalize} à votre tour :"
        print ">"
        move = gets.chomp.to_i

        @board.play(move, @player_1.valeur_player)

        #renvoie les cases jouées par player_1
        @player_1.list_case(move)

        player_1_turn = false
      else

        #Tour du player_2
        puts "#{@player_2.nom_player.capitalize} à votre tour :"
        print ">"
        move = gets.chomp.to_i

        @board.play(move,@player_2.valeur_player)

        #renvoie les cases jouées par player_2
        @player_2.list_case(move)

        player_1_turn = true
      end
      @board.to_s

      #vérifie si un joueur a gagné

      win_blocks = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
      win_blocks.each {|b|
        if ((b - @player_1.list_case_p).empty?)
          gameover = 1
          puts "#{@player_1.nom_player.capitalize} a gagné"
        elsif ((b - @player_2.list_case_p).empty?)
          gameover = 2
          puts"#{@player_2.nom_player.capitalize} a gagné"
        end
    }
    end

  end

end

Game.new.turn

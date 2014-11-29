#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# Dieser Spieler ist eine Vorlage wie Spieler aussehen sollen, er ist eher nicht Wettkampftauglich.

puts("Passer")
# Als erstes sagen die Programme ihren Namen.
spielerzahl = gets.to_i
starteinsatz = gets.to_i
klein = gets.to_i

loop do
  neue_runde = gets.to_s
  wert = gets.to_i
  # Wert, der durch Zufall ermittelt wurde, wie gut das "Blatt" des Spielers ist. Je höher desto besser, es gilt: 0 <= wert <= 1. Zumindest mit dem Standartzufallsgenerator.
  start = gets.to_i
  loop do
    eingabe = gets.to_f
    if eingabe == "Du bist dran!"
      puts klein
    elsif eingabe == "Spiel vorbei"
      break
    end
  end
  gets.to_i
  spielerzahl.times do
    gets.to_i
  end
end

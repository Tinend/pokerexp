#!/usr/bin/ruby
# -*- coding: utf-8 -*-

$:.unshift(File.dirname(__FILE__))
require 'Gleichverteilung'
require 'Spiel.rb'

namen = []
entscheider = []
gewinne = []
arg = false
runden = 0
ARGV.each do |a|
  if arg
    runden = a.to_i
    arg = false
  elsif a["-n"]
    arg = true
  else
    entscheider.push(IO.popen(a, "w+"))
    puts entscheider.length
    entscheider[-1].puts("Hallo")
    namen.push(entscheider[-1].gets.to_s)
    gewinne.push(0)
  end
end
p namen
if runden == 0
  puts "Warnung: Keine Rundendauer angegeben. Starte Programm mit '-n x'"
end
# namen ist ein Array der Namen der Spieler
# entscheider enhält die Dateinamen der Spieler
#Wichtig: der i. Name gehört zum i. Spieler
zufallsgenerator = Gleichverteilung.new
spiel = Spiel.new(entscheider, zufallsgenerator)
runden.times do
  gewinne = spiel.runde
end
gewinne.each_with_index do |g,i|
  puts "Der Spieler Nummer #{i + 1} (#{namen[i]}) hat #{g} Punkte."
end
entscheider.each do |s|
  s.close
end

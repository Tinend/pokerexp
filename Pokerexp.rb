#!/usr/bin/ruby
# -*- coding: utf-8 -*-

$:.unshift(File.dirname(__FILE__))
require 'Lader.rb'
require 'Gleichverteilung'
require 'Spiel.rb'

lader = Lader.new
entscheider = ARGV
namen = []
entscheider.each do |p|
  namen.push(p.gets.to_s)
end
# namen ist ein Array der Namen der Spieler
# entscheider enhält die Dateinamen der Spieler
#Wichtig: der i. Name gehört zum i. Spieler
zufallsgenerator = Gleichverteilung.new
spiel = Spiel.new(entscheider, zufallsgenerator)
puts "Wie viele Runden sollen gespielt werden?"
runden = gets.to_i
runden.times do
  gewinne = spiel.runde
end
gewinne.each_with_index do |g,i|
  puts "Der Spieler Nummer #{i + 1} (#{namen[i]}) hat #{g} Punkte."
end
entscheider.each do |s|
  s.close
end

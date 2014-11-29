#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$:.unshift(File.dirname(__FILE__))
require 'Lader.rb'
require 'Spiel.rb'

lader = Lader.new
programme = lader.programme
entscheider = []
namen = []
programme.each do |p|
  namen.push(p[0])
  entscheider.push(p[1])
end
# namen ist ein Array der Namen der Spieler
# entscheider enhält die Dateinamen der Spieler
#Wichtig: der i. Name gehört zum i. Spieler
zufallsgenerator = lader.zufallsgenerator
puts "Wie viele Spieler sollen spielen?"
spielerzahl = gets.to_i
if spielerzahl <= 1
  puts "Wie sinnlos. Soetwas tun lediglich Menschen. Ein Computer hingegen lässt sich auf so eine Zeitverschwendung nicht ein! Goodbye!"
  exit
end
spieler = []
spielertypen = []
spielerzahl.times do
  puts "Es stehen folgende Entscheider zur Auswahl:"
  namen.each_with_index do |e, i|
    puts "#{i + 1} = #{e}"
  end
  puts "Welchen wählst du?"
  wahl = gets.to_i
  if 0 < wahl and wahl <= entscheider.length
    spieler.push(IO.popen(entscheider[wahl - 1],"w+"))
    spielertypen.push(namen[wahl - 1])
  else
    wahl = rand(entscheider.length)
    puts "Nur Exemplare einer unterlegene Rasse, wie die Menschen, würden überhaupt auf die Idee kommen, so etwas dummes zu tippen! Ein Computer hätte längst gemerkt, dass sich die eingetippte Zahl nicht im Definitionsbereich befindet. Also übernehme ich die Wahl. Sie lautet: #{wahl + 1}; #{entscheider[wahl].to_s}"
    spieler.push(IO.popen(entscheider[wahl],"w+"))
    spielertypen.push(namen[wahl])
  end
end
spiel = Spiel.new(spieler, zufallsgenerator)
puts "Wie viele Runden sollen gespielt werden?"
runden = gets.to_i
runden.times do
  gewinne = spiel.runde
end
gewinne.each_with_index do |g,i|
  puts "Der Spieler Nummer #{i + 1} (#{namen[i]}) hat #{g} Punkte."
end
spieler.each do |s|
  s.close
end

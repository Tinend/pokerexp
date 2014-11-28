# -*- coding: utf-8 -*-
# der Lader ist dafür verantwortlich, die (Computer-)Spieler und den Zufallsgenerator zusammen zu suchen und dem Hauptprogramm zu übergeben.

require '~/ruby/pokerexp/Gleichverteilung.rb'

class Lader
  def initialize
    @zufallsgenerator = Gleichverteilung.new
    @bernhards_programme = {
    }
    # Einträge haben folgende Form:
    # "Name" => "PATH_TO_DATEI"
    @ulrichs_programme = {
      "Passer" => "~/ruby/pokerexp/ulrichs_programme/Passer.rb"
    }
    @entscheider = []
    @namen = []
    @programme = @bernhards_programme
    @ulrichs_programme.each do |up|
      @programme[up[0]] = up[1]
    end
    # Hash kennt kein +
  end

  attr_reader :programme, :zufallsgenerator
end

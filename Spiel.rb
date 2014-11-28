# -*- coding: utf-8 -*-
class Spiel

  STARTEINSATZ = 1000
  KLEIN = -1

  def initialize(entscheider, zufallsgenerator, start = 0)
    @entscheider = entscheider
    @werte = []
    # Werte stellen die durch den Zufallsgenerator erzeugten Zufallszahlen dar
    @gewinn = []
    @zufallsgenerator = zufallsgenerator
    @spielerzahl = @entscheider.length
    (@spielerzahl).times do
      @werte.push(0)
      @gewinn.push(0)
    end
    # Gewinn und Werte erhalten für jeden Entscheider einen Slot
    @entscheider.each do |e|
      e.puts(@spielerzahl.to_s)
      e.puts(STARTEINSATZ)
      # Einsatz, mit dem das Spiel beginnt. Der erste Spieler muss immer am anfang so viel einsetzen.
      e.puts(KLEIN.to_s)
      # Programme erfahren Spielerzahl und "KLEIN", eine Zahl die kleiner als alle Spielwerte ist, die man erhalten kann. Stellt später passen dar.
    end
    @start = 0
    # Start ist die Position des Spielers, der die erste Runde beginnt. Es wird reihum gewechselt.
  end

  def runde
    @werte.collect! {|w| w = @zufallsgenerator.zufall}
    # Zufallszahlen werden erzeugt
    @entscheider.each_with_index do |e, i|
      e.puts("Neue Runde!")
      # Hilfe, falls Programme übersicht verlieren, wo sie gerade sind.
      e.puts(@werte[i].to_s)
      e.puts((@start - i) % @spielerzahl)
    end
    # und den Entscheidern mitgeteilt
    kandidaten = einsaetze
    max = 0
    # maximaler erzeugter Wert in den Werten
    gleich = 0
    # wie oft maximum erzeugt wird. Bei Gleichheit entscheidet Zufall, wer gewinnt.
    kandidaten[:drinnen].each_with_index do |k, i|
      if k
        if @werte[i] > max
          max = @werte[i]
          gleich = 1
        elsif @werte[i] == max
          gleich += 1
        end
      else
        @werte[i] = KLEIN
      end
    end
    wahl = rand(gleich)
    # es wird bei Gleichstand entschieden, wer gewinnt
    gewinner = false
    kandidaten[:drinnen].each_with_index do |k, i|
      if k and @werte[i] == max and wahl == 0
        wahl -= 1
        gewinner = i
      elsif k and @werte[i] == max
        wahl -= 1
      end
    end
    unless gewinner
      # Kein Gewinner gefunden. => wahl > 0, max wird nie erreicht oder alle haben gepasst. Keiner der Fälle sollte Eintreten
      p wahl
      p max
      p kandidaten[:drinnen]
      raise
    end
    @gewinn[gewinner] += kandidaten[:summe]
    @entscheider.each_with_index do |e, i|
      e.puts("Spiel vorbei")
      e.puts(((gewinner - i) % @spielerzahl).to_s)
      (@werte[i..(@spielerzahl - 1)] + @werte[0..(i-1)]).each do |w|
        e.puts(w.to_s)
      end
      # verrät den Spielern was die Anderen hatten (falls sie nicht gepasst haben, dann steht, sie hätten KLEIN gehabt.)
    end
    return @gewinn
  end
    
  def einsaetze
    # Handelt das Pokern ab
    einsaetze = []
    @spielerzahl.times do
      einsaetze.push(0)
    end
    einsaetze[@start] = STARTEINSATZ
    # KLEIN im Einsatzarray stellt ein passen dar
    max = STARTEINSATZ
    # max ist der maximale bisherige Einsatz
    summe = STARTEINSATZ
    # summe ist die Summe aller bisherigen Einsaetze.
    position = @start
    until einsaetze.all? {|e| e == KLEIN or e == max}
      # überprüft, ob alle entweder gepasst haben oder das Maximum gewählt haben.
      position = (position + 1) % @spielerzahl
      if position != KLEIN
        @entscheider[position].puts("Du bist dran!")
        # Teilt dem Spieler mit, dass er am Zug ist
        ansage = @entscheider[position].gets.to_i
        if ansage < max
          einsaetze[position] = KLEIN
          @entscheider.each do |e|
            e.puts KLEIN.to_s
          end
        else
          max = ansage
          @gewinn[position] -= ansage - einsaetze[position]
          einsaetze[position] = ansage
          summe += ansage
          @entscheider.each do |e|
            e.puts ansage.to_s
          end
        end
      else
        @entscheider.each do |e|
          e.puts((KLEIN - 1).to_s)
        end
        # Durch diese Zahl, die kleiner als KLEIN ist, wird verdeutlicht, dass dieser Spieler bereits zuvor gepasst hat.
        # Dieses puts ist vor allem dafür da, dass die Spieler sich nicht speichern müssen, wer schon gepasst hat. (Mit ausnahme von ihnen selbst natürlich)
      end
    end
    # Bemerkung: Diese Schleife terminiert nicht immer. Die terminal Bedingung hängt nämlich von den Spielern ab. Ich bin nicht sicher, wie man dieses Problem lösen kann.
    # Jeder Spieler bekommt reihum die Möglichkeit zu passen oder zu erhöhen. Hat jeder entweder gepasst oder erhöht, dann gilt die Wette und es wird aufgedeckt.
    drinnen = []
    @einsaetze.each do |e|
      if e < 0
        drinnen.push(false)
      else
        drinnen.push(true)
      end
    end
    # wertet aus, wer noch mit dabei ist. 

    return {:summe => summe, :drinnen=> drinnen}
  end
end

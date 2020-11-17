# frozen_string_literal: true

class MarcRules
  COMMON_FIELDS = {
    "LDR" => nil,
    "001" => nil,
    "003" => nil,
    "005" => nil,
    "006" => nil,
    "007" => nil,
    "008" => nil,
    "010" => ["a", "b", "z", "8"],
    "013" => ["a", "b", "c", "d", "e", "f", "6", "8"],
    "015" => ["a", "q", "z", "2", "6", "8"],
    "016" => ["a", "z", "2", "8"],
    "017" => ["a", "b", "d", "i", "z", "2", "6", "8"],
    "018" => ["a", "6", "8"],
    "020" => ["a", "c", "q", "z", "6", "8"],
    "022" => ["a", "l", "m", "y", "z", "2", "6", "8"],
    "024" => ["a", "c", "d", "q", "z", "2", "6", "8"],
    "025" => ["a", "8"],
    "026" => ["a", "b", "c", "d", "e", "2", "5", "6", "8"],
    "027" => ["a", "q", "z", "6", "8"],
    "028" => ["a", "b", "q", "6", "8"],
    "030" => ["a", "z", "6", "8"],
    "031" => ["a", "b", "c", "d", "e", "g", "m", "n", "o", "p", "q", "r", "s", "t", "u", "y", "z", "2", "6", "8"],
    "032" => ["a", "b", "6", "8"],
    "033" => ["a", "b", "c", "p", "0", "2", "3", "6", "8"],
    "034" => ["a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "m", "n", "p", "r", "s", "t", "x", "y", "z", "0", "2", "3", "6", "8"],
    "035" => ["a", "z", "6", "8"],
    "036" => ["a", "b", "6", "8"],
    "037" => ["a", "b", "c", "f", "g", "n", "3", "5", "6", "8"],
    "038" => ["a", "6", "8"],
    "040" => ["a", "b", "c", "d", "e", "6", "8"],
    "041" => ["a", "b", "d", "e", "f", "g", "h", "j", "k", "m", "n", "2", "6", "8"],
    "042" => ["a"],
    "043" => ["a", "b", "c", "0", "2", "6", "8"],
    "044" => ["a", "b", "c", "2", "6", "8"],
    "045" => ["a", "b", "c", "6", "8"],
    "046" => ["a", "b", "c", "d", "e", "j", "k", "l", "m", "n", "o", "p", "2", "6", "8"],
    "047" => ["a", "2", "8"],
    "048" => ["a", "b", "2", "8"],
    "050" => ["a", "b", "3", "6", "8"],
    "051" => ["a", "b", "c", "8"],
    "052" => ["a", "b", "d", "2", "6", "8"],
    "055" => ["a", "b", "0", "2", "6", "8"],
    "060" => ["a", "b", "0", "8"],
    "061" => ["a", "b", "c", "8"],
    "066" => ["a", "b", "c"],
    "070" => ["a", "b", "0", "8"],
    "071" => ["a", "b", "c", "8"],
    "072" => ["a", "x", "2", "6", "8"],
    "074" => ["a", "z", "8"],
    "080" => ["a", "b", "x", "2", "6", "8"],
    "082" => ["a", "b", "m", "q", "2", "6", "8"],
    "083" => ["a", "c", "m", "q", "y", "z", "2", "6", "8"],
    "084" => ["a", "b", "q", "2", "6", "8"],
    "085" => ["a", "b", "c", "f", "r", "s", "t", "u", "v", "w", "y", "z", "0", "6", "8"],
    "086" => ["a", "z", "2", "6", "8"],
    "088" => ["a", "z", "6", "8"],
    "100" => ["a", "b", "c", "d", "e", "f", "g", "j", "k", "l", "n", "p", "q", "t", "u", "0", "4", "6", "8"],
    "110" => ["a", "b", "c", "d", "e", "f", "g", "k", "l", "n", "p", "t", "u", "0", "4", "6", "8"],
    "111" => ["a", "c", "d", "e", "f", "g", "j", "k", "l", "n", "p", "q", "t", "u", "0", "4", "6", "8"],
    "130" => ["a", "d", "f", "g", "h", "k", "l", "m", "n", "o", "p", "r", "s", "t", "0", "6", "8"],
    "210" => ["a", "b", "2", "6", "8"],
    "222" => ["a", "b", "6", "8"],
    "240" => ["a", "d", "f", "g", "h", "k", "l", "m", "n", "o", "p", "r", "s", "0", "6", "8"],
    "242" => ["a", "b", "c", "h", "n", "p", "y", "6", "8"],
    "243" => ["a", "d", "f", "g", "h", "k", "l", "m", "n", "o", "p", "r", "s", "6", "8"],
    "245" => ["a", "b", "c", "f", "g", "h", "k", "n", "p", "s", "6", "8"],
    "246" => ["a", "b", "f", "g", "h", "i", "n", "p", "5", "6", "8"],
    "247" => ["a", "b", "f", "g", "h", "n", "p", "x", "6", "8"],
    "250" => ["a", "b", "3", "6", "8"],
    "254" => ["a", "6", "8"],
    "255" => ["a", "b", "c", "d", "e", "f", "g", "6", "8"],
    "256" => ["a", "6", "8"],
    "257" => ["a", "0", "2", "6", "8"],
    "258" => ["a", "b", "6", "8"],
    "260" => ["a", "b", "c", "e", "f", "g", "3", "6", "8"],
    "263" => ["a", "6", "8"],
    "264" => ["a", "b", "c", "3", "6", "8"],
    "270" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "p", "q", "r", "z", "4", "6", "8"],
    "300" => ["a", "b", "c", "e", "f", "g", "3", "6", "8"],
    "306" => ["a", "6", "8"],
    "307" => ["a", "b", "6", "8"],
    "310" => ["a", "b", "6", "8"],
    "321" => ["a", "b", "6", "8"],
    "336" => ["a", "b", "0", "2", "3", "6", "8"],
    "337" => ["a", "b", "0", "2", "3", "6", "8"],
    "338" => ["a", "b", "0", "2", "3", "6", "8"],
    "340" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "m", "n", "o", "0", "2", "3", "6", "8"],
    "342" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "2", "6", "8"],
    "343" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "6", "8"],
    "344" => ["a", "b", "c", "d", "e", "f", "g", "h", "0", "2", "3", "6", "8"],
    "345" => ["a", "b", "0", "2", "3", "6", "8"],
    "346" => ["a", "b", "0", "2", "3", "6", "8"],
    "347" => ["a", "b", "c", "d", "e", "f", "0", "2", "3", "6", "8"],
    "348" => ["a", "b", "0", "2", "3", "6", "8"],
    "351" => ["a", "b", "c", "3", "6", "8"],
    "352" => ["a", "b", "c", "d", "e", "f", "g", "i", "q", "6", "8"],
    "355" => ["a", "b", "c", "d", "e", "f", "g", "h", "j", "6", "8"],
    "357" => ["a", "b", "c", "g", "6", "8"],
    "362" => ["a", "z", "6", "8"],
    "363" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "u", "v", "x", "z", "6", "8"],
    "365" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "m", "2", "6", "8"],
    "366" => ["a", "b", "c", "d", "e", "f", "g", "j", "k", "m", "2", "6", "8"],
    "370" => ["c", "f", "g", "i", "s", "t", "u", "v", "0", "2", "3", "4", "6", "8"],
    "377" => ["a", "l", "0", "2", "6", "8"],
    "380" => ["a", "0", "2", "6", "8"],
    "381" => ["a", "u", "v", "0", "2", "6", "8"],
    "382" => ["a", "b", "d", "e", "n", "p", "r", "s", "t", "v", "0", "2", "3", "6", "8"],
    "383" => ["a", "b", "c", "d", "e", "2", "6", "8"],
    "384" => ["a", "6", "8"],
    "385" => ["a", "b", "m", "n", "0", "2", "3", "6", "8"],
    "386" => ["a", "b", "i", "m", "n", "0", "2", "3", "4", "6", "8"],
    "388" => ["a", "0", "2", "3", "6", "8"],
    "400" => ["a", "b", "c", "d", "e", "f", "g", "k", "l", "n", "p", "t", "u", "v", "x", "4", "6", "8"],
    "410" => ["a", "b", "c", "d", "e", "f", "g", "k", "l", "n", "p", "t", "u", "v", "x", "4", "6", "8"],
    "411" => ["a", "c", "d", "e", "f", "g", "k", "l", "n", "p", "q", "t", "u", "v", "x", "4", "6", "8"],
    "440" => ["a", "n", "p", "v", "w", "x", "0", "6", "8"],
    "490" => ["a", "l", "v", "x", "3", "6", "8"],
    "500" => ["a", "3", "5", "6", "8"],
    "501" => ["a", "5", "6", "8"],
    "502" => ["a", "b", "c", "d", "g", "o", "6", "8"],
    "504" => ["a", "b", "6", "8"],
    "505" => ["a", "g", "r", "t", "u", "6", "8"],
    "506" => ["a", "b", "c", "d", "e", "f", "u", "2", "3", "5", "6", "8"],
    "507" => ["a", "b", "6", "8"],
    "508" => ["a", "6", "8"],
    "510" => ["a", "b", "c", "u", "x", "3", "6", "8"],
    "511" => ["a", "6", "8"],
    "513" => ["a", "b", "6", "8"],
    "514" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "m", "u", "z", "6", "8"],
    "515" => ["a", "6", "8"],
    "516" => ["a", "6", "8"],
    "518" => ["a", "d", "o", "p", "0", "2", "3", "6", "8"],
    "520" => ["a", "b", "c", "u", "2", "3", "6", "8"],
    "521" => ["a", "b", "3", "6", "8"],
    "522" => ["a", "6", "8"],
    "524" => ["a", "2", "3", "6", "8"],
    "525" => ["a", "6", "8"],
    "526" => ["a", "b", "c", "d", "i", "x", "z", "5", "6", "8"],
    "530" => ["a", "b", "c", "d", "u", "3", "6", "8"],
    "533" => ["a", "b", "c", "d", "e", "f", "m", "n", "3", "5", "7", "6", "8"],
    "534" => ["a", "b", "c", "e", "f", "k", "l", "m", "n", "o", "p", "t", "x", "z", "3", "6", "8"],
    "535" => ["a", "b", "c", "d", "g", "3", "6", "8"],
    "536" => ["a", "b", "c", "d", "e", "f", "g", "h", "6", "8"],
    "538" => ["a", "i", "u", "3", "5", "6", "8"],
    "540" => ["a", "b", "c", "d", "u", "3", "5", "6", "8"],
    "541" => ["a", "b", "c", "d", "e", "f", "h", "n", "o", "3", "5", "6", "8"],
    "542" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "u", "3", "6", "8"],
    "544" => ["a", "b", "c", "d", "e", "n", "3", "6", "8"],
    "545" => ["a", "b", "u", "6", "8"],
    "546" => ["a", "b", "3", "6", "8"],
    "547" => ["a", "6", "8"],
    "550" => ["a", "6", "8"],
    "552" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "u", "z", "6", "8"],
    "555" => ["a", "b", "c", "d", "u", "3", "6", "8"],
    "556" => ["a", "z", "6", "8"],
    "561" => ["a", "u", "3", "5", "6", "8"],
    "562" => ["a", "b", "c", "d", "e", "3", "5", "6", "8"],
    "563" => ["a", "u", "3", "5", "6", "8"],
    "565" => ["a", "b", "c", "d", "e", "3", "6", "8"],
    "567" => ["a", "b", "0", "2", "6", "8"],
    "580" => ["a", "6", "8"],
    "581" => ["a", "z", "3", "6", "8"],
    "583" => ["a", "b", "c", "d", "e", "f", "h", "i", "j", "k", "l", "n", "o", "u", "x", "z", "2", "3", "5", "6", "8"],
    "584" => ["a", "b", "3", "5", "6", "8"],
    "585" => ["a", "3", "5", "6", "8"],
    "586" => ["a", "3", "6", "8"],
    "588" => ["a", "5", "6", "8"],
    "600" => ["a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "z", "0", "2", "3", "4", "6", "8"],
    "610" => ["a", "b", "c", "d", "e", "f", "g", "h", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "v", "x", "y", "z", "0", "2", "3", "4", "6", "8"],
    "611" => ["a", "c", "d", "e", "f", "g", "h", "j", "k", "l", "n", "p", "q", "s", "t", "u", "v", "x", "y", "z", "0", "2", "3", "4", "6", "8"],
    "630" => ["a", "d", "e", "f", "g", "h", "k", "l", "m", "n", "o", "p", "r", "s", "t", "v", "x", "y", "z", "0", "2", "3", "4", "6", "8"],
    "647" => ["a", "c", "d", "g", "v", "x", "y", "z", "0", "2", "3", "6", "8"],
    "648" => ["a", "v", "x", "y", "z", "0", "2", "3", "6", "8"],
    "650" => ["a", "b", "c", "d", "e", "g", "4", "v", "x", "y", "z", "0", "2", "3", "6", "8"],
    "651" => ["a", "e", "g", "4", "v", "x", "y", "z", "0", "2", "3", "6", "8"],
    "653" => ["a", "6", "8"],
    "654" => ["a", "b", "c", "e", "v", "y", "z", "0", "2", "3", "4", "6", "8"],
    "655" => ["a", "b", "c", "v", "x", "y", "z", "0", "2", "3", "5", "6", "8"],
    "656" => ["a", "k", "v", "x", "y", "z", "0", "2", "3", "6", "8"],
    "657" => ["a", "v", "x", "y", "z", "0", "2", "3", "6", "8"],
    "658" => ["a", "b", "c", "d", "2", "6", "8"],
    "662" => ["a", "b", "c", "d", "e", "f", "g", "h", "0", "2", "4", "6", "8"],
    "700" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "x", "0", "3", "4", "5", "6", "8"],
    "710" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "x", "0", "3", "4", "5", "6", "8"],
    "711" => ["a", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "n", "p", "q", "s", "t", "u", "x", "0", "3", "4", "5", "6", "8"],
    "720" => ["a", "e", "4", "6", "8"],
    "730" => ["a", "d", "f", "g", "h", "i", "k", "l", "m", "n", "o", "p", "r", "s", "t", "x", "0", "3", "5", "6", "8"],
    "740" => ["a", "h", "n", "p", "5", "6", "8"],
    "751" => ["a", "e", "0", "2", "3", "4", "6", "8"],
    "752" => ["a", "b", "c", "d", "e", "f", "g", "h", "0", "2", "4", "6", "8"],
    "753" => ["a", "b", "c", "0", "2", "6", "8"],
    "754" => ["a", "c", "d", "x", "z", "0", "2", "6", "8"],
    "760" => ["a", "b", "c", "d", "g", "h", "i", "m", "n", "o", "s", "t", "w", "x", "y", "4", "6", "7", "8"],
    "762" => ["a", "b", "c", "d", "g", "h", "i", "m", "n", "o", "s", "t", "w", "x", "y", "4", "6", "7", "8"],
    "765" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "767" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "770" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "772" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "773" => ["a", "b", "d", "g", "h", "i", "k", "m", "n", "o", "p", "q", "r", "s", "t", "u", "w", "x", "y", "z", "3", "4", "6", "7", "8"],
    "774" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "775" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "776" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "777" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "s", "t", "w", "x", "y", "4", "6", "7", "8"],
    "780" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "785" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "786" => ["a", "b", "c", "d", "g", "h", "i", "j", "k", "m", "n", "o", "p", "r", "s", "t", "u", "v", "w", "x", "y", "z", "4", "6", "7", "8"],
    "787" => ["a", "b", "c", "d", "g", "h", "i", "k", "m", "n", "o", "r", "s", "t", "u", "w", "x", "y", "z", "4", "6", "7", "8"],
    "800" => ["a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "0", "3", "4", "5", "6", "7", "8"],
    "810" => ["a", "b", "c", "d", "e", "f", "g", "h", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "v", "w", "x", "0", "3", "4", "5", "6", "7", "8"],
    "811" => ["a", "c", "d", "e", "f", "g", "h", "j", "k", "l", "n", "p", "q", "s", "t", "u", "v", "w", "x", "0", "3", "4", "5", "6", "7", "8"],
    "830" => ["a", "d", "f", "g", "h", "k", "l", "m", "n", "o", "p", "r", "s", "t", "v", "w", "x", "0", "3", "5", "6", "7", "8"],
    "850" => ["a", "8"],
    "852" => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "p", "q", "s", "t", "u", "x", "z", "2", "3", "6", "8"],
    "856" => ["a", "b", "c", "d", "f", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "2", "3", "6", "8"],
    "880" => ["6", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "7", "8", "9"],
    "882" => ["a", "i", "w", "6", "8"],
    "883" => ["a", "c", "d", "q", "x", "u", "w", "0", "8"],
    "884" => ["a", "g", "k", "q", "u"],
    "885" => ["a", "b", "c", "d", "w", "x", "z", "0", "2", "5"],
    "886" => ["a", "b", "2"],
    "887" => ["a", "2"]
  }

  def self.common_field?(field)
    COMMON_FIELDS.keys.include?(field)
  end

  def self.common_practice?(field,subfield = nil)
    return true if subfield.nil? && common_field?(field)
    return false unless common_field?(field)
    COMMON_FIELDS[field]&.include?(subfield)
  end

end

import parsecsv
import streams, strformat, os
import sequtils

proc parseData*(expansionName: string, expansionShortName: string) = 
  removeDir(expansionName)
  createDir(expansionName)

  var file = newFileStream("./" & expansionName & "/basicNemesisCards.ts", fmWrite)
  file.write("""const basicNemesisCards = [""" & "\n")

  var templateFile: string
  var shields: string
  var hp: string
  var power: string

  var parser: CsvParser
  parser.open("data.csv")
  parser.readHeaderRow()
  while parser.readRow():
    if parser.rowEntry("Type") == "Minion":
      hp = fmt""" {"\n"}    hp: {parser.rowEntry("HP/Power")},"""
      if parser.rowEntry("Shields").len != 0:
        shields = fmt""" {"\n"}    shields: {parser.rowEntry("Shields")},"""
      else:
        shields = ""
    else:
      hp = ""
      shields = ""

    if parser.rowEntry("Type") == "Power":
      power = fmt""" {"\n"}    power: {parser.rowEntry("HP/Power")},"""
    else:
      power = ""

    templateFile = "  {\n" & fmt"""
    expansion: "{parser.rowEntry("Set")}",
    tier: {parser.rowEntry("Tier")},
    type: "{parser.rowEntry("Type")}",
    name: "{parser.rowEntry("Name")}",{shields}{hp}{power}
    effect: `{parser.rowEntry("Text")}`""" & "\n  },\n"

    if parser.rowEntry("Set") == expansionShortName:
      file.write(templateFile)

  parser.close()

  file.write("""]""")
  file.close()

# Parse data
parseData("aeonsEnd", "AE")
parseData("legacy", "L")
parseData("theNewAge", "NA")
parseData("warEternal", "WE")

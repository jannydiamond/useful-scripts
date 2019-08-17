import parseopt, os
import create_component_helpers

proc cli*() =
  var componentName, filetype, target: string = ""

  for kind, key, val in getopt():
    case kind
    of cmdShortOption:
      case key
      of "v": showVersion()
      of "h": helpFunction()
      of "c": componentName = val
      of "f": filetype = val 
      of "t": target = val
      else:
        discard
    else:
      discard 

  # Print helpFunction in case parameters are empty
  if componentName.len == 0:
    echo "Component name parameter (-c flag) has to be set\n"
    helpFunction()

  # Set file type
  if filetype.len == 0:
    filetype = ".tsx"

  # Set target directory
  if target.len == 0:
    target = "./src/components"

  setCurrentDir(target)
  createDir(componentName)
  setCurrentDir("./" & componentName)

  createIndexFile(componentName, filetype)
  createIndexStoriesFile(componentName, filetype)
  createIndexTestFile(componentName, filetype)

when isMainModule:
  cli()
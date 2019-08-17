import streams, strformat, os

#------------------------------------------------
# Show help
#------------------------------------------------

proc helpFunction*() =
  echo "Creates a react styled component"
  echo "\nUsage: " & splitPath(getAppFilename()).tail & " -c=componentName -f=filetype -t=target"
  echo "\n\t-c The name of the component in camelCase"
  echo "\t-f File type (e.g. jsx, tsx) [default: tsx]"
  echo "\t-t Target Path [default: ./src/components]"
  echo "\t-v Show version"
  quit(1) # Exit script after printing help

#------------------------------------------------
# Show version
#------------------------------------------------

proc showVersion*() =
  echo "1.0.0"
  quit()

#------------------------------------------------
# Create component template
#------------------------------------------------

proc createIndexFile*(componentName: string, filetype: string) =
  var indexFile = newFileStream("index." & filetype, fmWrite)
  var templateFile: string = fmt"""
import styled from 'styled-components'

const {componentName} = styled('div')`
`

{componentName}.displayName = '{componentName}'

export default {componentName}"""

  if not isNil(indexFile):
    indexFile.write(templateFile)
    indexFile.close()

#------------------------------------------------
# Create story template for component
#------------------------------------------------

proc createIndexStoriesFile*(componentName: string, filetype: string) =
  var indexStoriesFile = newFileStream("index.stories." & filetype, fmWrite)
  var templateFile: string = fmt"""
import React from 'react'
import """ & "{ storiesOf }" & fmt""" from '@storybook/react'
import """ & "{ action }" & fmt""" from '@storybook/addon-actions'

import {componentName} from './'

storiesOf('{componentName}', module)
  .add('Story name', () => (
    <{componentName}></{componentName}>
  ))"""

  if not isNil(indexStoriesFile):
    indexStoriesFile.write(templateFile)
    indexStoriesFile.close()

#------------------------------------------------
# Create test template for component
#------------------------------------------------

proc createIndexTestFile*(componentName: string, filetype: string) =
  var indexTestFile = newFileStream("index.test." & filetype, fmWrite)
  var templateFile: string = fmt"""
import React from 'react';
import ReactDOM from 'react-dom';
import {componentName} from './';

it('renders without crashing', () => """ & "{\n" & fmt"""
  const div = document.createElement('div');
  ReactDOM.render(<{componentName}></{componentName}>, div);
""" & "}" & fmt""");"""

  if not isNil(indexTestFile):
    indexTestFile.write(templateFile)
    indexTestFile.close()
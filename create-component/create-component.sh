#!/bin/sh

# abort on premature error
set -e

#------------------------------------------------
# Define helpFunction
#------------------------------------------------

helpFunction()
{ 
  echo "Creates a react styled component"
  echo -e "\nUsage: ./${0##*/} -c componentName -f filetype -t target"
  echo -e "\n\t-c The name of the component in camelCase"
  echo -e "\t-f File type (e.g. .jsx, .tsx) [default: .tsx]"
  echo -e "\t-t Target Path [default: ./src/components]"
  exit 1 # Exit script after printing help
}

#------------------------------------------------
# Define showVersion
#------------------------------------------------

showVersion()
{
  echo "1.0.0"
}

#------------------------------------------------
# Define available options
#------------------------------------------------

while getopts :c:f:t: option
do
  case "${option}" in
    c ) COMPONENT_NAME=${OPTARG};;
    f ) FILETYPE=${OPTARG};;
    t ) TARGET=${OPTARG};;
    ? ) helpFunction ;; # Print help function in case flag is not available
  esac
done

# Print helpFunction in case parameters are empty
if [ -z "$COMPONENT_NAME" ]
then
   echo -e "Component name parameter has to be set\n";
   helpFunction
fi

# Set file type
if [ -n "$FILETYPE" ]
  then
    FILETYPE="${FILETYPE}"
  else
    FILETYPE=".tsx"
fi

# Set target directory
if [ -n "$TARGET" ]
  then
    TARGETDIR="${TARGET}"
  else
    TARGETDIR="./src/components"
fi

cd ${TARGETDIR}
mkdir $COMPONENT_NAME
cd $COMPONENT_NAME

#------------------------------------------------
# Create component template
#------------------------------------------------

touch "index.${FILETYPE}"

cat > index.${FILETYPE} <<EOF

import styled from 'styled-components'

const ${COMPONENT_NAME} = styled('div')\`
\`

${COMPONENT_NAME}.displayName = '${COMPONENT_NAME}'

export default ${COMPONENT_NAME}

EOF

#------------------------------------------------
# Create story template for component
#------------------------------------------------

touch "index.stories.${FILETYPE}"

cat > index.stories.${FILETYPE} <<EOF

import React from 'react'
import { storiesOf } from '@storybook/react'
import { action } from '@storybook/addon-actions'

import ${COMPONENT_NAME} from './'

storiesOf('${COMPONENT_NAME}', module)
  .add('Story name', () => (
    <${COMPONENT_NAME}></${COMPONENT_NAME}>
  ))

EOF

#------------------------------------------------
# Create test template for component
#------------------------------------------------

touch "index.test.${FILETYPE}"

cat > index.test.${FILETYPE} <<EOF

import React from 'react';
import ReactDOM from 'react-dom';
import ${COMPONENT_NAME} from './';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<${COMPONENT_NAME}></${COMPONENT_NAME}>, div);
});

EOF
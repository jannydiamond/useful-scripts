# Create components
A small script to create react components as styled components written as a shell script and in nim.

## Usage

Usage of create-component.sh when in the same directory:
```bash
./create-component.sh -c componentName -f filetype -t target
```

Usage of create-component.sh when added to your PATH:
```bash
create-component -c componentName -f filetype -t target
```

| Command | Description                 | Default          | Required |
| ------- | --------------------------- | ---------------- |:--------:|
| -c      | component name in camelCase | -                | x        |
| -f      | filetype                    | .tsx             |          |
| -t      | target path                 | ./src/components |          |


The following items will be created:
- Directory with the name of the component given, e.g. Link
  - index.tsx
  - index.stories.tsx
  - index.test.tsx

The files have the following templates:

__index.tsx__
```javascript
import styled from 'styled-components'

const Link = styled('div')`
`

Link.displayName = 'Link'

export default Link
```

__index.stories.tsx__
```javascript
import React from 'react'
import { storiesOf } from '@storybook/react'
import { action } from '@storybook/addon-actions'

import Link from './'

storiesOf('Link', module)
  .add('Story name', () => (
    <Link></Link>
  ))
```

__index.test.tsx__
```javascript
import React from 'react';
import ReactDOM from 'react-dom';
import Link from './';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<Link></Link>, div);
});
```

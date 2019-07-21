import React from 'react';
import { Router, Stack, Scene } from 'react-native-router-flux';
import Homepage from './src/Homepage';
import EditImagePage from './src/EditImagePage';

const options = {
  title: 'Pick a photo',
  storageOptions: {
    skipBackup: true,
    path: 'images',
  },
};


const App = () => {
  return (
    <Router>
      <Stack key="root">
        <Scene key="homepage" component={Homepage} initial />
        <Scene key="editImage" component={EditImagePage} />
      </Stack>
    </Router>
  );
};


export default App;

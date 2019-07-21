/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Fragment} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  View,
  TouchableOpacity,
  Text,
  Image,
  StatusBar
} from 'react-native';
import ImagePicker from 'react-native-image-picker';
import { Actions } from 'react-native-router-flux';

const options = {
  title: 'Pick a photo',
  storageOptions: {
    skipBackup: true,
    path: 'images',
  },
};


const Homepage = () => {
  return (
    <Fragment>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView>
        <View style={styles.buttonContainer}>
          <TouchableOpacity 
            onPress={() => ImagePicker.showImagePicker(options, (response) => {
              console.log('Response = ', response);

              if (response.didCancel) {
                console.log('User cancelled image picker');
              } else if (response.error) {
                console.log('ImagePicker Error: ', response.error);
              } else {
                const source = { uri: response.uri };

                // You can also display the image using data:
                // const source = { uri: 'data:image/jpeg;base64,' + response.data };
                Actions.editImage( {config: { imageURL: response.uri}} )
                this.setState({
                  avatarSource: source,
                });
              }
          }) } 
            style={styles.button}
          >
            <Text style={styles.buttonText}>
            pick a photo
            </Text>
          </TouchableOpacity>
        </View>
      </SafeAreaView>
    </Fragment>
  );
};

const styles = StyleSheet.create({
  buttonContainer: {
    marginTop: 100,
    alignItems: "center"
  },
  button: {
    backgroundColor: "#76a936",
    marginLeft: 5,
    marginRight: 5,
    borderRadius: 5
  },
  buttonText: {
    alignSelf: "center",
    marginTop: 5,
    marginBottom: 5,
    marginLeft: 10,
    marginRight: 10
  }
});


export default Homepage;

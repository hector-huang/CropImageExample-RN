import React, { Component } from 'react'
import { requireNativeComponent } from 'react-native'
import PropTypes from 'prop-types';

type Props = {
	config: { imageURL: String },
	type?: Object
}

export default class EditImagePage extends Component<any, Props, any> {
	render() {
		return <EditImageView style={this.props.style} {...this.props} />
	}
}

EditImagePage.propTypes = {
	config: PropTypes.shape({ imageURL: PropTypes.String }).isRequired
}

const EditImageView = requireNativeComponent('EditImageView', EditImageView)
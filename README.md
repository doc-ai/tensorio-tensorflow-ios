# TensorIOTensorFlow

Unofficial TensorFlow cocoapod for iOS with support for inference, evaluation, and training. Pod targets simluator and arm64 devices only (iOS 12.0+) with full support for training MobileNetV2 models on device. We use this pod in [TensorIO](https://github.com/doc-ai/tensorio-ios).

- Latest: v1.15.1
- TensorFlow Build: r1.15

The major.minor version number of this pod tracks the major.minor version of the build of TensorFlow it includes. We reserve our patch numbers for our own changes to the build, which  normally involves whitelisting additinal ops to support new models.

## Requirements

- Xcode 10.0+
- iOS 9.3+

## Installation

TensorIOTensorFlow is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'TensorIOTensorFlow'
```

## Notes

Based on doc.ai's [tensorflow-ios-framework](https://github.com/doc-ai/tensorflow-ios-framework), this pod vends all the headers required to use TensorFlow in your project as well as the following static libraries:

- [tensorflow.a](https://storage.googleapis.com/tensorio-build/r1.15/tensorflow)
- [libprotobuf.a](https://storage.googleapis.com/tensorio-build/r1.15/libprotobuf)
- [libnsync.a](https://storage.googleapis.com/tensorio-build/r1.15/nsync)

See additional instructions below to use this code with a saved model.

## Saved Models

To use this build with a saved model, add the files in the *saved_model* directory of this repository to your project. You may then use a saved model as follows:

```c++
#include "loader.h"
#include "tag_constants.h"
#include "tensorflow/core/public/session.h"

using namespace tensorflow;

void load_saved_model(std::string model_dir) {
	SavedModelBundle bundle;
	SessionOptions session_opts;
	RunOptions run_opts;
	
	MetaGraphDef meta_graph_def;
	Session* session;
	
	const std::unordered_set<std::string> tags = {kSavedModelTagTrain};
	
	TF_CHECK_OK(LoadSavedModel(session_opts, run_opts, model_dir, tags, &bundle));
	meta_graph_def = bundle.meta_graph_def;
	session = bundle.session.get();
	
	// use the meta_graph_def
	// run the session
}
```

There is an [open issue](https://github.com/doc-ai/tensorflow-ios-framework/issues/3) at the [tensorflow-ios-framework](https://github.com/doc-ai/tensorflow-ios-framework) to include these files in the TensorFlow build.

## Build

Build this pod from scratch with the *build.sh* script in this repository.

## Author

doc.ai

## License

TensorIOTensorFlow is available under the Apache 2.0 license. See the LICENSE file for more info.

# TensorIOTensorFlow

Unofficial TensorFlow cocoapod for iOS with support for inference, evaluation, and training. We use this pod in [TensorIO](https://github.com/doc-ai/tensorio-ios).

Build: TensorFlow 1.13rc2.

## Requirements

- Xcode 10.0+
- iOS 9.3+

## Installation

TensorIOTensorFlow is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'TensorIOTensorFlow'
```

<span stype="color:red">**NOTE (VERSION 0.2.0)**</span>

Version 0.2.0 of the pod is not currently available via Cocoapods directly due to an error validating pods with files larger than 2GB. Instead you'll need to install a previous version of the pod and swap out the tensorflow static library.

Install a previous version of the pod with:

```ruby
pod 'TensorIOTensorFlow', '~> 0.1.1'
```

Download the [v0.2.0 packaged source](https://storage.cloud.google.com/tensorio-build/TensorIO-TensorFlow-1.13_0.2.0.tar.gz), unzip it, and find the ./Frameworks/tensorflow.framework/tensorflow file in that directory. In your project's Pods directory, replace ./TensorIOTensorFlow/Frameworks/tensorflow.framework/tensorflow with that file.

## Notes

Based on doc.ai's [tensorflow-ios-framework](https://github.com/doc-ai/tensorflow-ios-framework), this pod vends all the headers required to use TensorFlow in your project as well as the following static libraries:

- [tensorflow.a](https://storage.googleapis.com/tensorio-build/tensorflow)
- [libprotobuf.a](https://storage.googleapis.com/tensorio-build/libprotobuf)
- [libnsync.a](https://storage.googleapis.com/tensorio-build/nsync)

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

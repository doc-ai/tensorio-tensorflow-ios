# TensorIOTensorFlow

Unofficial TensorFlow build for iOS with support for inference, evaluation, and training. 

## Requirements

- Xcode 10.0+
- iOS 9.3+

## Installation

TensorIOTensorFlow is available through [CocoaPods](https://cocoapods.org). During this development phase, install it via the podspect in this repository directly:

```ruby
pod 'TensorIOTensorFlow', podspec: 'https://raw.githubusercontent.com/doc-ai/tensorio-tensorflow-ios/master/TensorIOTensorFlow.podspec'
```

<!--To install it, simply add the following line to your Podfile:

```ruby
pod 'TensorIOTensorFlow'
```
-->

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

## Author

doc.ai

## License

TensorIOTensorFlow is available under the Apache 2.0 license. See the LICENSE file for more info.

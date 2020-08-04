# TensorIOTensorFlow

Unofficial TensorFlow cocoapod for iOS with support for inference, evaluation, and training. Pod targets simluator and arm64 devices only (iOS 12.0+) with full support for training MobileNetV2 models on device. We use this pod in [TensorIO](https://github.com/doc-ai/tensorio-ios).

- Latest: v2.0.4
- TensorFlow Build: r2.0, v2.0.2

The major.minor version number of this pod tracks the major.minor version of the build of TensorFlow it includes. We reserve our patch numbers for our own changes to the build, which  normally involves whitelisting additinal ops to support new models.

## Requirements

- Xcode 10.0+
- iOS 12.0+

## Installation

TensorIOTensorFlow is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'TensorIOTensorFlow'
```

## Notes

Based on doc.ai's [tensorflow-ios-framework](https://github.com/doc-ai/tensorflow-ios-framework), this pod vends all the headers required to use TensorFlow in your project as well as the following static libraries:

- [tensorflow.a](https://storage.googleapis.com/tensorio-build/r2.0/tensorflow)
- [libprotobuf.a](https://storage.googleapis.com/tensorio-build/r2.0/libprotobuf)
- [libnsync.a](https://storage.googleapis.com/tensorio-build/r2.0/nsync)

For projects that use this pod be sure to add the following to your header search paths and linker flags:

**Header Search Paths:**

```
${PODS_ROOT}/TensorIOTensorFlow/Frameworks/tensorflow.framework/Headers
```

**Linker Flags:**

```
-force_load "${PODS_ROOT}/TensorIOTensorFlow/Frameworks/tensorflow.framework/tensorflow"
```

If you are using Tensor/IO with this backend, these are already added to your project. If you are developing your own pod with TensorIOTensorFlow as a dependency, you can add the following to your podspec to do this automatically:

```rb
s.xcconfig = {
  'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/TensorIOTensorFlow/Frameworks/tensorflow.framework/Headers"',
  'OTHER_LDFLAGS' => '-force_load "${PODS_ROOT}/TensorIOTensorFlow/Frameworks/tensorflow.framework/tensorflow"'
}
```

## Build

Build this pod from scratch with the *build.sh* script in this repository.

## Author

doc.ai

## License

TensorIOTensorFlow is available under the Apache 2.0 license. See the LICENSE file for more info.

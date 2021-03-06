#
# Be sure to run `pod lib lint TensorIOTensorFlow.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TensorIOTensorFlow'
  s.version          = '2.0.9'
  s.summary          = 'The TensorFlow (unofficial) build used by TensorIO for iOS.'
  s.description      = 'An unofficial build of TensorFlow for iOS used by TensorIO, supporting inference, evaluation, and training.'
  s.homepage         = 'https://github.com/doc-ai/tensorio-tensorflow-ios'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'doc.ai' => 'philip@doc.ai' }
  s.source           = { :http => 'https://storage.googleapis.com/tensorio-build/ios/release/2.0/xcodebuild/12C33/tag/2.0.9/pod/TensorIO-TensorFlow-2.0_9.tar.gz' }

  s.ios.deployment_target = '12.0'
  s.library = 'c++'

  s.frameworks = 'Foundation', 'Accelerate'
  
  s.vendored_frameworks = [ 
    'Frameworks/tensorflow.framework'
  ]
  s.vendored_libraries = [
    'Libraries/libnsync.a',
    'Libraries/libprotobuf.a'
  ]

  # Xcode 12.2 build fix
  # https://stackoverflow.com/questions/63607158/xcode-12-building-for-ios-simulator-but-linking-in-object-file-built-for-ios
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end

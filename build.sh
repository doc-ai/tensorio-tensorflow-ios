#! /bin/sh

##
## Builds the TensorIOTensorFlow Cocoapod 
## 

# Variables

LIB_URL=https://storage.googleapis.com/tensorio-build/ios/release/2.0/xcodebuild/12B45b/tag/2.0.7/lib

LIB_TENSORFLOW_URL=$LIB_URL/libtensorflow-core.a    # -> tensorflow
LIB_PROTOBUF_URL=$LIB_URL/libprotobuf.a             # -> libprotobuf.a
LIB_NSYNC_URL=$LIB_URL/nsync.a                      # -> libnsync.a

TENSORFLOW_IOS_FRAMEWORK_URL=git@github.com:doc-ai/tensorflow-ios-framework.git

POD_DIR=TensorIOTensorFlow
FRAMEWORK_DIR=$POD_DIR/Frameworks
TENSORFLOW_FRAMEWORK_DIR=$FRAMEWORK_DIR/tensorflow.framework
LIBRARIES_DIR=$POD_DIR/Libraries
DUMMY_TXT=$POD_DIR/dummy.txt

# Script directory and working temp directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR=`mktemp -d`

# Check if tmp dir was created

if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temp dir"
  exit 1
fi

# Deletes the temp directory

function cleanup {      
  rm -rf "$WORK_DIR"
}

# Register the cleanup function to be called on the EXIT signal

trap cleanup EXIT

# Create pod

echo "Creating directory structure"

mkdir $POD_DIR
mkdir $FRAMEWORK_DIR
mkdir $TENSORFLOW_FRAMEWORK_DIR
mkdir $LIBRARIES_DIR

echo "Adding dummy.txt"

touch $DUMMY_TXT
echo "This is a work around for file flattening introduced by https://github.com/CocoaPods/CocoaPods/pull/728" > $DUMMY_TXT

echo "Cloning tensorflow framework"

cd $WORK_DIR
git clone git@github.com:doc-ai/tensorflow-ios-framework.git
cd $SCRIPT_DIR
cp -r $WORK_DIR/tensorflow-ios-framework/tensorflow.framework/ $TENSORFLOW_FRAMEWORK_DIR

echo "Downloading tensorflow static library"

cd $SCRIPT_DIR/$TENSORFLOW_FRAMEWORK_DIR
curl -o tensorflow $LIB_TENSORFLOW_URL

echo "Download libprotobuf and libnsync static libraries"

cd $SCRIPT_DIR/$LIBRARIES_DIR
curl -o libprotobuf.a $LIB_PROTOBUF_URL
curl -o libnsync.a $LIB_NSYNC_URL

echo "Build complete, cleaning up"

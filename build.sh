#!/bin/sh

rm -rf build

# iOS devices
xcodebuild archive \
  -scheme BubbleTask \
  -archivePath "build/ios.xcarchive" \
  -destination generic/platform=iOS \
  -sdk iphoneos \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# iOS simulator
xcodebuild archive \
  -scheme BubbleTask \
  -archivePath "build/ios-simulator.xcarchive" \
  -destination "generic/platform=iOS simulator" \
  -sdk iphonesimulator \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
  -framework "build/ios.xcarchive/Products/Library/Frameworks/BubbleTask.framework" \
  -framework "build/ios-simulator.xcarchive/Products/Library/Frameworks/BubbleTask.framework" \
  -output "./BubbleTask.xcframework"
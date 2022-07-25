// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CMPush",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CMPush",
            targets: ["CMPush"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets:[
		.binaryTarget(name: "CMPush", url: "https://github.com/cmdotcom/text-push-library-ios/raw/v2.0.0/CMPush.xcframework.zip", checksum: "efaa8a66c28397fb5a2c888a37de17caa3a8c506b50034c0f592c2ee5e328a64")
	])

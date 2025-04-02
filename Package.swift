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
		.binaryTarget(name: "CMPush", url: "https://github.com/cmdotcom/text-push-library-ios/raw/v2.1.0/CMPush.xcframework.zip", checksum: "971430282e5cdb6f223093a4af2e756ff24e445bbeedb4df054d6b7547fcdaa6")
	])

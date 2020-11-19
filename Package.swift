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
		.binaryTarget(name: "CMPush", url: "https://www.cm.com/cdn/packages/push/CMPush.xcframework.zip", checksum: "676a4b6d1d51cd10979d1902919f82fa3d4a04b9c2ce5871bdc85d1e2ddfd93e")
	])

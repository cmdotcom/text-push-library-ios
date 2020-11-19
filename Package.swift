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
        .binaryTarget(name: "CMPush", url: "https://github.com/cmdotcom/text-push-library-ios/raw/main/CMPush.xcframework.zip", checksum: "5b09862e77be7e1b802679eed01136f4d1919a47563ce012c226f488a6f411ea")
        ])
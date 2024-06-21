// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShellScriptSwiftRunner",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "s3r", targets: ["s3r"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.4.0")
    ],
    targets: [
        .executableTarget(
            name: "s3r",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .testTarget(
            name: "Tests",
            dependencies: ["s3r"],
            resources: [
                .copy("success_scripts")
            ]
        )
    ]
)

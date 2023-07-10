// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VendorPackages",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "VendorPackages",
            targets: ["VendorPackages"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/devicekit/DeviceKit.git",
            exact: "5.0.0"
        ),
        .package(
            url: "https://github.com/kean/Nuke.git",
            exact: "12.1.2"
        ),
        .package(
            url: "https://github.com/groue/GRDB.swift.git",
            exact: "6.15.1"
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit",
            exact: "5.6.0"
        ),
        .package(
            url: "https://github.com/airbnb/lottie-ios",
            exact: "4.2.0"
        ),
    ],
    targets: [
        .target(
            name: "VendorPackages",
            dependencies: [
                "DeviceKit",
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "NukeUI", package: "Nuke"),
                .product(name: "NukeExtensions", package: "Nuke"),
                "SnapKit",
                .product(name: "GRDB", package: "GRDB.swift"),
                .product(name: "Lottie", package: "lottie-ios"),
            ]
        ),
    ]
)

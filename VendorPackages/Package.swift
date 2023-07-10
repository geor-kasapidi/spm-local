// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VendorPackages",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(name: "DeviceKit", targets: ["DeviceKit"]),
        .library(name: "GRDB", targets: ["GRDB"]),
        .library(name: "Lottie", targets: ["Lottie"]),
        .library(name: "Nuke", targets: ["Nuke"]),
        .library(name: "NukeUI", targets: ["NukeUI"]),
        .library(name: "NukeExtensions", targets: ["NukeExtensions"]),
        .library(name: "SnapKit", targets: ["SnapKit"]),
    ],
    targets: [
        .target(
            name: "DeviceKit",
            path: "Sources/DeviceKit/Source"
        ),
        .target(
            name: "Nuke",
            path: "Sources/Nuke/Sources/Nuke"
        ),
        .target(
            name: "NukeUI",
            dependencies: ["Nuke"],
            path: "Sources/Nuke/Sources/NukeUI"
        ),
        .target(
            name: "NukeExtensions",
            dependencies: ["Nuke"],
            path: "Sources/Nuke/Sources/NukeExtensions"
        ),
        .target(
            name: "GRDB",
            dependencies: ["CSQLite"],
            path: "Sources/GRDB.swift/GRDB"
        ),
        .systemLibrary(
            name: "CSQLite",
            path: "Sources/GRDB.swift/Sources/CSQLite"
        ),
        .target(
            name: "Lottie",
            path: "Sources/lottie-ios/Sources"
        ),
        .target(
            name: "SnapKit",
            path: "Sources/SnapKit/Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

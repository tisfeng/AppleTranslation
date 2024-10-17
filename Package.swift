// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "AppleTranslation",
    products: [
        .library(
            name: "AppleTranslation",
            targets: ["AppleTranslation"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AppleTranslation",
            dependencies: []
        ),
        .testTarget(
            name: "AppleTranslationTests",
            dependencies: ["AppleTranslation"]
        )
    ]
)

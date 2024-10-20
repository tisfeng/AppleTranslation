// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "AppleTranslation",
    products: [
        .library(
            name: "AppleTranslation",
            targets: ["AppleTranslation"]
        )
    ],
    targets: [
        .target(
            name: "AppleTranslation"
        ),
        .testTarget(
            name: "AppleTranslationTests",
            dependencies: ["AppleTranslation"]
        ),
    ]
)

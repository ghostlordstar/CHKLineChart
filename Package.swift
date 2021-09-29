// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "CHKLineChartKit",

    products: [
        .library(name: "CHKLineChartKit", type: .static, targets: ["CHKLineChartKit"]),
    ],
    targets: [
        .target(
            name: "CHKLineChartKit",
            path: "Sources"
            )
    ],
    swiftLanguageVersions: [4]
)

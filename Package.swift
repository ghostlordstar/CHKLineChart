// swift-tools-version:5.5.0
import PackageDescription

let package = Package(
    name: "CHKLineChartKit",

    platforms: [.iOS(.v9)],
    products: [
        .library(name: "CHKLineChartKit", type: .static, targets: ["CHKLineChartKit"]),
    ],
    targets: [
        .target(
            name: "CHKLineChartKit",
            path: "Sources"
            )
    ],
    swiftLanguageVersions: [.v4]
)

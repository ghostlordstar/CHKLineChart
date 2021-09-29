// swift-tools-version:5.3
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
    swiftLanguageVersions: [.v4,.v4_2,.v5]
)

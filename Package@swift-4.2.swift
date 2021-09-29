// swift-tools-version:4.2
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
    swiftLanguageVersions: [.v4,.v4_2]
)

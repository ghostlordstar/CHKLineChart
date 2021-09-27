
import PackageDescription

let package = Package(
    name: "CHKLineChartKit",

    platforms: [.iOS(.v9)],
    products: [
        .executable(name: "CHKLineChartKit", targets: ["CHKLineChartKit"]),
    ],
    targets: [
        .target(
            name: "CHKLineChartKit",
            path: "Sources"
    ]
)
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SQLite.swift",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .watchOS(.v4),
        .tvOS(.v11),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SQLite",
            targets: ["SQLite"]
        )
    ],
    dependencies: [
        .package(path: "../SQLCipher")
    ],
    targets: [
        .target(
            name: "SQLite",
            dependencies: [
                "SQLCipher"
            ],
            exclude: [
                "Info.plist"
            ],
            cSettings: [
                .define("SQLITE_HAS_CODEC", to:"1"),
                .define("SQLITE_TEMP_STORE", to:"3"),
                .define("SQLCIPHER_CRYPTO_CC", to:nil),
                .define("NDEBUG", to:"1")
            ],
            swiftSettings: [
                .define("SQLITE_HAS_CODEC"),
                .define("SQLITE_SWIFT_SQLCIPHER")
            ]
        ),
        .testTarget(
            name: "SQLiteTests",
            dependencies: [
                "SQLite"
            ],
            path: "Tests/SQLiteTests",
            exclude: [
                "Info.plist"
            ],
            resources: [
                .copy("Resources")
            ]
        )
    ]
)

#if os(Linux)
package.dependencies = [
    .package(url: "https://github.com/stephencelis/CSQLite.git", from: "0.0.3")
]
package.targets.first?.dependencies += [
    .product(name: "CSQLite", package: "CSQLite")
]
#endif

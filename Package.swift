// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "itmo-computer-system-architecture-lab1",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .executable(
      name: "TranslatorApp",
      targets: ["TranslatorApp"]),
    .executable(
      name: "MachineApp",
      targets: ["MachineApp"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.13.0"),
    .package(url: "https://github.com/apple/swift-testing.git", branch: "main"),
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.14.0"),
  ],
  targets: [
    .target(
      name: "Translator",
      dependencies: [
        .product(name: "Parsing", package: "swift-parsing")
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .testTarget(
      name: "TranslatorTests",
      dependencies: [
        "Translator",
        .product(name: "Testing", package: "swift-testing"),
        .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .executableTarget(
      name: "TranslatorApp",
      dependencies: [
        "Translator",
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .executableTarget(
      name: "MachineApp",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
  ]
)

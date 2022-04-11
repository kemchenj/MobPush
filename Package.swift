// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "MobPush",
  platforms: [.iOS(.v13)],
  products: [
    .library(name: "MobPush", targets: ["MobPushWrapper"]),
    .library(name: "MobPushServiceExtension", targets: ["MobPushServiceExtensionWrapper"]),
  ],
  targets: [
    // MobPush depends on c++, but binary target could not have linkerSettings
    // Firebase team use a dummy target in their SDK so we do the same thing here
    // discussion: https://forums.swift.org/t/binary-frameworks-with-swiftpm/26225/17
    .target(
      name: "MobPushWrapper",
      dependencies: ["MobPush", "MOBFoundation"],
      linkerSettings: [
        .linkedLibrary("c++"),
      ]
    ),
    .target(
      name: "MobPushServiceExtensionWrapper",
      dependencies: ["MobPushServiceExtension"],
      linkerSettings: [
        .linkedLibrary("c++"),
      ]
    ),

    .binaryTarget(
      name: "MOBFoundation",
      url: "https://github.com/kemchenj/MobPush/releases/download/4.2.0/MOBFoundation.xcframework.zip",
      checksum: "8246db8f39da2bfe67c2c30d3cdcde9e9f5ea194710eff32032d9c7f6d95c51d"
    ),
    .binaryTarget(
      name: "MobPush",
      url: "https://github.com/kemchenj/MobPush/releases/download/4.2.0/MobPush.xcframework.zip",
      checksum: "fa16101451de70263d7f71cb441058a5c2d855a3192ad865b302e839417aa718"
    ),
    .binaryTarget(
      name: "MobPushServiceExtension",
      url: "https://github.com/kemchenj/MobPush/releases/download/4.2.0/MobPushServiceExtension.xcframework.zip",
      checksum: "205b02acedf69dca7390c5efdcd0fbd3262eb4772b5358e312e11f09803806f4"
    ),
  ]
)

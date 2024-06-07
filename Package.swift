// swift-tools-version:5.5

import PackageDescription

let package = Package(
	name: "Neon",
	platforms: [.macOS(.v10_13), .iOS(.v11), .tvOS(.v11), .watchOS(.v4)],
	products: [
		.library(name: "Neon", targets: ["Neon"]),
	],
	dependencies: [
		.package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", revision: "a9b1335d5151b62b11f07599bd07d07dc5965de3"),
		.package(url: "https://github.com/ChimeHQ/Rearrange", from: "1.8.1"),
	],
	targets: [
		.target(name: "Neon", dependencies: ["SwiftTreeSitter", "Rearrange", "TreeSitterClient"]),
		.target(name: "TreeSitterClient", dependencies: ["Rearrange", "SwiftTreeSitter"]),
		.target(name: "TestTreeSitterSwift",
				path: "tree-sitter-swift",
				sources: ["src/parser.c", "src/scanner.c"],
				publicHeadersPath: "bindings/swift",
				cSettings: [.headerSearchPath("src")]),
		.testTarget(name: "NeonTests", dependencies: ["Neon"]),
		.testTarget(name: "TreeSitterClientTests", dependencies: ["TreeSitterClient", "TestTreeSitterSwift"])
	]
)

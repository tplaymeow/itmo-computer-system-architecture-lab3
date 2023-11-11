import ArgumentParser
import Foundation
import Translator

@main
struct TranslatorApp: ParsableCommand {
  @Option(
    name: .shortAndLong,
    help: "Output file with machine code",
    transform: URL.init(fileURLWithPath:))
  var output: URL?

  @Argument(
    help: "Input file with source code",
    transform: URL.init(fileURLWithPath:))
  var input: URL

  func run() throws {
    let data = try Data(contentsOf: self.input)
    try Translator.run(data: data)
  }
}

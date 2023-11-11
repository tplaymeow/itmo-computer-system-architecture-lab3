import InlineSnapshotTesting
import Testing

@testable import Translator

@Suite
struct AtomParesrsTests {
  @Suite
  struct StringLiterals {
    @Test(arguments: [
      (#""Hello world""#, #"Hello world"#),
      (#""""#, #""#),
      (#""1\"\\n\\t\\r\\""#, #"1"\n\t\r\"#),
      (#""\\""#, #"\"#),
    ])
    func sucess(input: String, reference: String) throws {
      #expect(try StringLiteralParser().parse(input).value == reference)
    }

    @Test(arguments: [
      #""Hello world"#, #"Hello world""#, #""\""#, #""\\\""#,
    ])
    func failure(input: String) throws {
      #expect(throws: (any Error).self) {
        try StringLiteralParser().parse(input)
      }
    }
  }

  @Suite
  struct IntegerLiterals {
    @Test(arguments: [
      ("100", 100),
      ("100", 100),
      ("0", 0),
      ("+0", 0),
      ("000", 0),
      ("-0", 0),
      ("-100", -100),
    ])
    func sucess(input: String, reference: Int32) throws {
      #expect(try IntegerLiteralParser().parse(input).value == reference)
    }

    @Test(arguments: [
      "Hello", "12H", "_12", "12_", "One", "2k", "1 234 200",
    ])
    func failure(input: String) throws {
      #expect(throws: (any Error).self) {
        try IntegerLiteralParser().parse(input)
      }
    }
  }

  @Suite
  struct Identifiers {
    @Test(arguments: [
      "Hello", "hello", "h1", "H2", "a", "z", "A", "Z",
    ])
    func sucess(reference: String) throws {
      #expect(try IdentifierParser().parse(reference).value == reference)
    }

    @Test(arguments: [
      "1", "2a", "_hello", "_Hello", "hello world", "Переменная",
    ])
    func failure(input: String) throws {
      #expect(throws: (any Error).self) {
        try IdentifierParser().parse(input)
      }
    }
  }
}

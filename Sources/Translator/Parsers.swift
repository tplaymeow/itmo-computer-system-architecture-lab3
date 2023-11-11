import Parsing

struct IntegerLiteralParser: Parser {
  var body: some Parser<Substring.UTF8View, IntegerLiteral> {
    Parse(IntegerLiteral.init) {
      Int32.parser()
    }
  }
}

struct StringLiteralParser: Parser {
  var body: some Parser<Substring.UTF8View, StringLiteral> {
    Parse(StringLiteral.init) {
      "\"".utf8
      Many(into: "") { string, fragment in
        string.append(contentsOf: fragment)
      } element: {
        OneOf {
          Prefix(1...) { $0.isUnescapedStringByte }.map(.string)

          Parse {
            "\\".utf8
            OneOf {
              "\"".utf8.map { "\"" }
              "\\".utf8.map { "\\" }
              "n".utf8.map { "\n" }
              "r".utf8.map { "\r" }
              "t".utf8.map { "\t" }
            }
          }
        }
      } terminator: {
        "\"".utf8
      }
    }
  }
}

struct IdentifierParser: Parser {
  var body: some Parser<Substring.UTF8View, Identifier> {
    Consumed {
      Prefix(1) { $0.isAlpha }
      Prefix { $0.isAlpha || $0.isDigit }
    }
    .map(.string)
    .map(Identifier.init)
  }
}

struct NodeParser: Parser {
  var body: some Parser<Substring.UTF8View, Node> {
    OneOf {
      IntegerLiteralParser().map { Node.integer($0) }
      IdentifierParser().map { .identifier($0) }
      StringLiteralParser().map { .string($0) }
      ExpressionParser().map { .expression($0) }
    }
  }
}

struct ExpressionParser: Parser {
  var body: some Parser<Substring.UTF8View, Expression> {
    Parse(Expression.init) {
      "(".utf8
      Many {
        NodeParser()
      } separator: {
        Whitespace(1...)
      } terminator: {
        ")".utf8
      }
    }
  }
}

struct FileParser: Parser {
  var body: some Parser<Substring.UTF8View, File> {
    Parse(File.init) {
      Whitespace()
      Many {
        ExpressionParser()
      } separator: {
        Whitespace()
      } terminator: {
        Whitespace()
        End()
      }
    }
  }
}

extension UTF8.CodeUnit {
  @inline(__always)
  fileprivate var isUnescapedStringByte: Bool {
    self != .init(ascii: "\"") && self != .init(ascii: "\\") && self >= .init(ascii: " ")
  }

  @inline(__always)
  fileprivate var isDigit: Bool {
    (.init(ascii: "0") ... .init(ascii: "9")) ~= self
  }

  @inline(__always)
  fileprivate var isAlpha: Bool {
    (.init(ascii: "a") ... .init(ascii: "z")) ~= self
      || (.init(ascii: "A") ... .init(ascii: "Z")) ~= self
  }
}

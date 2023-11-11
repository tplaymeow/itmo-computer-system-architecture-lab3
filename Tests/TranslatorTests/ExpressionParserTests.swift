import InlineSnapshotTesting
import Testing

@testable import Translator

@Suite
struct ExpressionParserTests {
  let parser = ExpressionParser()

  @Test
  func oneNode() throws {
    assertInlineSnapshot(
      of: try self.parser.parse("(hello)"),
      as: .dump
    ) {
      """
      ▿ Expression
        ▿ nodes: 1 element
          ▿ Node
            ▿ identifier: Identifier
              - value: "hello"

      """
    }

    assertInlineSnapshot(
      of: try self.parser.parse(#"("hello")"#),
      as: .dump
    ) {
      """
      ▿ Expression
        ▿ nodes: 1 element
          ▿ Node
            ▿ string: StringLiteral
              - value: "hello"

      """
    }

    assertInlineSnapshot(
      of: try self.parser.parse("(123)"),
      as: .dump
    ) {
      """
      ▿ Expression
        ▿ nodes: 1 element
          ▿ Node
            ▿ integer: IntegerLiteral
              - value: 123

      """
    }
  }

  @Test
  func nestedNodes() {
    assertInlineSnapshot(
      of: try self.parser.parse("(((123)))"),
      as: .dump
    ) {
      """
      ▿ Expression
        ▿ nodes: 1 element
          ▿ Node
            ▿ expression: Expression
              ▿ nodes: 1 element
                ▿ Node
                  ▿ expression: Expression
                    ▿ nodes: 1 element
                      ▿ Node
                        ▿ integer: IntegerLiteral
                          - value: 123

      """
    }

    assertInlineSnapshot(
      of: try self.parser.parse(#"(123 ("123" (id123 hello)))"#),
      as: .dump
    ) {
      """
      ▿ Expression
        ▿ nodes: 2 elements
          ▿ Node
            ▿ integer: IntegerLiteral
              - value: 123
          ▿ Node
            ▿ expression: Expression
              ▿ nodes: 2 elements
                ▿ Node
                  ▿ string: StringLiteral
                    - value: "123"
                ▿ Node
                  ▿ expression: Expression
                    ▿ nodes: 2 elements
                      ▿ Node
                        ▿ identifier: Identifier
                          - value: "id123"
                      ▿ Node
                        ▿ identifier: Identifier
                          - value: "hello"

      """
    }

    assertInlineSnapshot(
      of: try self.parser.parse(
        """
        (defun fib (left right iteration)
          (if (equals 0 iteration)
            left
            (fib right (add right left) (subtract iteration 1))))
        """),
      as: .dump
    ) {
      """
      ▿ Expression
        ▿ nodes: 4 elements
          ▿ Node
            ▿ identifier: Identifier
              - value: "defun"
          ▿ Node
            ▿ identifier: Identifier
              - value: "fib"
          ▿ Node
            ▿ expression: Expression
              ▿ nodes: 3 elements
                ▿ Node
                  ▿ identifier: Identifier
                    - value: "left"
                ▿ Node
                  ▿ identifier: Identifier
                    - value: "right"
                ▿ Node
                  ▿ identifier: Identifier
                    - value: "iteration"
          ▿ Node
            ▿ expression: Expression
              ▿ nodes: 4 elements
                ▿ Node
                  ▿ identifier: Identifier
                    - value: "if"
                ▿ Node
                  ▿ expression: Expression
                    ▿ nodes: 3 elements
                      ▿ Node
                        ▿ identifier: Identifier
                          - value: "equals"
                      ▿ Node
                        ▿ integer: IntegerLiteral
                          - value: 0
                      ▿ Node
                        ▿ identifier: Identifier
                          - value: "iteration"
                ▿ Node
                  ▿ identifier: Identifier
                    - value: "left"
                ▿ Node
                  ▿ expression: Expression
                    ▿ nodes: 4 elements
                      ▿ Node
                        ▿ identifier: Identifier
                          - value: "fib"
                      ▿ Node
                        ▿ identifier: Identifier
                          - value: "right"
                      ▿ Node
                        ▿ expression: Expression
                          ▿ nodes: 3 elements
                            ▿ Node
                              ▿ identifier: Identifier
                                - value: "add"
                            ▿ Node
                              ▿ identifier: Identifier
                                - value: "right"
                            ▿ Node
                              ▿ identifier: Identifier
                                - value: "left"
                      ▿ Node
                        ▿ expression: Expression
                          ▿ nodes: 3 elements
                            ▿ Node
                              ▿ identifier: Identifier
                                - value: "subtract"
                            ▿ Node
                              ▿ identifier: Identifier
                                - value: "iteration"
                            ▿ Node
                              ▿ integer: IntegerLiteral
                                - value: 1

      """
    }
  }

  @Test
  func twoNodes() throws {
    assertInlineSnapshot(
      of: try self.parser.parse(#"(hello "world")"#),
      as: .dump
    ) {
      """
      ▿ Expression
        ▿ nodes: 2 elements
          ▿ Node
            ▿ identifier: Identifier
              - value: "hello"
          ▿ Node
            ▿ string: StringLiteral
              - value: "world"

      """
    }

    assertInlineSnapshot(
      of: try self.parser.parse("(hello\n123)"),
      as: .dump
    ) {
      """
      ▿ Expression
        ▿ nodes: 2 elements
          ▿ Node
            ▿ identifier: Identifier
              - value: "hello"
          ▿ Node
            ▿ integer: IntegerLiteral
              - value: 123

      """
    }

    assertInlineSnapshot(
      of: try self.parser.parse(#"(123 hello)"#),
      as: .dump
    ) {
      """
      ▿ Expression
        ▿ nodes: 2 elements
          ▿ Node
            ▿ integer: IntegerLiteral
              - value: 123
          ▿ Node
            ▿ identifier: Identifier
              - value: "hello"

      """
    }
  }
}

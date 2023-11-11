import InlineSnapshotTesting
import Testing

@testable import Translator

@Suite
struct FileParserTests {
  let parser = FileParser()

  @Test
  func problem2Solution() {
    assertInlineSnapshot(
      of: try self.parser.parse(
        """
        (defun fib (n)
          (cond ((eq n 0) 1)
                ((eq n 1) 1)
                (t (add (fib (sub n 1)) (fib (sub n 2))))))

        (defun evenret (n)
          (if (evenp n) n 0))

        (reduce add (mapcar evenret (mapcar fib (numslist 0 33 nil))))
        """
      ),
      as: .dump
    ) {
      """
      ▿ File
        ▿ expressions: 3 elements
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
                  ▿ nodes: 1 element
                    ▿ Node
                      ▿ identifier: Identifier
                        - value: "n"
              ▿ Node
                ▿ expression: Expression
                  ▿ nodes: 4 elements
                    ▿ Node
                      ▿ identifier: Identifier
                        - value: "cond"
                    ▿ Node
                      ▿ expression: Expression
                        ▿ nodes: 2 elements
                          ▿ Node
                            ▿ expression: Expression
                              ▿ nodes: 3 elements
                                ▿ Node
                                  ▿ identifier: Identifier
                                    - value: "eq"
                                ▿ Node
                                  ▿ identifier: Identifier
                                    - value: "n"
                                ▿ Node
                                  ▿ integer: IntegerLiteral
                                    - value: 0
                          ▿ Node
                            ▿ integer: IntegerLiteral
                              - value: 1
                    ▿ Node
                      ▿ expression: Expression
                        ▿ nodes: 2 elements
                          ▿ Node
                            ▿ expression: Expression
                              ▿ nodes: 3 elements
                                ▿ Node
                                  ▿ identifier: Identifier
                                    - value: "eq"
                                ▿ Node
                                  ▿ identifier: Identifier
                                    - value: "n"
                                ▿ Node
                                  ▿ integer: IntegerLiteral
                                    - value: 1
                          ▿ Node
                            ▿ integer: IntegerLiteral
                              - value: 1
                    ▿ Node
                      ▿ expression: Expression
                        ▿ nodes: 2 elements
                          ▿ Node
                            ▿ identifier: Identifier
                              - value: "t"
                          ▿ Node
                            ▿ expression: Expression
                              ▿ nodes: 3 elements
                                ▿ Node
                                  ▿ identifier: Identifier
                                    - value: "add"
                                ▿ Node
                                  ▿ expression: Expression
                                    ▿ nodes: 2 elements
                                      ▿ Node
                                        ▿ identifier: Identifier
                                          - value: "fib"
                                      ▿ Node
                                        ▿ expression: Expression
                                          ▿ nodes: 3 elements
                                            ▿ Node
                                              ▿ identifier: Identifier
                                                - value: "sub"
                                            ▿ Node
                                              ▿ identifier: Identifier
                                                - value: "n"
                                            ▿ Node
                                              ▿ integer: IntegerLiteral
                                                - value: 1
                                ▿ Node
                                  ▿ expression: Expression
                                    ▿ nodes: 2 elements
                                      ▿ Node
                                        ▿ identifier: Identifier
                                          - value: "fib"
                                      ▿ Node
                                        ▿ expression: Expression
                                          ▿ nodes: 3 elements
                                            ▿ Node
                                              ▿ identifier: Identifier
                                                - value: "sub"
                                            ▿ Node
                                              ▿ identifier: Identifier
                                                - value: "n"
                                            ▿ Node
                                              ▿ integer: IntegerLiteral
                                                - value: 2
          ▿ Expression
            ▿ nodes: 4 elements
              ▿ Node
                ▿ identifier: Identifier
                  - value: "defun"
              ▿ Node
                ▿ identifier: Identifier
                  - value: "evenret"
              ▿ Node
                ▿ expression: Expression
                  ▿ nodes: 1 element
                    ▿ Node
                      ▿ identifier: Identifier
                        - value: "n"
              ▿ Node
                ▿ expression: Expression
                  ▿ nodes: 4 elements
                    ▿ Node
                      ▿ identifier: Identifier
                        - value: "if"
                    ▿ Node
                      ▿ expression: Expression
                        ▿ nodes: 2 elements
                          ▿ Node
                            ▿ identifier: Identifier
                              - value: "evenp"
                          ▿ Node
                            ▿ identifier: Identifier
                              - value: "n"
                    ▿ Node
                      ▿ identifier: Identifier
                        - value: "n"
                    ▿ Node
                      ▿ integer: IntegerLiteral
                        - value: 0
          ▿ Expression
            ▿ nodes: 3 elements
              ▿ Node
                ▿ identifier: Identifier
                  - value: "reduce"
              ▿ Node
                ▿ identifier: Identifier
                  - value: "add"
              ▿ Node
                ▿ expression: Expression
                  ▿ nodes: 3 elements
                    ▿ Node
                      ▿ identifier: Identifier
                        - value: "mapcar"
                    ▿ Node
                      ▿ identifier: Identifier
                        - value: "evenret"
                    ▿ Node
                      ▿ expression: Expression
                        ▿ nodes: 3 elements
                          ▿ Node
                            ▿ identifier: Identifier
                              - value: "mapcar"
                          ▿ Node
                            ▿ identifier: Identifier
                              - value: "fib"
                          ▿ Node
                            ▿ expression: Expression
                              ▿ nodes: 4 elements
                                ▿ Node
                                  ▿ identifier: Identifier
                                    - value: "numslist"
                                ▿ Node
                                  ▿ integer: IntegerLiteral
                                    - value: 0
                                ▿ Node
                                  ▿ integer: IntegerLiteral
                                    - value: 33
                                ▿ Node
                                  ▿ identifier: Identifier
                                    - value: "nil"

      """
    }
  }
}

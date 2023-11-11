struct IntegerLiteral: Equatable, Codable {
  let value: Int32
}

struct StringLiteral: Equatable, Codable {
  let value: String
}

struct Identifier: Equatable, Codable {
  let value: String
}

struct Expression: Equatable, Codable {
  let nodes: [Node]
}

enum Node: Equatable, Codable {
  case integer(IntegerLiteral)
  case string(StringLiteral)
  case identifier(Identifier)
  case expression(Expression)
}

struct File {
  let expressions: [Expression]
}

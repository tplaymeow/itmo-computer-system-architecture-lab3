enum PrimitiveType {
  case integer
  case string
}

struct FunctionArgument {
  let name: String
  let type: PrimitiveType
}

struct FunctionDeclaration {
  let name: String
  let arguments: [FunctionArgument]
  let returnType: PrimitiveType
}

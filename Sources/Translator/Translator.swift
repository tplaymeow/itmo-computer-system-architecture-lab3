import Foundation

public enum Translator {
  public static func run(data: Data) throws {
    let parser = FileParser()
    let string = String(decoding: data, as: UTF8.self)
    print(try parser.parse(string))
  }
}

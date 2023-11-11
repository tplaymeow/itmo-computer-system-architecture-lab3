import ArgumentParser

@main
struct Machine: ParsableCommand {
  func run() throws {
    print("Hello from Machine!")
  }
}

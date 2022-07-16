import Foundation

protocol HttpGet {
  func get(to endPoint: String, with params: Data?) async throws -> BubbleTaskResponse
}

import Foundation

protocol HttpPost {
  func post(to endPoint: String, with body: Data?) async throws -> BubbleTaskResponse
}

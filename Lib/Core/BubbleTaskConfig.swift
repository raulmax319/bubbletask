import Foundation

public struct BubbleTaskConfig {
  var baseUrl: String
  var headers: [String: String]?
  var timeout: Int?
  var sessionConfiguration: URLSessionConfiguration
  
  public init(
    baseUrl: String,
    headers: [String: String]? = nil,
    timeout: Int? = 30,
    sessionConfiguration: URLSessionConfiguration = .default
  ) {
    self.baseUrl = baseUrl
    self.headers = headers
    self.timeout = timeout
    self.sessionConfiguration = sessionConfiguration
  }
}

import Foundation

public enum HttpError: Error {
  case invalidUrl(url: String)
  case invalidMethod
  case unexpected(response: URLResponse)
}

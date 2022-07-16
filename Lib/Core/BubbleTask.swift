import Foundation

public final class BubbleTask {
  private var config: BubbleTaskConfig

  public init(with config: BubbleTaskConfig) {
    self.config = config
  }
}

// MARK: - HttpGet
extension BubbleTask: HttpGet {
  public func get(to endPoint: String, with params: Data?) async throws -> BubbleTaskResponse {
    do {
      let request = try buildRequest(to: endPoint, with: params, method: .GET)
      return try await execute(request)
    } catch {
      let statusCode = (error as NSError).code
      return .init(statusCode: statusCode, headers: nil, body: nil, message: error.localizedDescription)
    }
  }
}

// MARK: - HttpPost
extension BubbleTask: HttpPost {
  public func post(to endPoint: String, with body: Data?) async throws -> BubbleTaskResponse {
    do {
      let request = try buildRequest(to: endPoint, with: body, method: .POST)
      return try await execute(request)
    } catch {
      let statusCode = (error as NSError).code
      return .init(statusCode: statusCode, headers: nil, body: nil, message: error.localizedDescription)
    }
  }
}

// MARK: - Private
extension BubbleTask {
  private func buildRequest(to endPoint: String, with body: Data? = nil, method: HttpMethod) throws -> URLRequest {
    guard let baseUrl = URL(string: "\(config.baseUrl)\(endPoint)") else {
      throw HttpError.invalidUrl(url: "\(config.baseUrl)\(endPoint)")
    }

    var request = URLRequest(url: baseUrl)
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = config.headers

    if let body = body {
      request.httpBody = body
    }
    
    return request
  }
  
  private func execute(_ request: URLRequest) async throws -> BubbleTaskResponse {
    let session = URLSession(configuration: config.sessionConfiguration)

    let (data, res) = try await session.data(for: request)
    
    guard let statusCode = (res as? HTTPURLResponse)?.statusCode,
          let headers = (res as? HTTPURLResponse)?.allHeaderFields
    else {
      throw HttpError.unexpected(response: res)
    }
    
    return .init(
      statusCode: statusCode,
      headers: headers,
      body: data,
      message: "OK"
    )
  }
}

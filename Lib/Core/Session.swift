//
//  Session.swift
//  BubbleTask
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

extension URLSession {
  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    try await withCheckedThrowingContinuation { continuation in
      let task = self.dataTask(with: request) { data, response, error in
        guard let data = data, let response = response, error == nil else {
          let error = error ?? URLError(.badServerResponse)
          return continuation.resume(throwing: error)
        }
        
        continuation.resume(returning: (data, response))
      }
      task.resume()
    }
  }
}

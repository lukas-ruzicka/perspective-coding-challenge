//
//  NetworkingService.swift
//  perspective-coding-challenge
//
//  Created by Lukas Ruzicka on 10.01.2023.
//

import Foundation

protocol NetworkingService {

    func request<Response: Decodable>(_ url: URL) async throws -> Response
}

final actor URLSessionNetworkingServiceImpl {

    // MARK: - Properties
    private let urlSession = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
}

// MARK: - Protocol conformance
extension URLSessionNetworkingServiceImpl: NetworkingService {

    func request<Response: Decodable>(_ url: URL) async throws -> Response {
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: urlRequest)
        return try decoder.decode(Response.self, from: data)
    }
}

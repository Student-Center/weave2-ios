//
//  ServiceClient.swift
//  NetworkKit
//
//  Created by 김지수 on 9/1/24.
//  Copyright © 2024 com.studentcenter. All rights reserved.
//

import Foundation
import OpenapiGenerated
import OpenAPIURLSession

let client = ServiceClient.client

struct ServiceClient {
    static let client = Client(
        serverURL: URL(string: ServerType.current.baseURL)!,
        transport: URLSessionTransport(),
        middlewares: [
            AuthenticationMiddleware(),
            RetryingMiddleware(),
            LoggingMiddleware()
        ]
    )
    
    private init() {}
}

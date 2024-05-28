//
//  EndPoints.swift
//  networking
//
//  Created by Nitesh Patil on 28/05/24.
//

import Foundation

protocol EndPoint {
    /*
     Example
     1. HTTPS or HTTP
     2. baseURL: "api.flicker.com"
     3. path: /services/rest
     4. parameters: [URLQueryItem(name: "api_key", value: API_KEY)]
     5. memthod: "GET"
     */
    var scheme: String { get }

    var baseURL: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
    var memthod: String { get }
}

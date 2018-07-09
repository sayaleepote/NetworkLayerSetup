//
//  EndpointList.swift
//  NetworkLayerSetup
//
//  Created by Sayalee on 7/8/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import Foundation

enum API: String {
    case api1 = "api1/string/value"
    case api2 = "api2/string/value"
    
    func getAPI(queryItems: [URLQueryItem] = [], headers: HTTPHeaders = [ : ], body: Data = Data()) -> Endpoint {
            return Endpoint(path: self.rawValue, httpMethod: .post, headers: headers, body: body, queryItems: queryItems)
    }
}

//
//  MyClient.swift
//  NetworkLayerSetup
//
//  Created by Sayalee on 7/9/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import Foundation

class MyClient: APIClient {
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //In the signature of the function we define the Class type that is the generic one in the API
    func getSomething(from endpoint: Endpoint, completion: @escaping (Result<Model2?, APIError>) -> Void) {
        
        let request = endpoint.request
        
        callAPI(with: request, decode: { json -> Model2? in
            guard let model2 = json as? Model2 else { return  nil }
            return model2
        }, completion: completion)
    }

}

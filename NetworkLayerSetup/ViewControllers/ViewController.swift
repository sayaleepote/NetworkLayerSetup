//
//  ViewController.swift
//  NetworkLayerSetup
//
//  Created by Sayalee on 7/8/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let client = MyClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI1()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK:- API Calls
    
    func callAPI1() {
        
        // Query item
        let queryItem = [ URLQueryItem(name: "keyName", value: "ValueName") ]
        
        /*
        // Body as string
        let bodyString = "yourParameterString"
        let body = bodyString.data(using: .utf8) */
        
        // Body as dictionary
        let parameters : [String : Any] = [ "key1" : "value1", "key2": "value2" ]
        guard let body = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        
        // Headers
        let headers: [String: String] = [ "Header-key1": "value1",
                                          "Header-key2": "value2" ]
        
        let api: API = .api1
        let endpoint: Endpoint = api.getAPI(queryItems: queryItem, headers: headers, body: body)
        
        client.getSomething(from: endpoint) { [weak self] result in
            switch result {
            case .success(let model2Result):
                guard let model2Result = model2Result?.results else { return }
                print(model2Result)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

}


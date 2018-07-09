//
//  Model1.swift, Model2.swift
//  NetworkLayerSetup
//
//  Created by Sayalee on 7/9/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import Foundation

struct Model1: Decodable {
    let key1: String?
    let key2: String?
    let key3: String?
    let key4: String?
    let key5: String?
    let key6: String?
}

struct Model2: Decodable {
    let results: [Model1]?
}

//
//  Result.swift
//  NetworkLayerSetup
//
//  Created by Sayalee on 7/8/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import Foundation

enum Result<T, E> where E: Error {
    case success(T)
    case failure(E)
}

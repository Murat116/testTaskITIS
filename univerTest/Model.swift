//
//  Model.swift
//  univerTest
//
//  Created by anmin on 25.07.2021.
//

import Foundation

struct User: Codable {
    var name: String
    var surname: String
    var mail: String
    var photo: Data
}

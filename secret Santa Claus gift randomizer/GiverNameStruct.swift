//
//  GiverNameStruct.swift
//  secret Santa Claus gift randomizer
//
//  Created by denys pashkov on 17/12/2019.
//  Copyright © 2019 denys pashkov. All rights reserved.
//
import Foundation
// MARK: - Gift
struct Gift: Codable {
    let records: [Record]
}

// MARK: - Record
struct Record: Codable {
    let id: String
    let fields: Fields
    let createdTime: String
}

// MARK: - Fields
struct Fields: Codable {
    let Name: String?

}

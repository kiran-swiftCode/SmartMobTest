//
//  DataRes.swift
//  SmartMobTest
//
//  Created by kiran on 5/1/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation

struct DataRes: Codable {
    let images: [Image]
}

struct Image: Codable {
    let id: Int
    let url: String
    let largeURL: String
    let sourceID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, url
        case largeURL = "large_url"
        case sourceID = "source_id"
    }
}


//MARK:- IMAGEDETAIL RESPONSE MODEL

struct ImageDetailRes: Codable {
    let id: Int
    let name, url: String
    let imageCount: Int
    let images: [Images]
    
    enum CodingKeys: String, CodingKey {
        case id, name, url
        case imageCount = "image_count"
        case images
    }
}


struct Images: Codable {
    let id: Int
    let url: String
    let largeURL: JSONNull?
    let sourceID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, url
        case largeURL = "large_url"
        case sourceID = "source_id"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
  public func hash(into hasher: inout Hasher) {
        hasher.combine(0)

    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}



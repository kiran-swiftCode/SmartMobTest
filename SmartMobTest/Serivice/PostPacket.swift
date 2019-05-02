//
//  PostPacket.swift
//  SmartMobTest
//
//  Created by kiran on 5/2/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation

class PostPacket{
    
    typealias packet = [String: Any]
    static let shared = PostPacket()
    private init(){}
    
    func param() -> packet {
        var dict = packet()
        dict["images_only"] = true
        return dict
        
    }
}

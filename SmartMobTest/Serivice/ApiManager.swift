//
//  ApiManager.swift
//  SmartMobTest
//
//  Created by kiran on 5/1/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import AlamofireImage

class APIManager {
    
    static let api = APIManager()
    private init(){}
    
    
    
    // MARK:- FETCH LATEST PRODUCT
    func getLatestImages(parma: [String: Any]) -> Promise<[Image]> {
        
        return Promise {
            resolver in
            
            Alamofire.request(latestImagesRul).responseString{
                response in
                
                switch(response.result){
                case .success(let data):
                    
                    var images = [Image]()
                    if let json = data.data(using: .utf8){
                        
                        do {
                            let productsResponse = try JSONDecoder().decode(DataRes.self, from: json)
                            for prRes in productsResponse.images {
                                images.append(prRes)
                            }
                            
                            resolver.fulfill(images)
                            
                        }catch(let error){
                            print(error)
                            
                        }
                        
                    }
                    // print("my actual response is :- ",data)
                    
                case .failure(let error):
                    resolver.reject(error)
                    print(error)
                }
            }
            
        }
        
    }
    
    
    // MARK:- DOWNLOAD IMAGE
    func fetchImage(imageUrl: String) -> Promise<UIImage> {
        
        return Promise {
            resolver in
            
            
            Alamofire.request(imageUrl).responseImage{
                response in
                
                
                if let da = response.result.value {
                    resolver.fulfill(da)
                    
                }
                
                print("my actual response is :- ",response)
            }
            
        }
        
    }
    
    
    //MARK: - FETCH IMAGE DETAILS FROM IMAGEID
    
    func getLatestImages(imageId: Int) -> Promise<ImageDetailRes> {
        let url = getSourcebyId + "/\(imageId)"
        
        return Promise {
            resolver in
            
            Alamofire.request(url).responseString{
                response in
                
                switch(response.result){
                case .success(let data):
                    if let json = data.data(using: .utf8){
                        
                        do {
                            let imageDetail = try JSONDecoder().decode(ImageDetailRes.self, from: json)
                            
                            resolver.fulfill(imageDetail)
                            
                        }catch(let error){
                            print(error)
                            
                        }
                        
                    }
                    print("my actual response is :- ",data)
                    
                case .failure(let error):
                    resolver.reject(error)
                    print(error)
                }
            }
            
        }
        
    }
    
    
    
    
}

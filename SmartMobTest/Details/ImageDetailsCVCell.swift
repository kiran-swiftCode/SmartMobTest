//
//  ImageDetailsCVCell.swift
//  SmartMobTest
//
//  Created by kiran on 5/2/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class ImageDetailsCVCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    
    
    var imgUrl:String?{
        didSet{
            downloadImage(imageUrl: imgUrl!)
        }
    }
    
    func downloadImage(imageUrl: String){
        _ = APIManager.api.fetchImage(imageUrl: imageUrl)
            .done({ (res) in
                self.img.image = res
            })
        
    }
    
}

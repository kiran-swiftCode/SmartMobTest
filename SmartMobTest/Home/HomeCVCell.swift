//
//  HomeCVCell.swift
//  SmartMobTest
//
//  Created by kiran on 5/2/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class HomeCVCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var imageUrl:String?{
        didSet{
            downloadImage(imageUrl: imageUrl!)
        }
    }
    
    
    func downloadImage(imageUrl:String){
        _ = APIManager.api.fetchImage(imageUrl: imageUrl)
            .done({ (res) in
                self.img.image = res
            })
    }
    
}

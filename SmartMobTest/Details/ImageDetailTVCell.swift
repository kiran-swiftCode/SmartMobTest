//
//  ImageDetailTVCell.swift
//  SmartMobTest
//
//  Created by kiran on 5/2/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class ImageDetailTVCell: UITableViewCell {
    
    @IBOutlet weak var imagesCV: UICollectionView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var pageView: UIPageControl!
    
    var del:SendImageUrl!
    var imgeId:Int?{
        didSet{
            getImageDetails(id: imgeId!)
            
        }
    }
    
    var imageDetail:ImageDetailRes?{
        didSet{
            author.text = "Author:" + imageDetail!.name
            for img in imageDetail!.images {
                images.append(img.url)
            }
        }
    }
    
    var images = [String]() {
        didSet{
            
            pageView.numberOfPages = images.count
            pageView.currentPage = 0
            self.imagesCV.reloadData()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagesCV.delegate = self
        imagesCV.dataSource = self
        pageView.hidesForSinglePage = true
        
        
    }
    
    
    func getImageDetails(id:Int){
        _ = APIManager.api.getLatestImages(imageId: id)
            .done({ (res) in
                
                
                DispatchQueue.main.async {
                    self.imageDetail = res
                }
                
            })
        
    }
    
    
}

extension ImageDetailTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath:  IndexPath) -> CGSize {
        let size = imagesCV.frame.size
        return CGSize(width: size.width, height:size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCV.dequeueReusableCell(withReuseIdentifier: "ImageDetailsCVCell", for: indexPath) as! ImageDetailsCVCell
        cell.imgUrl = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageView.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tappedImageUrl = images[indexPath.row]
        del!.didTappedCell(imgUrl: tappedImageUrl)
    }
    
    
}



//
//  ViewController.swift
//  SmartMobTest
//
//  Created by kiran on 5/1/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class Home: UIViewController {
    @IBOutlet weak var homeCV: UICollectionView!
    let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    var images = [Image](){
        didSet{
            for img in images{
                downloadImage(imageUrl: img.url)
            }
            
        }
    }
    var imagesData = [UIImage](){
        didSet{
            homeCV.reloadData()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatestImges()
        homeCV.delegate = self
        homeCV.dataSource = self
        view.addSubview(myActivityIndicator)
        myActivityIndicator.center = view.center
    }
    
    
    
}

extension Home: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let widthScale = (screenWidth / 2) - 1
        let heightScale = (screenHeight / 3) - 2
        
        return CGSize(width: widthScale, height: heightScale)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        cell.img.image = self.imagesData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(images[indexPath.row].id)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageDetailsTVC") as! ImageDetailsTVC
        vc.imgId = images[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    func getLatestImges(){
        myActivityIndicator.startAnimating()
        myActivityIndicator.hidesWhenStopped = false
        let param = PostPacket.shared.param()
        print(param)
        _ = APIManager.api.getLatestImages(parma: param)
            .done({ (res) in
                self.myActivityIndicator.stopAnimating()
                self.myActivityIndicator.hidesWhenStopped = true
                self.images = res
            })
    }
    
    
    
    func downloadImage(imageUrl: String){
        _ = APIManager.api.fetchImage(imageUrl: imageUrl)
            .done({ (res) in
                
                self.imagesData.append(res)
                
            })
    }
    
    
}



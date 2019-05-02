//
//  ImageDetailsTVC.swift
//  SmartMobTest
//
//  Created by kiran on 5/2/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit
import GSImageViewerController

class ImageDetailsTVC: UITableViewController {
    
    
    var imgId:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailTVCell", for: indexPath) as! ImageDetailTVCell
            cell.del = self
            cell.imgeId = imgId
            return cell
        } else {
        return UITableViewCell()
        }
       
    }


}

extension ImageDetailsTVC: SendImageUrl {
    func didTappedCell(imgUrl: String) {
        getIm(ur: imgUrl)
    }
    
    
    func getIm(ur: String) {
        _ = APIManager.api.fetchImage(imageUrl: ur)
            .done({ (res) in
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = self.tableView.cellForRow(at: indexPath)
                let imageInfo = GSImageInfo(image: res, imageMode: .aspectFill)
                let transitationInfo = GSTransitionInfo(fromView: cell!)
                let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitationInfo)
                self.present(imageViewer, animated: true, completion: nil)
            })
        
        
        
    }
    
}

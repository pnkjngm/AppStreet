//
//  Cell.swift
//  AppStreet
//
//  Created by iSteer Inc. on 09/06/18.
//  Copyright © 2018 iSteer Inc. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func viewModelData(viewModel : ViewModel) {
        
        do {
            //            https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
            let urString = "https://farm\(viewModel.farmID).staticflickr.com/\(viewModel.serverID)/\(viewModel.id)_\(viewModel.secret).jpg"
            
            let imageData = try  Data(contentsOf : URL(string : urString)!)


            self.imgView.image = UIImage(data : imageData)
        } catch {
            print("Some Exception Occured !!")
            
        }
        
    }

}

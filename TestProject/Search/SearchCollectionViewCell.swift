//
//  SearchCollectionViewCell.swift
//  TestProject
//
//  Created by Vlad on 17.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var someUrl: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func prepareForReuse() {
          super.prepareForReuse()
           self.image.image = UIImage()
       }
}

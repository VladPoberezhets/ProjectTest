//
//  HeaderCollectionViewCell.swift
//  TestProject
//
//  Created by Vlad on 18.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var siteUrl: UILabel!
    @IBOutlet weak var date: UILabel!
    override func prepareForReuse() {
          super.prepareForReuse()
           self.image.image = UIImage()
       }
      
      static func nib()->UINib{
          return UINib(nibName: "HeaderCollectionViewCell", bundle: nil)
      }
}

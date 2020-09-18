//
//  NewsCollectionViewCell.swift
//  TestProject
//
//  Created by Vlad on 16.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var siteUrl: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
         self.image.image = UIImage()
     }
    
    static func nib()->UINib{
        return UINib(nibName: "NewsCollectionViewCell", bundle: nil)
    }
}

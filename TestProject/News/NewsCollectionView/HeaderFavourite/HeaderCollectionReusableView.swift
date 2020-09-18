//
//  HeaderCollectionReusableView.swift
//  TestProject
//
//  Created by Vlad on 17.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    
    static let identifire = "HeaderCollectionReusableView"
    
    ///filtered image when user active search bar
    private var favourite = [Result]()
    ///have method get data and image by url
    private let settings = SettingsNews()
    /// model data post
    private var model:ModelNews? = nil
    
    private var collectionview: UICollectionView!
    
    
    private let pageControl = UIPageControl()
    private let image = UIImage(named: "favouriteImage")
    
    
    public func configure(){
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: UIScreen.main.bounds.width - 50, y: 50, width: 80, height: 30)
        
        
        LoadData()
        
        addSubview(imageView)
        SettingsCollectionView()
        SettingsPageControll()
        
    }
    
    
    
    func SettingsCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: bounds.width, height: bounds.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionview = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.alwaysBounceHorizontal = true
        collectionview.isPagingEnabled = true
        collectionview.showsHorizontalScrollIndicator = false
        
        collectionview.backgroundColor = UIColor.black
        
        collectionview.register(HeaderCollectionViewCell.nib(), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        
        addSubview(collectionview)
    }
    
    
    func SettingsPageControll(){
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = pageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant:0)
        let trailing = pageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant:0)
        let bottom = pageControl.bottomAnchor.constraint(equalTo: topAnchor, constant:200)
        
        addConstraints([leading,trailing,bottom])
        
        pageControl.backgroundColor = UIColor.clear
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.blue
    }
    
}


extension HeaderCollectionReusableView{
    /**
    Getting news post and added in model object
    */
    func LoadData(){
        settings.GetData { (newsModel) in
            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                if !newsModel.results.isEmpty{
                    self.model = newsModel
                    self.favourite = newsModel.results.sorted{
                        if $0.popularity > $1.popularity{
                            
                            return true
                        }
                        return false
                    }
                    
                    self.collectionview.reloadData()
                }
            })
        }
    }
}


extension HeaderCollectionReusableView:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !favourite.isEmpty{
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as! HeaderCollectionViewCell
        
        
        cell.title.text = favourite[indexPath.row].title
        cell.date.text = "- \(favourite[indexPath.row].release_date)"
        
        
        self.settings.GetImage(urlImage: favourite[indexPath.row].poster_path, complition: { (image) in
            DispatchQueue.main.async {
                
                cell.image.image = image
            }
        })
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(bounds.width)
    }
    
}

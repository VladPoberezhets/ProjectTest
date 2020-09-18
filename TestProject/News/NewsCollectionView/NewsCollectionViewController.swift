//
//  NewsCollectionViewController.swift
//  TestProject
//
//  Created by Vlad on 16.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage



class NewsCollectionViewController: UICollectionViewController {
    
    ///have method get data and image by url
    private let settings = SettingsNews()
    /// model data post
    private var model:ModelNews? = nil
    private let imageCache = AutoPurgingImageCache()
    
    let activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News"
        
        AddActivityIndicator()
        SettingsCollectionView()
        LoadData()
    }
    
    /**
       Activity indicator settings

       */
    func AddActivityIndicator(){
        self.view.addSubview(activityIndicator)
        activityIndicator.style = .gray
        activityIndicator.color = .white
        activityIndicator.frame = view.bounds
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = (UIColor (white: 0, alpha: 1))
        activityIndicator.frame.origin = CGPoint(x: 0, y: -100)
    }
    
    /**
          Collection view  settings

          */
    func SettingsCollectionView(){
        collectionView.frame.origin = CGPoint(x: 0, y: -40)
        
        collectionView.register(NewsCollectionViewCell.nib(), forCellWithReuseIdentifier: "NewsCollectionViewCell")
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifire)
    }

}



extension NewsCollectionViewController {
    /**
    Getting news post and added in model object
    */
    func LoadData(){
        settings.GetData { (newsModel) in
            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                if !newsModel.results.isEmpty{
                    self.model = newsModel
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
            })
        }
    }
}

extension NewsCollectionViewController:UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = model?.results{
            return data.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        
        if let data = model?.results{
            
            cell.title.text = data[indexPath.row].title
            cell.date.text = "- \(data[indexPath.row].release_date)"
            
            
            self.settings.GetImage(urlImage: data[indexPath.row].poster_path, complition: { (image) in
                DispatchQueue.main.async {
                    let urlRequest = URLRequest(url: URL(string: data[indexPath.row].poster_path)!)
                    self.imageCache.add(image, for:urlRequest, withIdentifier: "imagePost")
                    
                    cell.image.image = self.imageCache.image(for: urlRequest, withIdentifier: "imagePost")
                }
            })
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        /// register header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifire, for: indexPath) as! HeaderCollectionReusableView
        
        header.configure()
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 200)
    }
}

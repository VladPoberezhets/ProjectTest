//
//  SearchCollectionViewController.swift
//  TestProject
//
//  Created by Vlad on 17.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit


class SearchCollectionViewController: UICollectionViewController {
    
    ///filtered image when user active search bar
    private var filterArr = [Result]()
    /// model data post
    private var model:ModelNews? = nil
    ///have method get data and image by url
    private let settings = SettingsNews()
    
    private let activityIndicator = UIActivityIndicatorView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SettingActivityIndicator()
        SettingSearchBar()
        LoadData()

    }
    
    func SettingActivityIndicator(){
        //MARK: Activity indicator settings
        activityIndicator.style = .gray
        activityIndicator.color = .white
        activityIndicator.frame = view.bounds
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = (UIColor (white: 0, alpha: 1))
        self.view.addSubview(activityIndicator)
    }
    
    
    func SettingSearchBar(){
        //MARK: Search controller settings
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        self.definesPresentationContext = true
    }
    
    
}


extension SearchCollectionViewController{
    func LoadData(){
        //MARK: Getting news post
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

extension SearchCollectionViewController:UISearchResultsUpdating{
    /**
     This function returns a sorted list by title .
     
     **Parameters:**
     - searchText: text by user write in search bar
     */
    func filterContent(for searchText: String) {
        filterArr = self.model!.results.filter{
            return $0.title.lowercased().contains(searchText.lowercased())
        }
    }
    
    // MARK: - UISearchResultsUpdating method
    func updateSearchResults(for searchController: UISearchController) {
        // If the search bar contains text, filter our data with the string
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            // Reload the table view with the search result data.
            collectionView.reloadData()
        }
    }
}

extension SearchCollectionViewController{
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !filterArr.isEmpty{
            return filterArr.count
        }else{
            if let data = model?.results{
                return data.count
            }
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCollectionViewCell
        
        //MARK: Filtered data
        if !filterArr.isEmpty{
            cell.title.text = filterArr[indexPath.row].title
            cell.date.text = "- \(filterArr[indexPath.row].release_date)"
            // get image url and loaded image
            self.settings.GetImage(urlImage: filterArr[indexPath.row].poster_path, complition: { (image) in
                DispatchQueue.main.async {
                    cell.image.image = image
                }
            })
            //MARK: No filtered data
        }else{
            if let data = model?.results{
                cell.title.text = data[indexPath.row].title
                cell.date.text = "- \(data[indexPath.row].release_date)"
                // get image url and loaded image
                self.settings.GetImage(urlImage: data[indexPath.row].poster_path, complition: { (image) in
                    DispatchQueue.main.async {
                        cell.image.image = image
                    }
                })
            }
        }
        return cell
    }
}

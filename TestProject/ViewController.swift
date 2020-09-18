//
//  ViewController.swift
//  TestProject
//
//  Created by Vlad on 15.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit
import PageMenu

class ViewController: UIViewController,CAPSPageMenuDelegate {
    
    var pageMenu: CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
    }
    

 
    func setupPages() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var controllerArray: [UIViewController] = []
        
        
        let newsVC = storyboard.instantiateViewController(withIdentifier: "NewsCollectionViewController") as! NewsCollectionViewController
        newsVC.title = "Stories"
        
        let favouriteVC = storyboard.instantiateViewController(withIdentifier: "FavouriteViewController") as! FavouriteViewController
        favouriteVC.title = "Favourites"
        
        let videoVC = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
        videoVC.title = "Video"
        
        controllerArray.append(newsVC)
        controllerArray.append(favouriteVC)
        controllerArray.append(videoVC)
        
        // a bunch of random customization
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(0.0),
            .menuMargin(0.0),
            .menuHeight(45.0),
            .centerMenuItems(true),
            .menuItemSeparatorRoundEdges(false),
            .selectionIndicatorHeight(2.0),
            .menuItemSeparatorPercentageHeight(0.5),
            .viewBackgroundColor(UIColor.black)
        ]
        navigationController?.navigationBar.backgroundColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        if UIScreen.main.bounds.size.height > 750{
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: ((self.navigationController?.navigationBar.frame.size.height)!+43), width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        }else{
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: ((self.navigationController?.navigationBar.frame.size.height)!+10), width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        }
 
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
        
        
    }
    
}




//
//  SettingsNews.swift
//  TestProject
//
//  Created by Vlad on 16.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import Foundation
import Alamofire

class SettingsNews{
    
    /**
    This function returns a ModelNews.
     
    **Parameters:**
        - complition: return clouser ModelNews object.
    */
    func GetData(complition:@escaping (ModelNews)->Void){
        let url = "https://api.themoviedb.org/3/movie/top_rated?"
        let api_key = "f910e2224b142497cc05444043cc8aa4"
        let language = "en-US"
        let page = "1"
        
        DispatchQueue.global().async {
            AF.request("\(url)api_key=\(api_key)&language=\(language)&page=\(page)").response { (response) in
                if response.data != nil{
                    let jsonDecoder = JSONDecoder()
                    let newsData = try! jsonDecoder.decode(ModelNews.self, from: response.data!)
                    complition(newsData)
                }else{
                    print("Erorr request")
                }
            }
        }
        
    }
    /**
    This function returns a UIImage.
     
    **Parameters:**
        - complition: return clouser UIImage.
     - urlImage: path url image.
    */
    func GetImage(urlImage:String, complition:@escaping (UIImage)->Void){
        let url = "https://image.tmdb.org/t/p/original"
        DispatchQueue.global(qos: .background).async {
            AF.request(url+urlImage).responseImage { (image) in
                if image.value != nil{
                    complition(image.value!)
                }
            }
        }
    }
}

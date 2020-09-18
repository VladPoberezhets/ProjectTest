//
//  ModelNews.swift
//  TestProject
//
//  Created by Vlad on 16.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import Foundation

class ModelNews:Codable{
    let page:Int
    var results:[Result]
    let total_results:Int
    let total_pages:Int
}

class Result:Codable{
    let poster_path:String
    let adult:Bool
    let overview:String
    let release_date:String
    let genre_ids:[Int]
    let id:Int
    let original_title:String
    let original_language:String
    let title:String
    let backdrop_path:String
    let popularity:Double
    let vote_count:Int
    let video:Bool
    let vote_average:Double
    
}

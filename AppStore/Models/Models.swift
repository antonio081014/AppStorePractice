//
//  Models.swift
//  AppStore
//
//  Created by Antonio081014 on 8/15/17.
//  Copyright © 2017 sample.com. All rights reserved.
//

import UIKit

class FeaturedApps: NSObject, Decodable {
    var bannerCategory: AppCategory?
    var categories: [AppCategory]?
}

class AppCategory: NSObject, Decodable {
    
    var name: String?
    var apps: [App]?
    
    static func fetchFeaturedApps(completion: @escaping ((FeaturedApps) -> Swift.Void)) {
        let urlString = "http://www.statsallday.com/appstore/featured"
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let data = data else { return }
            do {
                let featuredApps = try JSONDecoder().decode(FeaturedApps.self, from: data)
                DispatchQueue.main.async {
                    completion(featuredApps)
                }
            } catch let err {
                print(err)
            }
        }.resume()
    }
    
    static func sampleCategories() -> [AppCategory] {
        let bestNewAppCategory = AppCategory()
        bestNewAppCategory.name = "Best New Apps"
        
        var apps = [App]()
        
        let frozenApp = App()
        frozenApp.Name = "Disney Build It: Frozen"
        frozenApp.ImageName = "frozen"
        frozenApp.Category = "Entertainment"
        frozenApp.Price = 3.99
        apps.append(frozenApp)
        
        bestNewAppCategory.apps = apps
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestNewGameApps = [App]()
        let telepaintApp = App()
        telepaintApp.Category = "Games"
        telepaintApp.Name = "Telepaint"
        telepaintApp.Price = 2.99
        telepaintApp.ImageName = "telepaint"
        bestNewGameApps.append(telepaintApp)
        bestNewGamesCategory.apps = bestNewGameApps
        
        return [bestNewAppCategory, bestNewGamesCategory]
    }
}

class App: NSObject, Decodable {
    
    var Id: Int?
    
    var Name: String?
    
    var Category: String?
    
    var ImageName: String?
    
    var Price: Double?
    
    var Screenshots: [String]?
    
    var desc: String?
    
    var appInformation: [[String : String]]?
    
    
}

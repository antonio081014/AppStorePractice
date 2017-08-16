//
//  Models.swift
//  AppStore
//
//  Created by Antonio081014 on 8/15/17.
//  Copyright © 2017 sample.com. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    
    static func fetchFeaturedApps(completion: @escaping (([AppCategory]) -> Swift.Void)) {
        let urlString = "http://www.statsallday.com/appstore/featured"
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                if let dictionary = json as? [String : Any], let categories =  dictionary["categories"] as? [[String : Any]] {
                    var appCategories = [AppCategory]()
                    for dict in categories {
                        let category = AppCategory()
                        category.name = dict["name"] as? String
                        var apps = [App]()
                        for appDict in dict["apps"] as! [[String : Any]] {
                            let app = App()
                            app.name = appDict["Name"] as? String
                            app.id = appDict["Id"] as? Int
                            app.category = appDict["Category"] as? String
                            app.imageName = appDict["ImageName"] as? String
                            app.price = appDict["Price"] as? Double
                            apps.append(app)
                        }
                        category.apps = apps
                        appCategories.append(category)
                    }
                    
                    DispatchQueue.main.async {
                        completion(appCategories)
                    }
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
        frozenApp.name = "Disney Build It: Frozen"
        frozenApp.imageName = "frozen"
        frozenApp.category = "Entertainment"
        frozenApp.price = 3.99
        apps.append(frozenApp)
        
        bestNewAppCategory.apps = apps
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestNewGameApps = [App]()
        let telepaintApp = App()
        telepaintApp.category = "Games"
        telepaintApp.name = "Telepaint"
        telepaintApp.price = 2.99
        telepaintApp.imageName = "telepaint"
        bestNewGameApps.append(telepaintApp)
        bestNewGamesCategory.apps = bestNewGameApps
        
        return [bestNewAppCategory, bestNewGamesCategory]
    }
}

class App: NSObject {
    
    var id: Int?
    
    var name: String?
    
    var category: String?
    
    var imageName: String?
    
    var price: Double?
    
    
}

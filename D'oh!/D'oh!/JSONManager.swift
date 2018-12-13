//
//  JsonFile.swift
//  D'oh!
//
//  Created by notRoderick on 12/8/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import UIKit


class JSONManager {
    
     var mainView = SimpsonsTableViewController()
    
    func downloadSimpsons(completion: @escaping (Simpsons)->()) {
        let url = URL(string: "https://api.duckduckgo.com/?q=simpsons+characters&format=json")!
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String:Any]
            
            let characters =  json["RelatedTopics"] as! [[String:Any]]
            
            for character in characters {
                let imageDict = character["Icon"] as! [String:String]
                let imageURL = imageDict["URL"]! as String
                print(imageURL)
                let text = character["Text"] as! String
                //split text up into name and desc, respectively
                let separated = text.components(separatedBy: " - ")
                //print(separated[1])
                //let newSimpson = Simpson(separated[0], separated[1], imageURL)
                //self.simpsons.append(newSimpson)
                self.downloadImage(imageURL, completion: { (imageData) in
                    //send back to collectionView to show
                    DispatchQueue.main.async {
                        
                        let newSimpson = PersistanceManager.addSimpson(separated[0], separated[1], imageData)
                        //print(newSimpson.desc!)
                        DispatchQueue.main.async {
                            completion(newSimpson)
//                            self.mainView.simpson.append(newSimpson)
                        }
                    
//                        print(self.mainView.simpson) it shows information
                    }
                })
            }
            }.resume()
        
    }
    
    func downloadImage(_ urlString: String,
                       completion: @escaping (Data)->()) {
        
//        let filePath = Bundle.main.path(forResource: "doh", ofType: "png")
        var url = URL(string: urlString) //?? URL.init(fileURLWithPath: filePath!)
        if url == nil {
            url = URL(string:"https://cdn.friendlystock.com/wp-content/uploads/2018/03/donald-trump-thumbs-up.jpg")
        }
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let safeData = data {
                //print("Did receive image data")
                completion(safeData)
            }
            
        }
        print(dataTask)
        dataTask.resume()
        
    }}

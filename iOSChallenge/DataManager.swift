//
//  DataManager.swift
//  iOSChallenge
//
//  Created by James Sayer on 3/27/17.
//  Copyright © 2017 James Sayer. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    override init() {
        super.init()
    }

    func downloadData(fromURL:String) -> Data? {

        var returnedData = NSMutableData()

        guard let validURL = URL(string:fromURL) else {
            print("Invalid URL")
            return nil
        }

        guard let validData = try! Data(contentsOf: validURL) as? Data else {
            print("Invalid data")
            return nil
        }

        returnedData.append(validData)
        print(returnedData.description)

        return returnedData as Data
    }

    func convertDataToJson(inputData:Data) -> [[String : AnyObject]] {

        var rawJson: [[String : AnyObject]]!

        if let validData = inputData as? Data {

            do {

                rawJson = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as! [[String : AnyObject]]

                print(rawJson.description)

            } catch {
                print("Error converting JSON")
            }
        }
        return rawJson
    }

    func downloadImages(urls: [String], closure: ([UIImage]) -> Void) {
    
        var images = [UIImage]()
        
        for imageURL in urls {
            
            var image = UIImage()

            do {
                try image = UIImage(data: Data(contentsOf: URL(string: imageURL)!))!
            } catch {
                print("Error downloading image from: \(imageURL)")
            }
            
            images.append(image)
        }
        
        closure(images)
    }
    
    func downloadImage(urlString:String, closure: (UIImage) -> Void ) {


        guard let unwrappedURL = URL(string: urlString) else { return }

        var image:UIImage = UIImage()

        do {

            try image = UIImage(data: Data(contentsOf: unwrappedURL))!

        } catch {
            print("Error downloading image from: \(urlString)")
        }
        closure(image)
    }
}

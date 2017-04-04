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

    func downloadImage(urlString:String) -> UIImage {

        var returnedImage = UIImage()

        let url = URL(string: urlString)

        if let data = try! Data(contentsOf: url!) as? Data {
            returnedImage = UIImage(data: data)!
        }
        return returnedImage
    }
}

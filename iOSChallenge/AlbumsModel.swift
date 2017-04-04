//
//  AlbumsModel.swift
//  iOSChallenge
//
//  Created by James Sayer on 3/29/17.
//  Copyright © 2017 James Sayer. All rights reserved.
//

import UIKit

class AlbumsModel: NSObject {

    static let sharedInstance : AlbumsModel = AlbumsModel()

    var albumTitles: [String]!
    var albumIds : [String]!

    override init() {
        self.albumTitles = [String]()
        self.albumIds = [String]()

        let dataManager = DataManager()

        guard let data = dataManager.downloadData(fromURL: "https://jsonplaceholder.typicode.com/albums") else {
            print("Error downloading data")
            return
        }

        do {
            let rawJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String : AnyObject]]

            for item in rawJson {
                let titleToBeAdded = item["title"] as! String
                self.albumTitles.append(titleToBeAdded)

                let idToBeAdded = String(describing: item["id"]!)
                self.albumIds.append(idToBeAdded)
            }
        } catch {
            print("Error parsing JSON")
        }

        }
    }

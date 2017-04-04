//
//  DataSource.swift
//  iOSChallenge
//
//  Created by James Sayer on 3/24/17.
//  Copyright © 2017 James Sayer. All rights reserved.
//

import UIKit

class DataSource: NSObject {

    var albumTitles:[String]!
    var albumIds:[String]!
    var albumUserIds:[String]!

    init(data:Data) {
        self.albumTitles = [String]()
        self.albumIds = [String]()
        self.albumUserIds = [String]()

        guard let validData = data as Data? else {
            print("Invalid Data Object")
        }

        print(validData.description)

        let rawJson = try! JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as! [AnyObject]

        for arrayItem in rawJson {

            guard let validTitle = arrayItem["title"] as? String else {
                self.albumTitles.append("Invalid title")
                return
            }
            self.albumTitles.append(validTitle)

            guard let validId = arrayItem["id"] as? String else {
                self.albumIds.append("Invalid ID")
                return
            }
            self.albumIds.append(validId)

            guard let validUserId = arrayItem["userId"] as? String else {
                self.albumUserIds.append("Invalid User Id")
                return
            }
            self.albumUserIds.append(validUserId)
        }
    }
}

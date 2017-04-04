//
//  PhotoAlbumModel.swift
//  iOSChallenge
//
//  Created by James Sayer on 3/29/17.
//  Copyright © 2017 James Sayer. All rights reserved.
//

import UIKit

class PhotoAlbum: NSObject {

    var allPhotos:[Photo]!
    var photo:Photo!


    init(selectedID:String) {

        self.allPhotos = [Photo]()

        // Format URL String to selected Album ID
        var urlString = "https://jsonplaceholder.typicode.com/photos?albumId=\(selectedID)"
        //Initialize Data Manager
        var dataManager = DataManager()
        // Download data
        guard let data = dataManager.downloadData(fromURL: urlString) else {
            print("Error downloading data")
            return
        }

        //Convert Data to JSON
        do {

            let rawJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String : AnyObject]]

            for photo in rawJson {

                //Guard against invalid data
                guard let validAlbumId = String(describing: photo["albumId"]) as? String else {
                    print("Invalid Album ID")
                    return
                }

                guard let validId = String(describing: photo["id"]) as? String else {
                    print("Invalid photo ID")
                    return
                }

                guard let validTitle = photo["title"] as? String else {
                    print("Invalid title")
                    return
                }

                guard let validUrl = photo["url"] as? String else {
                    print("Invalid URL")
                    return
                }

                guard let validThumbnailUrl = photo["thumbnailUrl"] as? String else {
                    print("Invalid Thumbnail URL")
                    return
                }

                //Create photo album object

                self.photo = Photo(id: validId, albumId: validAlbumId, title: validTitle, url: validUrl, thumbnailURL: validThumbnailUrl)

                // Add album
                self.allPhotos.append(self.photo)
            }
        } catch {
            print("Error parsing JSON")
        }


        
    }

}

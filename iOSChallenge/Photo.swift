//
//  Album.swift
//  iOSChallenge
//
//  Created by James Sayer on 3/23/17.
//  Copyright © 2017 James Sayer. All rights reserved.
//

import UIKit

final class Photo: NSObject {

    var id:String
    var albumId:String
    var title:String
    var url:String
    var thumbnailURL:String

    init(id:String, albumId:String, title:String, url:String, thumbnailURL:String) {
        self.id = id
        self.albumId = albumId
        self.title = title
        self.url = url
        self.thumbnailURL = thumbnailURL
    }
}

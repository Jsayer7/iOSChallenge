//
//  AlbumPhotosViewController.swift
//  iOSChallenge
//
//  Created by James Sayer on 3/27/17.
//  Copyright © 2017 James Sayer. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AlbumPhotosViewController: UICollectionViewController {

    var allPhotos:[Photo]!
    var photoThumbnailURLs:[String]!
    var dataManager : DataManager!
    var thumbnailImages : [UIImage]!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.photoThumbnailURLs = [String]()
        self.dataManager = DataManager()
        self.thumbnailImages = [UIImage]()

        print("Photos: \(self.allPhotos.description)")

        for item in self.allPhotos {

            if let unwrappedURL = item.thumbnailURL as? String {
               self.photoThumbnailURLs.append(unwrappedURL)
                print(unwrappedURL)
            }
        }

        for imageURL in self.photoThumbnailURLs {
            let data = try! Data(contentsOf: URL(string: imageURL)!)
            let image = UIImage(data: data)
            print("Fetching image from: \(imageURL)")

            self.thumbnailImages.append(image!)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        print("Initialized collection view")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.allPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imageView.image = self.thumbnailImages[indexPath.row]


    
        // Configure the cell
        cell.backgroundColor = UIColor.green
        cell.contentView.addSubview(imageView)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

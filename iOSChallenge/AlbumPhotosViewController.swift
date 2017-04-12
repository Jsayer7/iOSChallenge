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

        DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
            
            if let strongSelf = self {
               
                strongSelf.dataManager.downloadImages(urls: strongSelf.photoThumbnailURLs) { (images: [UIImage])  in
                    
                    NSLog("\(images.count)")
                    strongSelf.thumbnailImages = images
                    NSLog("\(strongSelf.thumbnailImages.count)")

                    
                    DispatchQueue.main.async {
                        strongSelf.collectionView!.reloadData()
                    }
                }
            }
            
        }
        
//        DispatchQueue.global(qos: .userInitiated).async {
//
//            for imageURL in self.photoThumbnailURLs {
//                let image = self.dataManager.downloadImage(urlString: imageURL)
//
//                self.thumbnailImages.append(image)
//                print("Appending image from \(imageURL) to image array")
//
//                DispatchQueue.main.async {
//                    self.collectionView!.reloadData()
//                }
//            }
//        }

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

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = cell.contentView.center
        activityIndicator.startAnimating()

        
        
        if indexPath.row <= self.thumbnailImages.count - 1 {
            imageView.image = self.thumbnailImages[indexPath.row]
            activityIndicator.stopAnimating()
        }
        

        // Configure the cell
        cell.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(activityIndicator)
        cell.contentView.addSubview(imageView)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedPhoto = self.allPhotos[indexPath.row]

        let detailController = DetailViewController()
        detailController.title = selectedPhoto.title
        detailController.incomingPhotoURL = selectedPhoto.url
        
        self.navigationController?.pushViewController(detailController, animated: true)

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

//
//  AlbumsTableViewController.swift
//  iOSChallenge
//
//  Created by James Sayer on 3/23/17.
//  Copyright © 2017 James Sayer. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {


    var albumModel : AlbumsModel!
    var allAlbumTitles:[String]!
    var allAlbumIDs : [String]!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allAlbumTitles.count

    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        // Configure the cell...
        cell.textLabel?.text = self.allAlbumTitles[indexPath.row]


        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("Selected Album: \(self.allAlbumTitles[indexPath.row]) with ID: \(self.allAlbumIDs[indexPath.row])")

        var album = PhotoAlbum(selectedID: self.allAlbumIDs[indexPath.row])


        

        //Configure Collection View Layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 80)

        let photoController = AlbumPhotosViewController(collectionViewLayout: layout)
        photoController.allPhotos = album.allPhotos
        self.navigationController?.pushViewController(photoController, animated: true)
        photoController.title = self.allAlbumTitles[indexPath.row]


    }

    func setupUI() {

          title = "Albums"

        let albumModel = AlbumsModel()
        self.allAlbumTitles = albumModel.albumTitles
        self.allAlbumIDs = albumModel.albumIds
        print(self.allAlbumTitles.description)


    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

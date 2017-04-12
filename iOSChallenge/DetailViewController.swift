//
//  DetailViewController.swift
//  iOSChallenge
//
//  Created by James Sayer on 4/4/17.
//  Copyright © 2017 James Sayer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailImageView:UIImageView!
    var incomingPhotoURL:String!
    var dataManager:DataManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager = DataManager()
        self.configureInterface()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureInterface() {

        //Make navigation bar text smaller since these titles are wack
        let titleAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 12)
        ]

        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes


        self.view.backgroundColor = UIColor.white
        detailImageView = UIImageView(frame: CGRect(x: 0, y: 65, width: UIScreen.main.bounds.width, height: 400))
        self.view.addSubview(detailImageView)



        DispatchQueue.global(qos: .background).async { [weak self] () -> Void in

            if let strongSelf = self {

               strongSelf.dataManager.downloadImage(urlString: (self?.incomingPhotoURL)!, closure: { (image) in

                DispatchQueue.main.async {
                    self?.detailImageView.image = image
                }

               })
            }

        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

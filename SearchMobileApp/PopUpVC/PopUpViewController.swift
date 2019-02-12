//
//  PopUpViewController.swift
//  SearchMobileApp
//
//  Created by Abbul Hasan on 12/02/19.
//  Copyright © 2019 Abbul Hasan. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var imageViewInfo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    var name = String()
    var artist = String()
    var image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = "Name: " + name
        lblArtist.text = "Artist: " + artist
     imageViewInfo.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: ""))

        imageViewInfo.layer.cornerRadius = imageViewInfo.frame.size.width/2
        imageViewInfo.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    @IBAction func pressedCancelBtn(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
    }
}

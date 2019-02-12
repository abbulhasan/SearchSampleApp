//
//  SearchViewController.swift
//  SearchMobileApp
//
//  Created by Abbul Hasan on 12/02/19.
//  Copyright © 2019 Abbul Hasan. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class SearchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var txtMusicSearch: UITextField!
    
    var arrAlbum = [String]()
    var searchList = [SearchList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMusicSearch.delegate = self
        // Do any additional setup after loading the view.
    }
    //MARK: - Textfield delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text!)
        callSearchAPI(serachText: textField.text!)
        return true
    }
    // Calling search API
    func callSearchAPI(serachText:String) {
        SVProgressHUD.show()
        let parameters = ["method":"album.search","album":serachText,"api_key":"78c4a56d37d68d1eb595d193ee099367","format":"json"] as [String : Any]
        print("parameters",parameters)
        SearchNetworking.getSeachContent(parameters: parameters, completionHandler: { (jsonResponse, error) in
            SVProgressHUD.dismiss()
            if jsonResponse != nil && error == nil {
                self.searchList.removeAll()
                let searchDict = jsonResponse?.dictionaryValue
                let dictResult = searchDict!["results"]?.dictionaryValue
                if dictResult != nil{
                    let albummatches = dictResult!["albummatches"]?.dictionaryValue
                    let arrAlbum = albummatches!["album"]?.arrayValue
                    for album in arrAlbum! {
                        self.searchList.append(SearchList(object: album))
                    }
                    self.searchCollectionView.reloadData()
                }
                
            } else {
                //show error
                //  self.view.makeToast("No likes found")
            }
        })
    }
    
    // MARK: - UICollectionViewDataSource protocol
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath as IndexPath) as! SearchCollectionViewCell
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let sObj = self.searchList[indexPath.row]
        cell.lblArtistName.text = sObj.name
        cell.imageViewAlbum.sd_setImage(with: URL(string: sObj.imageText!), placeholderImage: UIImage(named: ""))
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let sObj = self.searchList[indexPath.row]
        
        let popUpVC = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        popUpVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popUpVC.name = sObj.name!
        popUpVC.artist = sObj.artist!
        popUpVC.image = sObj.imageText!
        self.present(popUpVC, animated: true, completion: nil)
    }
}

//
//  SearchNetworking.swift
//  SearchMobileApp
//
//  Created by Abbul Hasan on 12/02/19.
//  Copyright © 2019 Abbul Hasan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Alamofire_SwiftyJSON

let headers = ["Content-Type": "application/x-www-form-urlencoded","Accept": "application/x-www-form-urlencoded"]

class SearchNetworking: NSObject {
    static let strURL =  "http://ws.audioscrobbler.com/2.0/?"
    class func getSeachContent(parameters: Dictionary<String, Any>, completionHandler:@escaping (JSON?, Error?)->()) {
        Alamofire.request(strURL, method: .post, parameters: parameters, headers:headers).responseSwiftyJSON { dataResponse in
            switch(dataResponse.result) {
            case .success(_):
                if dataResponse.result.value != nil{
                    let resultJSON = dataResponse.result.value
                    completionHandler(resultJSON, nil)
                }
                break
            case .failure(_):
                print("Failure : \(String(describing: dataResponse.result.error))")
                break
            }
        }
    }
}

//
//  SearchMobileApp
//
//  Created by Abbul Hasan on 12/02/19.
//  Copyright © 2019 Abbul Hasan. All rights reserved.
//

import UIKit
import SwiftyJSON

public struct SearchList {
    
    private struct SerializationKeys {
        static let name = "name"
        static let artist = "artist"
        static let urlMusic = "url"
        static let imageArr = "image"
        static let imageText = "#text"
    }
    //ccode : 0
    public var name: String?
    public var artist: String?
    public var urlMusic: String?
    public var imageText: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public init(json: JSON) {
        name = json[SerializationKeys.name].string
        artist = json[SerializationKeys.artist].string
        urlMusic = json[SerializationKeys.urlMusic].string
        let imageArr = json["image"].arrayValue
        let dictImage = imageArr[2].dictionaryValue
        imageText = dictImage[SerializationKeys.imageText]?.string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        print("Json",dictionary)
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = artist { dictionary[SerializationKeys.artist] = value }
        if let value = imageText { dictionary[SerializationKeys.imageText] = value }
        if let value = urlMusic { dictionary[SerializationKeys.urlMusic] = value }
        return dictionary
    }
}

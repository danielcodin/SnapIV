//
//  Data.swift
//  SnapIV
//
//  Created by Daniel Tseng on 8/17/16.
//  Copyright © 2016 Daniel Tseng. All rights reserved.
//

import UIKit

class Data {
    var autoDeletePhoto: Bool = false
    var arcLevel: Double?
    var skipped: Bool = true
    var fromArc: Bool = false
    var originImage: UIImage = UIImage()
    var possibleIVLevel: NSMutableArray = NSMutableArray()
    var possibleLevels: NSMutableArray = NSMutableArray()
    
    var pokemonNameStored: String = ""
    var cpStored: String = ""
    var hpStored: String = ""
    var stardustStored: String = ""
    var poweredStored: Bool = false
}
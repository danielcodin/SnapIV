//
//  StringExtension.swift
//  SnapIV
//
//  Created by Daniel Tseng on 8/16/16.
//  Copyright © 2016 Daniel Tseng. All rights reserved.
//

import Foundation

extension String {
    
    func localized(_ lang:String) -> String {
        
        
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        
        let bundle = Bundle(path: path!)
        
        
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        
    }
    
}

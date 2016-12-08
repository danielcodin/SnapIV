//
//  ModelManager.swift
//  PokeIV
//
//  Created by Daniel Tseng on 8/10/16.
//  Copyright © 2016 Daniel Tseng. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("PokemonGO.sqlite"))
        }
        return sharedInstance
    }
    
    func getBaseStats() -> NSMutableArray {
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM BaseStats", withArgumentsIn: nil)
        let marrBaseStats : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let baseStat : BaseStat = BaseStat()
                baseStat.nameEng = resultSet.string(forColumn: "NameEng")
                baseStat.nameJpn = resultSet.string(forColumn: "NameJpn")
                baseStat.attack = Int(resultSet.int(forColumn: "Attack"))
                baseStat.defense = Int(resultSet.int(forColumn: "Defense"))
                baseStat.stamina = Int(resultSet.int(forColumn: "Stamina"))
                marrBaseStats.add(baseStat)
            }
        }
        sharedInstance.database!.close()
        return marrBaseStats
    }
    
    func getCPM() -> NSMutableDictionary {
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM CPM", withArgumentsIn: nil)
        let dictCPM: NSMutableDictionary = NSMutableDictionary()
        if (resultSet != nil) {
            while resultSet.next() {
                let level = resultSet.double(forColumn: "Level")
                let CPMValue = resultSet.double(forColumn: "CPMValue")
                dictCPM[level] = CPMValue
            }
        }
        sharedInstance.database!.close()
        return dictCPM
    }
    
    func getStardust() -> NSMutableDictionary {
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM Stardust", withArgumentsIn: nil)
        let dictStardust: NSMutableDictionary = NSMutableDictionary()
        if (resultSet != nil) {
            while resultSet.next() {
                let level = resultSet.double(forColumn: "Level")
                let cost = resultSet.double(forColumn: "Cost")
                dictStardust[cost] = level
            }
        }
        sharedInstance.database!.close()
        return dictStardust
    }
}

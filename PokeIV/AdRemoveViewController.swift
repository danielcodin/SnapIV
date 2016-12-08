//
//  AdRemoveViewController.swift
//  SnapIV
//
//  Created by Daniel Tseng on 8/15/16.
//  Copyright © 2016 Daniel Tseng. All rights reserved.
//

import UIKit
import StoreKit

class AdRemoveViewController: UIViewController {

    
    // SKProduct properties
    var products = [SKProduct]()
    
    @IBOutlet weak var navLabel: UINavigationItem!
    @IBOutlet weak var buyRemoveAdButton: UIButton!
    @IBOutlet weak var restoreRemoveAdButton: UIButton!
    @IBOutlet weak var askDeleteLabel: UILabel!
    @IBOutlet weak var askDeleteSwitch: UISwitch!
    
    // language
    var language:String?
    
    // get data
    var data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        // add Observer
        NotificationCenter.default.addObserver(self, selector: #selector(AdRemoveViewController.handlePurchaseNotification(_:)),
                                                         name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification), object: nil)
        
        // get current language
        self.language = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode)! as! String
        if language == "zh" { self.language = "zh-Hant"
        } else {
            self.language = "en"
        }
        
        self.buyRemoveAdButton.setTitle("adRemove_button".localized(self.language!), for: UIControlState())
        self.restoreRemoveAdButton.setTitle("adRestore_button".localized(self.language!), for: UIControlState())
        self.navLabel.title = "adRemove_title".localized(self.language!)
        self.askDeleteLabel.text = "autoDeletePhoto_switchLabel".localized(self.language!)
        
        // change the switch according to the autoDeletePhoto value
        if data.autoDeletePhoto {
            self.askDeleteSwitch.setOn(true, animated: false)
        } else {
            self.askDeleteSwitch.setOn(false, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reload()
    }
    
    func handlePurchaseNotification(_ notification: Notification) {
        guard let productID = notification.object as? String else { return }
    
        for (index, product) in products.enumerated() {
            guard product.productIdentifier == productID else { continue }
    
            //tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Fade)
        }
    }
    
    func reload() {
        products = []
        
        PokeIVProducts.store.requestProducts{success, products in
            if success {
                self.products = products!
                
            }
        }
    }
    @IBAction func buyRemoveAdPressed(_ sender: AnyObject) {
        if products.count <= 0 { return }
        PokeIVProducts.store.buyProduct(self.products[0])
    }

    @IBAction func restoreRemoveAdPressed(_ sender: AnyObject) {
        PokeIVProducts.store.restorePurchases()
    }
    
    @IBAction func askDeleteSwitchAction(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        if askDeleteSwitch.isOn == true{
            self.data.autoDeletePhoto = true
            defaults.set(true, forKey: "autoDeletePhoto")
        }
        if askDeleteSwitch.isOn == false{
            self.data.autoDeletePhoto = false
            defaults.set(false, forKey: "autoDeletePhoto")
        }
    }
    
}

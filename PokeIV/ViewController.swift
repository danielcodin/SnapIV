//
//  ViewController.swift
//  PokeIV
//
//  Created by Daniel Tseng on 8/10/16.
//  Copyright © 2016 Daniel Tseng. All rights reserved.
//

import UIKit
import Photos
import GoogleMobileAds
import JavaScriptCore
import MessageUI
import FBSDKCoreKit
import FBSDKShareKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, GADBannerViewDelegate, MFMailComposeViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, G8TesseractDelegate {
    
    @IBOutlet weak var removeAdButton: UIButton!
    
    // SKProduct properties
    var product: SKProduct?
    var products = [SKProduct]()
    
    // Picker option
    // picker view
    var pickerView = UIPickerView()
    var pickOption0 = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "R", "S", "T", "V", "W", "Z"]
    var pickOption1 = [String: [String]]()
    //var pickOption2 = ["Abra", "Aerodactyl", "Alakazam", "Arbok", "Arcanine", "Articuno", "Beedrill", "Bellsprout", "Blastoise", "Bulbasaur", "Butterfree", "Caterpie", "Chansey", "Charizard", "Charmander", "Charmeleon", "Clefable", "Clefairy", "Cloyster", "Cubone", "Dewgong", "Diglett", "Ditto", "Dodrio", "Doduo", "Dragonair", "Dragonite", "Dratini", "Drowzee", "Dugtrio", "Eevee", "Ekans", "Electabuzz", "Electrode", "Exeggcute", "Exeggutor", "Farfetch'd", "Fearow", "Flareon", "Gastly", "Gengar", "Geodude", "Gloom", "Golbat", "Goldeen", "Golduck", "Golem", "Graveler", "Grimer", "Grfowlithe", "Gyarados", "Haunter", "Hitmonchan", "Hitmonlee", "Horsea", "Hypno", "Ivysaur", "Jigglypuff", "Jolteon", "Jynx", "Kabuto", "Kabutops", "Kadabra", "Kakuna", "Kangaskhan", "Kingler", "Koffing", "Krabby", "Lapras", "Lickitung", "Machamp", "Machoke", "Machop", "Magikarp", "Magmar", "Magnemite", "Magneton", "Mankey", "Marowak", "Meowth", "Metapod", "Mew", "Mewtwo", "Moltres", "Mr. Mime", "Muk", "Nidoking", "Nidoqueen", "Nidoran♀", "Nidoran♂", "Nidorina", "Nidorino", "Ninetales", "Oddish", "Omanyte", "Omastar", "Onix", "Paras", "Parasect", "Persian", "Pidgeot", "Pidgeotto", "Pidgey", "Pikachu", "Pinsir", "Poliwag", "Poliwhirl", "Poliwrath", "Ponyta", "Porygon", "Primeape", "Psyduck", "Raichu", "Rapidash", "Raticate", "Rattata", "Rhydon", "Rhyhorn", "Sandshrew", "Sandslash", "Scyther", "Seadra", "Seaking", "Seel", "Shellder", "Slowbro", "Slowpoke", "Snorlax", "Spearow", "Squirtle", "Starmie", "Staryu", "Tangela", "Tauros", "Tentacool", "Tentacruel", "Vaporeon", "Venonat", "Venomoth", "Venusaur", "Victreebel", "Vileplume", "Voltorb", "Vulpix", "Wartortle", "Weedle", "Weepinbell", "Weezing", "Wigglytuff", "Zapdos", "Zubat"]
    
    // get Data
    var data = Data()
    
    @IBOutlet weak var hiddenView: UIView!
    
    // ad properties
    @IBOutlet weak var adBannerView: GADBannerView!
    
    @IBOutlet weak var origianlImageVIew: UIImageView!
    var latestPhoto: UIImage?
    @IBOutlet weak var ivLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    var activityIndicator:UIActivityIndicatorView!
    var currentTextField:UITextField!
    
    var baseStatsArray: NSMutableArray = NSMutableArray()
    var cpmDict: NSMutableDictionary = NSMutableDictionary()
    var stardustDict: NSMutableDictionary = NSMutableDictionary()
    
    // buttons properties
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var instantUploadButton: UIButton!
    
    // inputs
    @IBOutlet weak var pokemonTextField: UITextField!
    @IBOutlet weak var cpTextField: UITextField!
    @IBOutlet weak var hpTextField: UITextField!
    @IBOutlet weak var stardustTextField: UITextField!
    @IBOutlet weak var poweredSwitch: UISwitch!
    
    var name: String!
    var cp: Int!
    var hp: Int!
    var stardust: Int!
    var end:Int = 0
    var needReturn:Bool = false
    var baseStat:BaseStat?
    var fromSubmit:Bool = false
    
    var baseAttack:Int!
    var baseDefense:Int!
    var baseStamina:Int!
    
    var tempA = ["Abra", "Aerodactyl", "Alakazam", "Arbok", "Arcanine", "Articuno"]
    var tempB = ["Beedrill", "Bellsprout", "Blastoise", "Bulbasaur", "Butterfree"]
    var tempC = ["Caterpie", "Chansey", "Charizard", "Charmander", "Charmeleon", "Clefable", "Clefairy", "Cloyster", "Cubone"]
    var tempD = ["Dewgong", "Diglett", "Ditto", "Dodrio", "Doduo", "Dragonair", "Dragonite", "Dratini", "Drowzee", "Dugtrio"]
    var tempE = ["Eevee", "Ekans", "Electabuzz", "Electrode", "Exeggcute", "Exeggutor"]
    var tempF = ["Farfetch'd", "Fearow", "Flareon"]
    var tempG = ["Gastly", "Gengar", "Geodude", "Gloom", "Golbat", "Goldeen", "Golduck", "Golem", "Graveler", "Grimer", "Growlithe", "Gyarados"]
    var tempH = ["Haunter", "Hitmonchan", "Hitmonlee", "Horsea", "Hypno"]
    var tempI = ["Ivysaur"]
    var tempJ = ["Jigglypuff", "Jolteon", "Jynx"]
    var tempK = ["Kabuto", "Kabutops", "Kadabra", "Kakuna", "Kangaskhan", "Kingler", "Koffing", "Krabby"]
    var tempL = ["Lapras", "Lickitung"]
    var tempM = ["Machamp", "Machoke", "Machop", "Magikarp", "Magmar", "Magnemite", "Magneton", "Mankey", "Marowak", "Meowth", "Metapod", "Mew", "Mewtwo", "Moltres", "Mr. Mime", "Muk"]
    var tempN = ["Nidoking", "Nidoqueen", "Nidoran♀", "Nidoran♂", "Nidorina", "Nidorino", "Ninetales"]
    var tempO = ["Oddish", "Omanyte", "Omastar", "Onix"]
    var tempP = ["Paras", "Parasect", "Persian", "Pidgeot", "Pidgeotto", "Pidgey", "Pikachu", "Pinsir", "Poliwag", "Poliwhirl", "Poliwrath", "Ponyta", "Porygon", "Primeape", "Psyduck"]
    var tempR = ["Raichu", "Rapidash", "Raticate", "Rattata", "Rhydon", "Rhyhorn"]
    var tempS = ["Sandshrew", "Sandslash", "Scyther", "Seadra", "Seaking", "Seel", "Shellder", "Slowbro", "Slowpoke", "Snorlax", "Spearow", "Squirtle", "Starmie", "Staryu"]
    var tempT = ["Tangela", "Tauros", "Tentacool", "Tentacruel"]
    var tempV = ["Vaporeon", "Venonat", "Venomoth", "Venusaur", "Victreebel", "Vileplume", "Voltorb", "Vulpix"]
    var tempW = ["Wartortle", "Weedle", "Weepinbell", "Weezing", "Wigglytuff"]
    var tempZ = ["Zapdos", "Zubat"]
    var tempJpn = [String]()
    
    // To keep track of user's current selection from the main content array
    fileprivate var _currentSelection: Int = 0
    
    // whenever current selection is modified, we need to reload other pickers as their content depends upon the current selection index only.
    var currentSelection: Int {
        get {
            return _currentSelection
        }
        set {
            _currentSelection = newValue
            pickerView.reloadAllComponents()
            
            let tempArray = pickOption1[pickOption0[currentSelection]] as! NSArray
            self.pokemonTextField.text = tempArray[0] as! String
        }
    }
    
    // language
    var language:String?
    var languageJpn: Bool = false
    
    var Fbutton : FBSDKShareButton = FBSDKShareButton()
    
    // device
    let deviceName:String = UIDevice.current.modelName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let screenSize: CGRect = UIScreen.mainScreen().bounds
        //let screenWidth = screenSize.width
        //let screenHeight = screenSize.height
        
        // FB Share setup
        Fbutton.isHidden = true
        Fbutton.frame = CGRect(x: (UIScreen.main.bounds.width - 100), y: 190, width: 90, height: 25)
        Fbutton.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = NSLayoutConstraint(item: Fbutton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: pokemonTextField, attribute: NSLayoutAttribute.top, multiplier: 1, constant: -20)
        let trailingConstraint = NSLayoutConstraint(item: Fbutton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: pokemonTextField, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        self.view.addSubview(Fbutton)
        NSLayoutConstraint.activate([bottomConstraint, trailingConstraint])
        
        // initialize switch state
        self.poweredSwitch.setOn(false, animated: false)
        
        // get current language
        self.language = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode)! as! String
        if language == "ja" { self.languageJpn = true }
        if language == "zh" {
            self.language = "zh-Hant"
        } else {
            self.language = "en"
        }
        
        self.submitButton.setTitle("submit_button".localized(self.language!), for: UIControlState())
        self.uploadButton.setTitle("upload_button".localized(self.language!), for: UIControlState())
        self.instantUploadButton.setTitle("quickUpload_button".localized(self.language!), for: UIControlState())
        
        // ask for auto delete photo if first launch
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let defaults = UserDefaults.standard
        if launchedBefore  {
            data.autoDeletePhoto = defaults.bool(forKey: "autoDeletePhoto")
            print("Launched before: \(data.autoDeletePhoto)")
        }
        else {
            let alert = UIAlertController(title: "ask_autoDeletePhoto_title".localized(self.language!), message: "ask_autoDeletePhoto_body".localized(self.language!), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                self.data.autoDeletePhoto = false
                // Save to UserDefaults
                defaults.set(self.data.autoDeletePhoto, forKey: "autoDeletePhoto")
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.data.autoDeletePhoto = true
                // Save to UserDefaults
                defaults.set(self.data.autoDeletePhoto, forKey: "autoDeletePhoto")
            }))
            present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        // get database info
        baseStatsArray = ModelManager.getInstance().getBaseStats()
        cpmDict = sharedInstance.getCPM()
        stardustDict = sharedInstance.getStardust()
        
        // update dictionary
        pickOption1["A"] = ["Abra", "Aerodactyl", "Alakazam", "Arbok", "Arcanine", "Articuno"]
        pickOption1["B"] = ["Beedrill", "Bellsprout", "Blastoise", "Bulbasaur", "Butterfree"]
        pickOption1["C"] = ["Caterpie", "Chansey", "Charizard", "Charmander", "Charmeleon", "Clefable", "Clefairy", "Cloyster", "Cubone"]
        pickOption1["D"] = ["Dewgong", "Diglett", "Ditto", "Dodrio", "Doduo", "Dragonair", "Dragonite", "Dratini", "Drowzee", "Dugtrio"]
        pickOption1["E"] = ["Eevee", "Ekans", "Electabuzz", "Electrode", "Exeggcute", "Exeggutor"]
        pickOption1["F"] = ["Farfetch'd", "Fearow", "Flareon"]
        pickOption1["G"] = ["Gastly", "Gengar", "Geodude", "Gloom", "Golbat", "Goldeen", "Golduck", "Golem", "Graveler", "Grimer", "Growlithe", "Gyarados"]
        pickOption1["H"] = ["Haunter", "Hitmonchan", "Hitmonlee", "Horsea", "Hypno"]
        pickOption1["I"] = ["Ivysaur"]
        pickOption1["J"] = ["Jigglypuff", "Jolteon", "Jynx"]
        pickOption1["K"] = ["Kabuto", "Kabutops", "Kadabra", "Kakuna", "Kangaskhan", "Kingler", "Koffing", "Krabby"]
        pickOption1["L"] = ["Lapras", "Lickitung"]
        pickOption1["M"] = ["Machamp", "Machoke", "Machop", "Magikarp", "Magmar", "Magnemite", "Magneton", "Mankey", "Marowak", "Meowth", "Metapod", "Mew", "Mewtwo", "Moltres", "Mr. Mime", "Muk"]
        pickOption1["N"] = ["Nidoking", "Nidoqueen", "Nidoran♀", "Nidoran♂", "Nidorina", "Nidorino", "Ninetales"]
        pickOption1["O"] = ["Oddish", "Omanyte", "Omastar", "Onix"]
        pickOption1["P"] = ["Paras", "Parasect", "Persian", "Pidgeot", "Pidgeotto", "Pidgey", "Pikachu", "Pinsir", "Poliwag", "Poliwhirl", "Poliwrath", "Ponyta", "Porygon", "Primeape", "Psyduck"]
        pickOption1["R"] = ["Raichu", "Rapidash", "Raticate", "Rattata", "Rhydon", "Rhyhorn"]
        pickOption1["S"] = ["Sandshrew", "Sandslash", "Scyther", "Seadra", "Seaking", "Seel", "Shellder", "Slowbro", "Slowpoke", "Snorlax", "Spearow", "Squirtle", "Starmie", "Staryu"]
        pickOption1["T"] = ["Tangela", "Tauros", "Tentacool", "Tentacruel"]
        pickOption1["V"] = ["Vaporeon", "Venonat", "Venomoth", "Venusaur", "Victreebel", "Vileplume", "Voltorb", "Vulpix"]
        pickOption1["W"] = ["Wartortle", "Weedle", "Weepinbell", "Weezing", "Wigglytuff"]
        pickOption1["Z"] = ["Zapdos", "Zubat"]
        
        if self.languageJpn {
            var noNum:Int = 1
            for baseStat in (baseStatsArray as NSArray as! [BaseStat]) {
                self.tempJpn.append("No.\(noNum) " + baseStat.nameJpn)
                noNum += 1
            }
            print(tempJpn)
        }
        
        
        pickerView.delegate = self
        self.pokemonTextField.inputView = pickerView
        
        // Set delegate
        self.pokemonTextField.delegate = self
        self.cpTextField.delegate = self
        self.hpTextField.delegate = self
        self.stardustTextField.delegate = self
        self.adBannerView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //Add done button to numeric pad keyboard
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnNext = UIBarButtonItem.init(title: "Next", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.toNextTextField))
        let negativeSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace.width = 5.0
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ViewController.doneButton_Clicked))
        barBtnNext.title = "Next"
        
        toolbarDone.items = [negativeSpace, barBtnNext, flexSpace, barBtnDone, negativeSpace]
        self.pokemonTextField.inputAccessoryView = toolbarDone
        self.cpTextField.inputAccessoryView = toolbarDone
        self.hpTextField.inputAccessoryView = toolbarDone
        self.stardustTextField.inputAccessoryView = toolbarDone
        // Disable prediction bar
        self.pokemonTextField.autocorrectionType = UITextAutocorrectionType.no
        
        //hide original imageVIew
        self.origianlImageVIew.isHidden = true
        self.instantUploadButton.isHidden = false
        //hide the loading view
        self.hiddenView.isHidden = true
        
        // initial textField border
        self.pokemonTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.pokemonTextField.layer.borderWidth = 1.0
        self.hpTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.hpTextField.layer.borderWidth = 1.0
        self.cpTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.cpTextField.layer.borderWidth = 1.0
        self.stardustTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.stardustTextField.layer.borderWidth = 1.0
        self.pokemonTextField.layer.cornerRadius = 8.0
        self.pokemonTextField.layer.masksToBounds = true
        self.hpTextField.layer.cornerRadius = 8.0
        self.hpTextField.layer.masksToBounds = true
        self.cpTextField.layer.cornerRadius = 8.0
        self.cpTextField.layer.masksToBounds = true
        self.stardustTextField.layer.cornerRadius = 8.0
        self.stardustTextField.layer.masksToBounds = true
    }
    
    func reload() {
        products = []
        
        PokeIVProducts.store.requestProducts{success, products in
            if success {
                self.products = products!
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reload()
        
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // get camera roll permission
        PHPhotoLibrary.requestAuthorization { (status) -> Void in
            switch status{
            case .authorized:
                DispatchQueue.main.async(execute: {
                    print("Authorized")
                })
                break
            case .denied:
                DispatchQueue.main.async(execute: {
                    print("Denied")
                })
                break
            default:
                DispatchQueue.main.async(execute: {
                    print("Default")
                })
                break
            }
        }
        
        // ad
        adBannerView.adUnitID = "ca-app-pub-9258191403690282/4417778859"
        adBannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = [ "a36702354fbe17b042836387885ff571" ]
        adBannerView.load(request)
        //"a36702354fbe17b042836387885ff571"
        
        if products.count > 0 {
            let product = products[0]
            if PokeIVProducts.store.isProductPurchased(product.productIdentifier) {
                self.adBannerView.isHidden = true
            } else if IAPHelper.canMakePayments() {
                self.adBannerView.isHidden = false
            } else {
                self.removeAdButton.isHidden = true
            }
        }
        
        // from arc
        if data.fromArc {
            let getIVs: NSMutableArray = NSMutableArray()
            
            for i in data.possibleIVLevel as NSArray {
                let letI = i as! NSArray
                let tempLvl = letI[0] as! Double
                
                if tempLvl == data.arcLevel {
                    // save IV
                    let tempIV = letI[1] as! Double
                    getIVs.add(tempIV)
                }
            }
            
            // no results
            if getIVs.count <= 0 {
                self.ivLabel.text = "iv_noResult_1".localized(self.language!)
                self.rangeLabel.text = "Please try another level"
                self.instantUploadButton.setTitle("tryAgain_button".localized(self.language!), for: UIControlState())
                return
            }
            
            var bestIV = getIVs[0] as! Double
            var worstIV = getIVs[0] as! Double
            
            for i in getIVs as NSArray {
                if bestIV < i as! Double {
                    bestIV = i as! Double
                }
                if worstIV > i as! Double {
                    worstIV = i as! Double
                }
            }
            let averageIV = Int(floor((worstIV+bestIV)/2))
            
            if worstIV == bestIV {
                self.ivLabel.text = "IV: \(bestIV)%"
                self.rangeLabel.text = "iv_description".localized(self.language!)
            } else {
                self.ivLabel.text = "iv_MaxLabel".localized(self.language!) + "\(averageIV)%"
                self.rangeLabel.text = "\(worstIV)% ~ \(bestIV)%"
            }
            // show quick upload Button
            self.instantUploadButton.setTitle("quickUpload_button".localized(self.language!), for: UIControlState())
            data.fromArc = false
            
            self.pokemonTextField.text = data.pokemonNameStored
            self.cpTextField.text = data.cpStored
            self.hpTextField.text = data.hpStored
            self.stardustTextField.text = data.stardustStored
            self.poweredSwitch.setOn(data.poweredStored, animated: false)
            
            //Create the UIImage
            UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let tempImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // show FB share Button
            Fbutton.isHidden = false
            let photo : FBSDKSharePhoto = FBSDKSharePhoto()
            let photo1: FBSDKSharePhoto = FBSDKSharePhoto()
            photo.image = tempImage
            photo.isUserGenerated = true
            photo1.image = self.data.originImage
            photo1.isUserGenerated = true
            let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
            content.photos = [photo, photo1]
            Fbutton.shareContent = content
        }
    }
    
    // diable keyboard by touching outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currentTextField = textField
    }
    
    func toNextTextField(){
        let nextTag: NSInteger = currentTextField.tag + 1;
        // Try to find next responder
        if let nextResponder: UIResponder? = currentTextField.superview!.viewWithTag(nextTag){
            nextResponder?.becomeFirstResponder()
        }
        else {
            // Not found, so remove keyboard.
            currentTextField.resignFirstResponder()
        }
    }
    
    func doneButton_Clicked() {
        self.pokemonTextField.resignFirstResponder()
        self.cpTextField.resignFirstResponder()
        self.hpTextField.resignFirstResponder()
        self.stardustTextField.resignFirstResponder()
    }
    
    func keyboardWillShow(_ sender: Notification) {
        //let info = sender.userInfo!
        //let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.frame.origin.y = -130
        })
    }
    
    func keyboardWillHide(_ sender: Notification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.frame.origin.y = 0
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag + 1;
        // Try to find next responder
        if let nextResponder: UIResponder? = textField.superview!.viewWithTag(nextTag){
            nextResponder?.becomeFirstResponder()
        }
        else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return false // We do not want UITextField to insert line-breaks.
    }
    
    // Activity Indicator methods
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }
    
    @IBAction func submitInput(_ sender: AnyObject) {
        // reset fb content
        Fbutton.shareContent = FBSDKSharePhotoContent()
        
        // Get Inputs
        self.name = self.pokemonTextField.text
        self.cp = Int(self.cpTextField.text!)
        self.hp = Int(self.hpTextField.text!)
        self.stardust = Int(self.stardustTextField.text!)
        
        // Check inputs' values
        if (self.name == "Mr. Mime") {}
        else if(self.name == "" || self.name == nil || self.name.contains(" ")) {
            shakeTextField(self.pokemonTextField)
            self.pokemonTextField.text = ""
            self.pokemonTextField.placeholder = "請手動輸入"
            self.origianlImageVIew.isHidden = false
            self.pokemonTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        }
        if(self.cp == nil) {
            shakeTextField(self.cpTextField)
            self.cpTextField.text = ""
            self.cpTextField.placeholder = "請手動輸入"
            self.origianlImageVIew.isHidden = false
            self.cpTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        }
        if(self.hp == nil) {
            shakeTextField(self.hpTextField)
            self.hpTextField.text = ""
            self.hpTextField.placeholder = "請手動輸入"
            self.origianlImageVIew.isHidden = false
            self.hpTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        }
        if(self.stardust == nil || stardustDict[stardust] == nil) {
            shakeTextField(self.stardustTextField)
            self.stardustTextField.text = ""
            self.stardustTextField.placeholder = "請手動輸入"
            self.origianlImageVIew.isHidden = false
            self.stardustTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        }
        
        //captilize first letter of pokemon name
        self.pokemonTextField.text = self.pokemonTextField.text?.uppercaseFirst
        self.name = self.pokemonTextField.text
        
        // Check pokemon name and get baseStat if possible
        for baseStat in (baseStatsArray as NSArray as! [BaseStat]) {
            if baseStat.nameEng == self.name || baseStat.nameJpn == self.name {
                self.baseAttack = baseStat.attack
                self.baseDefense = baseStat.defense
                self.baseStamina = baseStat.stamina
                break
            }
        }
        if (self.baseAttack == nil || self.baseDefense == nil || self.baseStamina == nil) {
            shakeTextField(self.pokemonTextField)
            self.pokemonTextField.text = ""
            self.pokemonTextField.placeholder = "請手動輸入"
            self.pokemonTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
            resetVariables()
            return
        }
        
        // resign textFields
        self.pokemonTextField.resignFirstResponder()
        self.cpTextField.resignFirstResponder()
        self.hpTextField.resignFirstResponder()
        self.stardustTextField.resignFirstResponder()
        
        // Start calculation if no nil value
        if (self.name != nil && self.cp != nil && self.hp != nil && self.stardust != nil && stardustDict[stardust] != nil) {
            self.calculateIV()
        }
        
        self.fromSubmit = true
    }

    func shakeTextField(_ textfield: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textfield.center.x - 10, y: textfield.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textfield.center.x + 10, y: textfield.center.y))
        textfield.layer.add(animation, forKey: "position")
        
    }
    
    func calculateIV() {
        self.instantUploadButton.setTitle("quickUpload_button".localized(self.language!), for: UIControlState())
        
        // reset fb content
        Fbutton.shareContent = FBSDKSharePhotoContent()
        
        end = 0
        needReturn = false
        
        
        if self.name != nil {
            // Check pokemon name and get baseStat if possible
            for baseStat in (baseStatsArray as NSArray as! [BaseStat]) {
                if baseStat.nameEng == self.name || baseStat.nameJpn == self.name {
                    self.baseAttack = baseStat.attack
                    self.baseDefense = baseStat.defense
                    self.baseStamina = baseStat.stamina
                    self.pokemonTextField.text = self.name
                    break
                }
            }
        }
        
        
        if (self.baseAttack == nil || self.baseDefense == nil || self.baseStamina == nil) && (self.cp == nil) && (self.stardust == nil) && (self.hp == nil){
            shakeTextField(self.pokemonTextField)
            shakeTextField(self.cpTextField)
            shakeTextField(self.hpTextField)
            shakeTextField(self.stardustTextField)
            self.pokemonTextField.text = ""
            self.pokemonTextField.placeholder = "請手動輸入"
            self.cpTextField.text = ""
            self.cpTextField.placeholder = "請手動輸入"
            self.stardustTextField.text = ""
            self.stardustTextField.placeholder = "請手動輸入"
            self.hpTextField.text = ""
            self.hpTextField.placeholder = "請手動輸入"
            self.needReturn = true
            self.pokemonTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
            self.cpTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
            self.hpTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
            self.stardustTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        }
        if (self.cp == nil) {
            self.shakeTextField(self.cpTextField)
            self.cpTextField.text = ""
            self.cpTextField.placeholder = "請手動輸入"
            self.needReturn = true
            self.cpTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        } else {
            self.cpTextField.text = String(self.cp)
        }
        if(self.baseAttack == nil || self.baseDefense == nil || self.baseStamina == nil) {
            shakeTextField(self.pokemonTextField)
            self.pokemonTextField.text = ""
            self.pokemonTextField.placeholder = "請手動輸入"
            self.needReturn = true
            self.pokemonTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        }
        if(self.stardust == nil || stardustDict[stardust] == nil) {
            shakeTextField(self.stardustTextField)
            self.stardustTextField.text = ""
            self.stardustTextField.placeholder = "請手動輸入"
            self.needReturn = true
            self.stardustTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        } else {
            self.stardustTextField.text = String(self.stardust)
        }
        if(self.hp == nil) {
            shakeTextField(self.hpTextField)
            self.hpTextField.text = ""
            self.hpTextField.placeholder = "請手動輸入"
            self.needReturn = true
            self.hpTextField.layer.borderColor = UIColor( red: 255/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        } else {
            self.hpTextField.text = String(self.hp)
        }
        
        if (needReturn) {
            resetVariables()
            return
        }
        
        // Assume Pokemon's level via Stardust
        
        let level:Double = stardustDict[stardust] as! Double
        
        // Get CPMValue via calculated Pokemon's level
        let cpm:Double = cpmDict[level] as! Double
        
        
        let IndStaValues:NSMutableArray = NSMutableArray()
        
        var jump: Double = 0.5
        if poweredSwitch.isOn == false{
            jump = 1.0
        }
        
        
            for leveled in stride(from: level, to: level+2.0, by: jump) {
                let newCPM = cpmDict[leveled] as! Double
            
                for i in 0...15 {
                    if (self.hp == max(10, Int(floor(newCPM * Double(baseStamina + i))))) {
                        let arr:NSArray = [Double(i), newCPM, leveled]
                        IndStaValues.add(arr)
                    }
                }
            }
        
        
        if IndStaValues.count <= 0 {
            print("Cannot calculate")
            self.ivLabel.text = "iv_noResult_1".localized(self.language!)
            self.rangeLabel.text = "iv_noResult_2".localized(self.language!)
            resetVariables()
            self.origianlImageVIew.isHidden = true
            return
        }
        
        let possibleIVs: NSMutableArray = NSMutableArray()
        data.possibleIVLevel = NSMutableArray()
        data.possibleLevels = NSMutableArray()
        
        for staIV in IndStaValues as NSArray{
            let letStaIV = staIV as! NSArray
            let IndSta1 = letStaIV[0] as! Double
            print("IndSta: \(IndSta1)")
            for IndAtk in 0...15 {
                for IndDef in 0...15 {
                    let IndSta = letStaIV[0] as! Double
                    let tempCPM = letStaIV[1] as! Double
                    let t0 = Double(baseAttack+IndAtk) * pow(Double(baseDefense+IndDef), 0.5)
                    let t1 = t0 * pow(Double(baseStamina)+IndSta, 0.5) * pow(tempCPM, 2) / 10.0
                    let t2 = Int(floor(t1))
                    let storeCP = max(10, t2)
                
                    // if CP matched get IV
                    if(storeCP == self.cp) {
                        // calculate IV and stored into possibleIVs
                        let tempIV = Double(round(((Double(IndAtk + IndDef) + IndSta) / 45 * 100)*10)/10)
                        let tempLvl = letStaIV[2] as! Double
                        let arr = [tempLvl, tempIV]
                        
                        if data.possibleLevels.index(of: "\(tempLvl)") == NSNotFound {
                            data.possibleLevels.add("\(tempLvl)")
                        }
                        
                        possibleIVs.add(tempIV)
                        data.possibleIVLevel.add(arr)
                    }
                }
            }
        }
        
        // get biggest IV & lowest IV
        if possibleIVs.count <= 0 {
            print("Cannot calculate")
            self.ivLabel.text = "iv_noResult_1".localized(self.language!)
            self.rangeLabel.text = "iv_noResult_2".localized(self.language!)
            resetVariables()
            self.origianlImageVIew.isHidden = false
            return
        }
        
        var bestIV = possibleIVs[0] as! Double
        var worstIV = possibleIVs[0] as! Double
        
        for i in possibleIVs as NSArray {
            if bestIV < i as! Double {
                bestIV = i as! Double
            }
            if worstIV > i as! Double {
                worstIV = i as! Double
            }
        }
        let averageIV = Int(floor((worstIV+bestIV)/2))
        
        if worstIV == bestIV {
            self.ivLabel.text = "IV: \(bestIV)%"
            self.rangeLabel.text = "iv_description".localized(self.language!)
        } else {
            self.ivLabel.text = "iv_MaxLabel".localized(self.language!) + "\(averageIV)%"
            self.rangeLabel.text = "\(worstIV)% ~ \(bestIV)%"
            
            if data.possibleLevels.count > 1 {
                // show narrow down button & store information
                self.instantUploadButton.setTitle("narrowDown_button".localized(self.language!), for: UIControlState())
            }
        }
        resetVariables()
        // hide original image
        self.origianlImageVIew.isHidden = true
        self.instantUploadButton.isHidden = false

        self.pokemonTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.cpTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.hpTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.stardustTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        
        //Create the UIImage
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let tempImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // show FB share Button
        Fbutton.isHidden = false
        let photo : FBSDKSharePhoto = FBSDKSharePhoto()
        let photo1: FBSDKSharePhoto = FBSDKSharePhoto()
        photo.image = tempImage
        photo.isUserGenerated = true
        photo1.image = origianlImageVIew.image
        photo1.isUserGenerated = true
        let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
        content.photos = [photo, photo1]
        Fbutton.shareContent = content

    }
    
    func resetVariables() {
        name = nil
        cp = nil
        hp = nil
        stardust = nil
        baseStat = nil
        
        baseAttack = nil
        baseDefense = nil
        baseStamina = nil
        //show original imageVIew
        self.origianlImageVIew.isHidden = false
        self.instantUploadButton.isHidden = true
        
        //enable buttons
        buttonEnable(true)
        //hide the loading view
        self.hiddenView.isHidden = true
    }
    
    func resetLabels() {
        self.ivLabel.text = ""
        self.rangeLabel.text = ""
        self.pokemonTextField.text = ""
        self.cpTextField.text = ""
        self.hpTextField.text = ""
        self.stardustTextField.text = ""
        self.pokemonTextField.placeholder = ""
        self.cpTextField.placeholder = ""
        self.hpTextField.placeholder = ""
        self.stardustTextField.placeholder = ""
        //hide original imageVIew
        self.origianlImageVIew.isHidden = true
        self.instantUploadButton.isHidden = false
        
        self.pokemonTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.cpTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.hpTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
        self.stardustTextField.layer.borderColor = UIColor( red: 0/255, green: 0/255, blue:0/255, alpha: 1.0 ).cgColor
    }
    
    func buttonEnable(_ bool: Bool) {
        self.submitButton.isEnabled = bool
        self.uploadButton.isEnabled = bool
        self.instantUploadButton.isEnabled = bool
    }

    @IBAction func takePhoto(_ sender: AnyObject) {
        view.endEditing(true)
        // reset variables
        name = nil
        cp = nil
        hp = nil
        stardust = nil
        baseStat = nil
        
        baseAttack = nil
        baseDefense = nil
        baseStamina = nil
        
        //enable buttons
        buttonEnable(true)
        //hide the loading view
        self.hiddenView.isHidden = true
        
        
        
        // check permission of photo library
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            self.hiddenView.isHidden = true
            buttonEnable(true)
            let alert = UIAlertController(title: "Permission error", message: "請到設定允許此程式使用照片圖庫", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                if let url = settingsUrl {
                    UIApplication.shared.openURL(url)
                }
            }))
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func cropToBounds(_ image: UIImage, width: CGFloat, height: CGFloat, posX: CGFloat, posY: CGFloat) -> UIImage {
        
        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        
        //let contextSize: CGSize = contextImage.size
        
        let cgwidth: CGFloat = width
        let cgheight: CGFloat = height
        
        
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        return image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if self.fromSubmit {
            self.data.originImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            data.pokemonNameStored = self.pokemonTextField.text!
            data.cpStored = self.cpTextField.text!
            data.hpStored = self.hpTextField.text!
            data.stardustStored = self.stardustTextField.text!
            data.poweredStored = self.poweredSwitch.isOn
            
            dismiss(animated: true, completion: {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "getLevelViewController") as! pokeLevelViewController
                next.data = self.data
                self.present(next, animated: true, completion: nil)
            })
            
            return
        }
        
        // reset fromSubmit
        self.fromSubmit = false
        
        //reset labels
        resetLabels()
        
        //disable buttons
        buttonEnable(false)
        //show the loading view
        self.hiddenView.isHidden = false
        // hide original image
        self.origianlImageVIew.isHidden = true
        self.instantUploadButton.isHidden = false
        Fbutton.isHidden = true
        
        let oldSelectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        let selectedPhoto = resizeImage(oldSelectedPhoto, newWidth: 750)
        let nidoranImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-730, height: selectedPhoto.size.height-1320, posX: 400.0, posY: 520.0)
        
        var cpImage: UIImage = UIImage()
        var oldStardustImage: UIImage = UIImage()
        var otherImage: UIImage = UIImage()
        if self.deviceName.contains("iPad") {
            oldStardustImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-675, height: selectedPhoto.size.height-1130, posX: 402.0, posY: 900.0)
            cpImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-200, height: CGFloat(55), posX: 0.0, posY: 70.0)
            otherImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-80, height: selectedPhoto.size.height-1140, posX: 50.0, posY: 570.0)
        } else {
            oldStardustImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-650, height: selectedPhoto.size.height-1270, posX: 415.0, posY: 1050.0)
            cpImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-500, height: CGFloat(90), posX: 300.0, posY: 70.0)
            otherImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-50, height: selectedPhoto.size.height-1175, posX: 50.0, posY: 600.0)
        }
        //cpImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-200, height: CGFloat(90), posX: 0.0, posY: 70.0)
        //oldStardustImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-650, height: selectedPhoto.size.height-1270, posX: 410.0, posY: 1050.0)
        //cpImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-200, height: CGFloat(90), posX: 0.0, posY: 70.0)
        //otherImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-50, height: selectedPhoto.size.height-1150, posX: 50.0, posY: 600.0)
        let stardustImage = resizeImage(oldStardustImage, newWidth: 1100)
        
        // set original image
        self.origianlImageVIew.image = oldSelectedPhoto
        
        //Delete asset
        if data.autoDeletePhoto {
            let imageUrl = info[UIImagePickerControllerReferenceURL] as! URL
            let imageUrls = [imageUrl]
        
            PHPhotoLibrary.shared().performChanges( {
                let imageAssetToDelete = PHAsset.fetchAssets(withALAssetURLs: imageUrls, options: nil)
                PHAssetChangeRequest.deleteAssets(imageAssetToDelete)
                }, completionHandler: { success, error in
                    print("Finished deleting asset. %@", (success ? "Success" : error))
            })
        }
        
        addActivityIndicator()
        
        dismiss(animated: true, completion: {
            self.performImageCPRecognition(cpImage)
            self.performImageStardustRecognition(stardustImage)
            self.performImageOtherRecognition(otherImage, nidoranImage: nidoranImage)
            self.calculateIV()
        })
        
        removeActivityIndicator()
    }
    
    func performImageCPRecognition(_ image: UIImage) {
        
        let tesseract = G8Tesseract()
        
        tesseract.language = "eng"
        
        tesseract.engineMode = .tesseractOnly
        
        tesseract.pageSegmentationMode = .auto
       
        tesseract.maximumRecognitionTime = 60.0
        
        tesseract.image = processUsingPixels(inputImage: image)
        
        //UIImageWriteToSavedPhotosAlbum(tesseract.image, nil, nil, nil)
        tesseract.recognize()
        
        let rawText:String = tesseract.recognizedText
        let raw2Text:String = rawText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (raw2Text.contains(" ")) {
            let checkedText:Int? = Int((raw2Text.components(separatedBy: " "))[1].trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted))
            if checkedText != nil {
                self.cp = checkedText
            }
        }else {
            let checkedText:Int? = Int(raw2Text.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted))
            if checkedText != nil {
                self.cp = checkedText
            }
        }
        
        
    }
    
    func performImageStardustRecognition(_ image: UIImage) {
       
        let tesseract = G8Tesseract()
       
        tesseract.language = "eng"
       
        tesseract.engineMode = .tesseractOnly
        
        tesseract.pageSegmentationMode = .auto
      
        tesseract.maximumRecognitionTime = 60.0
        
        tesseract.image = processUsingPixels(inputImage: image)
        
        //UIImageWriteToSavedPhotosAlbum(tesseract.image, nil, nil, nil)
        tesseract.recognize()
        
        if tesseract.recognizedText != nil {
            let checkedText:Int? = Int(tesseract.recognizedText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            if checkedText != nil {
                self.stardust = checkedText
            }
            
        }
    }
    
    func performImageOtherRecognition(_ image: UIImage, nidoranImage: UIImage) {
        
        let tesseract = G8Tesseract(language: "eng+jpn")
        
        //tesseract.engineMode = .CubeOnly
        
        tesseract?.delegate = self
        
        tesseract?.pageSegmentationMode = .auto
        
        tesseract?.maximumRecognitionTime = 60.0
        
        tesseract?.image = processUsingPixels(inputImage: image)
        
        //UIImageWriteToSavedPhotosAlbum(tesseract.image, nil, nil, nil)
        
        tesseract?.recognize()
        
        let rawText:String = tesseract!.recognizedText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        var rawTextArray = rawText.components(separatedBy: CharacterSet.newlines)
        rawTextArray = rawTextArray.filter{ !($0 == "" || $0 == " ") }
        
        if rawTextArray.count > 0 {
            self.name = rawTextArray[0].replacingOccurrences(of: " ", with: "")
            
            // Check if it is Nidoran
            if (self.name.characters.count >= 4) {
                if (self.name.contains("Nidora")) {
                    let color:String = getNidoranSpot(nidoranImage)
                    if color == "purple" {
                        self.name = "Nidoran♂"
                    } else if color == "blue" {
                        self.name = "Nidoran♀"
                    } else {
                        print("identify nidoran_eng error")
                    }
                } else if (self.name.contains("ニドラン")) {
                    let color:String = getNidoranSpot(nidoranImage)
                    if color == "purple" {
                        self.name = "ニドラン♂"
                    } else if color == "blue" {
                        self.name = "ニドラン♀"
                    } else {
                        print("identify nidoran_jpn error")
                    }
                }
            }
            print(rawTextArray)
            
            if rawTextArray.count > 1 {
                var rawText1 = rawTextArray[1].replacingOccurrences(of: " ", with: "")
                rawText1 = rawText1.replacingOccurrences(of: "HP", with: "")
                if rawText1.contains("/"){
                    let checkedText:Int? = Int((rawText1.components(separatedBy: "/"))[1])
                    if (checkedText != nil) {
                        self.hp = checkedText
                    }
                }
            }
        }
    }
    
    func getNidoranSpot(_ inputImage: UIImage) -> String {
        let inputCGImage = inputImage.cgImage
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let width = inputCGImage?.width
        let height = inputCGImage?.height
        let bytesPerPixel: UInt = 4
        let bitsPerComponent: UInt = 8
        let bytesPerRow = Int(bytesPerPixel) * width!
        let bitmapInfo = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        
        let context:CGContext = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: Int(bitsPerComponent), bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)!
        context.draw(inputCGImage!, in: CGRect(x: 0, y: 0, width: CGFloat(width!), height: CGFloat(height!)))
        
        let pixelBuffer = UnsafeMutableRawPointer(context.data!).assumingMemoryBound(to: UInt32.self)
        
        var currentPixel = pixelBuffer
        currentPixel += 5
        let r = Double(red(currentPixel.pointee))
        let g = Double(green(currentPixel.pointee))
        let b = Double(blue(currentPixel.pointee))
       
        if(r >= 130 && r <= 180) && (g >= 90 && g <= 130) && (b >= 140 && b <= 180) {
            // purple nidoran
            return "purple"
        } else {
            // blue nidoran
            return "blue"
        }
        
    }
    
    func processUsingPixels(inputImage: UIImage) -> UIImage {
        let inputCGImage = inputImage.cgImage
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let width = inputCGImage?.width
        let height = inputCGImage?.height
        let bytesPerPixel: UInt = 4
        let bitsPerComponent: UInt = 8
        let bytesPerRow = Int(bytesPerPixel) * width!
        let bitmapInfo = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        
        let context:CGContext = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: Int(bitsPerComponent), bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)!
        context.draw(inputCGImage!, in: CGRect(x: 0, y: 0, width: CGFloat(width!), height: CGFloat(height!)))
        
        let pixelBuffer = UnsafeMutableRawPointer(context.data!).assumingMemoryBound(to: UInt32.self)
        
        var currentPixel = pixelBuffer
        
        for _ in 0 ..< height! {
            for _ in 0 ..< width! {
                currentPixel.pointee = grayScaleFromColor(currentPixel.pointee)
                currentPixel += 1
            }
        }
        
        let outputCGImage = context.makeImage()
        return UIImage(cgImage: outputCGImage!)
    }
    
    func grayScaleFromColor(_ color: UInt32) -> UInt32 {
        let r = Double(red(color))
        let g = Double(green(color))
        let b = Double(blue(color))
        let a = alpha(color)
        
        if !(r >= 200 && g >= 200 && b >= 200) {
            return rgba(0, green: 0, blue: 0, alpha: a)
        }else {
            return rgba(255, green: 255, blue: 255, alpha: a)
        }
        
        //let gray = UInt8(0.2126 * r + 0.7152 * g + 0.0722 * b)
        
        //return rgba(gray, green: gray, blue: gray, alpha: a)
    }
    
    func red(_ color: UInt32) -> UInt8 {
        return UInt8(color & 255)
    }
    
    func green(_ color: UInt32) -> UInt8 {
        return UInt8((color >> 8) & 255)
    }
    
    func blue(_ color: UInt32) -> UInt8 {
        return UInt8((color >> 16) & 255)
    }
    
    func alpha(_ color: UInt32) -> UInt8 {
        return UInt8((color >> 24) & 255)
    }
    
    func rgba(_ red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) -> UInt32 {
        return UInt32(red) | (UInt32(green) << 8) | (UInt32(blue) << 16) | (UInt32(alpha) << 24)
    }
    
    @IBAction func instantUploadClicked(_ sender: AnyObject) {
        // Change to Narrow Down View
        if self.instantUploadButton.titleLabel?.text == "Narrow Down" || self.instantUploadButton.titleLabel?.text == "Try Again" || self.instantUploadButton.titleLabel?.text == "縮小範圍" || self.instantUploadButton.titleLabel?.text == "再試一次"{
            if self.instantUploadButton.titleLabel?.text == "Narrow Down" || self.instantUploadButton.titleLabel?.text == "縮小範圍" {
                if self.fromSubmit {
                    // check permission of photo library
                    if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
                        self.hiddenView.isHidden = true
                        buttonEnable(true)
                        let alert = UIAlertController(title: "Permission error", message: "請到設定允許此程式使用照片圖庫", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                            if let url = settingsUrl {
                                UIApplication.shared.openURL(url)
                            }
                        }))
                        
                        present(alert, animated: true, completion: nil)
                        return
                    }
                    
                    let imagePicker = UIImagePickerController()
                    
                    imagePicker.allowsEditing = false
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary
                    
                    self.present(imagePicker, animated: true, completion: nil)
                } else {
                    self.data.originImage = self.origianlImageVIew.image!
                }
            }
            
            data.pokemonNameStored = self.pokemonTextField.text!
            data.cpStored = self.cpTextField.text!
            data.hpStored = self.hpTextField.text!
            data.stardustStored = self.stardustTextField.text!
            data.poweredStored = self.poweredSwitch.isOn
            
            let next = self.storyboard?.instantiateViewController(withIdentifier: "getLevelViewController") as! pokeLevelViewController
            next.data = data
            self.present(next, animated: true, completion: nil)
            return
        }
        
        self.fromSubmit = false
        
        // disable buttons
        self.buttonEnable(false)
        //reset labels
        self.resetLabels()
        
        //show the loading view
        self.hiddenView.isHidden = false
        Fbutton.isHidden = true
        
        fetchPhotoAtIndexFromEnd(0)
        
        // alert for permission of photo library
        if self.latestPhoto == nil {
            self.hiddenView.isHidden = true
            buttonEnable(true)
            let alert = UIAlertController(title: "Permission error", message: "請到設定允許此程式使用照片圖庫", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                if let url = settingsUrl {
                    UIApplication.shared.openURL(url)
                }
            }))
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        let alert: UIAlertView = UIAlertView()
        alert.title = "Permission error"
        alert.message = "請到設定允許此程式使用照片圖庫"
        alert.addButton(withTitle: "OK")
        //alert.show()
        
        let oldSelectedPhoto = self.latestPhoto
        let selectedPhoto = resizeImage(oldSelectedPhoto!, newWidth: 750)
        let nidoranImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-730, height: selectedPhoto.size.height-1320, posX: 400.0, posY: 520.0)
        
        var cpImage: UIImage = UIImage()
        var oldStardustImage: UIImage = UIImage()
        var otherImage: UIImage = UIImage()
        if self.deviceName.contains("iPad") {
            oldStardustImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-675, height: selectedPhoto.size.height-1130, posX: 402.0, posY: 900.0)
            cpImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-200, height: CGFloat(55), posX: 0.0, posY: 70.0)
            otherImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-80, height: selectedPhoto.size.height-1140, posX: 50.0, posY: 570.0)
        } else {
            oldStardustImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-650, height: selectedPhoto.size.height-1270, posX: 415.0, posY: 1050.0)
            cpImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-500, height: CGFloat(90), posX: 300.0, posY: 70.0)
            otherImage = cropToBounds(selectedPhoto, width: selectedPhoto.size.width-50, height: selectedPhoto.size.height-1175, posX: 50.0, posY: 600.0)
        }
        
        let stardustImage = resizeImage(oldStardustImage, newWidth: 1100)
        
        // set original image
        self.origianlImageVIew.image = oldSelectedPhoto
        
        addActivityIndicator()
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            self.performImageCPRecognition(cpImage)
            self.performImageStardustRecognition(stardustImage)
            self.performImageOtherRecognition(otherImage, nidoranImage: nidoranImage)
            
            DispatchQueue.main.async {
                print("finished!")
                self.calculateIV()
            }
        }
        
        removeActivityIndicator()
    }
        
    func fetchPhotoAtIndexFromEnd(_ index: Int) {
        
        let imgManager = PHImageManager.default()
        
        // Note that if the request is not set to synchronous
        // the requestImageForAsset will return both the image
        // and thumbnail; by setting synchronous to true it
        // will return just the thumbnail
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        // Sort the images by creation date
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions) {
            
            // If the fetch result isn't empty,
            // proceed with the image request
            if fetchResult.count > 0 {
                // Perform the image request
                imgManager.requestImage(for: fetchResult.object(at: fetchResult.count - 1 - index) , targetSize: view.frame.size, contentMode: PHImageContentMode.aspectFill, options: requestOptions, resultHandler: { (image, _) in
                    
                    // Add the returned image to your array
                    self.latestPhoto = image
                    
                    if self.data.autoDeletePhoto {
                        //Delete asset
                        if let fetchedAssets = fetchResult.object(at: fetchResult.count - 1 - index) as? PHAsset {
                    
                            PHPhotoLibrary.shared().performChanges( {
                                // not sure
                                let enumeration: NSArray = [fetchedAssets]
                                PHAssetChangeRequest.deleteAssets(enumeration)
                                }, completionHandler: { success, error in
                                    print("Finished deleting asset. %@", (success ? "Success" : error))
                            })
                        }
                    }
                })
            }
        }
    }

    // ad methods
    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        if products.count > 0 {
            let product = products[0]
            if PokeIVProducts.store.isProductPurchased(product.productIdentifier) {
                self.adBannerView.isHidden = true
            } else if IAPHelper.canMakePayments() {
                self.adBannerView.isHidden = false
            } else {
                self.removeAdButton.isHidden = true
                self.adBannerView.isHidden = false
            }
        }
    }
    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print(error.description)
    }
    
    //mail button action
    @IBAction func mailPressed(_ sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
    
        mailComposerVC.setToRecipients(["snapiv@danielcoding.com"])
        mailComposerVC.setSubject("mail_title".localized(self.language!))
        mailComposerVC.setMessageBody("mail_body".localized(self.language!), isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "此功能目前不適用於iPad", message: "請手動寄回報信至: daniel@danielcoding.com", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    // Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if self.languageJpn {
            return 1
        } else {
            return 2
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.languageJpn {
            return self.tempJpn.count
        } else {
            if component == 0 {
                return pickOption0.count
            } else {
                let letter = pickOption0[currentSelection]
                let arr = pickOption1[letter]
                return arr!.count
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.languageJpn {
            return self.tempJpn[row]
        } else {
            switch component {
            case 0:
                return pickOption0[row]
            case 1:
                let selectedAlpha: String = self.pickOption0[currentSelection]
                switch selectedAlpha {
                case "A":
                    return tempA[row]
                case "B":
                    return tempB[row]
                case "C":
                    return tempC[row]
                case "D":
                    return tempD[row]
                case "E":
                    return tempE[row]
                case "F":
                    return tempF[row]
                case "G":
                    return tempG[row]
                case "H":
                    return tempH[row]
                case "I":
                    return tempI[row]
                case "J":
                    return tempJ[row]
                case "K":
                    return tempK[row]
                case "L":
                    return tempL[row]
                case "M":
                    return tempM[row]
                case "N":
                    return tempN[row]
                case "O":
                    return tempO[row]
                case "P":
                    return tempP[row]
                case "R":
                    return tempR[row]
                case "S":
                    return tempS[row]
                case "T":
                    return tempT[row]
                case "V":
                    return tempV[row]
                case "W":
                    return tempW[row]
                case "Z":
                    return tempZ[row]
                default:
                    break
                }
            default:
                break
            }
            return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.languageJpn {
            let rawText = (tempJpn[row].components(separatedBy: CharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
            self.pokemonTextField.text = rawText.replacingOccurrences(of: "No. ", with: "")
        } else {
            if component == 0 {
                currentSelection = row
                self.pickerView.selectRow(0, inComponent: 1, animated: false)
            } else if component == 1 {
                let tempArray = pickOption1[pickOption0[currentSelection]] as! NSArray
                self.pokemonTextField.text = tempArray[row] as! String
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSettings" {
            let destination = segue.destination as! AdRemoveViewController
            destination.data = data
        }
    }
    
}

extension String {
    var first: String {
        return String(characters.prefix(1))
    }
    var last: String {
        return String(characters.suffix(1))
    }
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
}




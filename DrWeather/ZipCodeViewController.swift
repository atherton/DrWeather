//
//  ZipCodeViewController.swift
//  DrWeather
//
//  Created by Eric Atherton on 7/7/18.
//  Copyright © 2018 Eric Atherton. All rights reserved.
//

import UIKit

class ZipCodeViewController: UIViewController {
    @IBOutlet weak var zipCodeLabel: UILabel! {
        didSet {
            zipCodeLabel.text = "Enter a U.S. ZIP code to see the temperature for the next 5 days"
        }
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.setTitle("Show me some weather!", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        guard let zipCodeStr = textField.text, zipCodeStr.count == 5, let zipCode = Int(zipCodeStr) else {
            // TODO present an alert
            print("not a valid zip code!!")
            return
        }
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "ResultsTableViewController")
            as? ResultsTableViewController else {
                print("couldn't instantiate ResultsTableViewController")
                return
        }
        controller.zipCode = zipCode
        navigationController?.pushViewController(controller, animated: true)
    }
}


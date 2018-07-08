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
            zipCodeLabel.text = "Enter a ZIP code to see its next 5 days of weather"
        }
    }
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
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "ResultsTableViewController")
            as? ResultsTableViewController else {
                print("couldn't instantiate ResultsTableViewController")
                return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}


//
//  ResultsTableViewCell.swift
//  DrWeather
//
//  Created by Eric Atherton on 7/8/18.
//  Copyright © 2018 Eric Atherton. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var highTempLabel: UILabel! {
        didSet {
            format(label: highTempLabel)
            highTempLabel.backgroundColor = .red
            highTempLabel.text = " High: "
        }
    }
    @IBOutlet weak var lowTempLabel: UILabel! {
        didSet {
            format(label: lowTempLabel)
            lowTempLabel.backgroundColor = .blue
            lowTempLabel.text = " Low: "
        }
    }

    private func format(label: UILabel) {
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.textColor = .white
    }
}

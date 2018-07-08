//
//  ResultsTableViewController.swift
//  DrWeather
//
//  Created by Eric Atherton on 7/8/18.
//  Copyright © 2018 Eric Atherton. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "resultsCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath)

        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .red
        }
        return cell
    }
}

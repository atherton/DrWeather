//
//  ResultsTableViewController.swift
//  DrWeather
//
//  Created by Eric Atherton on 7/8/18.
//  Copyright © 2018 Eric Atherton. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var zipCode: Int?
    var forecasts = [WeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        if let zipCode = zipCode {
            title = String(zipCode)
//            getData(for: zipCode)
        }
    }
    
    private func getData(for zipCode: Int) {
        APIManager.getWeather(for: zipCode) { (result) in
            switch result {
            case .success(let forecasts):
                self.forecasts = forecasts
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell",
                                                       for: indexPath) as? ResultsTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.highTempLabel.text?.append("85 ")
        cell.lowTempLabel.text?.append("70 ")
        cell.textLabel?.text = days[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

//
//  ResultHistoryTableViewController.swift
//  CalculatorApp
//
//  Created by Muhammet Yiğit on 1.05.2025.
//

import UIKit

class ResultHistoryTableViewController: UITableViewController {

    // MARK: - UI Elements
    
    // MARK: - Properties
    let resultHistory = ResultHistory.shared.resultHistoryArray
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Delegate & DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result", for: indexPath)
        cell.textLabel?.text = resultHistory[indexPath.row].text
        return cell
    }
}

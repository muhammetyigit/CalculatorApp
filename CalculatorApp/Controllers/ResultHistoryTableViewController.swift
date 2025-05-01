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
    var resultHistory = ResultHistory.shared.resultHistoryArray
    
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
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return cell
    }
    
    // MARK: - Actions
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func trashButtonTapped(_ sender: UIBarButtonItem) {
        resultHistory.removeAll()
        ResultHistory.shared.resultHistoryArray.removeAll()
        tableView.reloadData()
    }
    
}

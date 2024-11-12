//
//  ViewController.swift
//  Interview
//
//  Created by Tiago on 04/04/2019.
//  Copyright © 2019 AJBell. All rights reserved.
//

import UIKit

final class MarketsTableViewController: UITableViewController {
    
    lazy var viewModel: MarketsTableViewModelProtocol = {
        MarketsTableViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.loadMarkets() { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfElements
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let market = viewModel.market(at: indexPath) else {
            return cell
        }
        
        cell.textLabel?.text = viewModel.formattedName(for: market)
        cell.detailTextLabel?.text = market.price
        return cell
    }
}

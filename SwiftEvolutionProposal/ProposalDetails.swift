//
//  ProposalDetails.swift
//  SwiftEvolutionProposal
//
//  Created by Ion Ostafi on 30.12.2021.
//

import Foundation
import UIKit

final class ProposalDetails: UITableViewController {
    public var proposal: JSONDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - TableView delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        proposal.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        let keyIndex = proposal.keys.index(proposal.keys.startIndex, offsetBy: indexPath.row)
        let dictAtIndex = proposal[keyIndex]
        let value = String(describing: dictAtIndex.value)
        config.text = "\(dictAtIndex.key): \(value)"
        cell.contentConfiguration = config
        return cell
    }
}

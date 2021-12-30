//
//  ProposalList.swift
//  SwiftEvolutionProposal
//
//  Created by Ion Ostafi on 28.12.2021.
//

import UIKit

typealias JSONDictionary = [String: Any]

class ProposalList: UITableViewController {
    var proposals: [JSONDictionary]? = nil
    let spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpinner()
        fetchProposals()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        title = "Proposals"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Setup UI

    func setupSpinner() {
        spinner.style = .large
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Data
    func fetchProposals() {
        spinner.startAnimating()
        if let url = URL(string: "https://data.swift.org/swift-evolution/proposals") {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                }
                if let data = data {
                    if let proposals = try? JSONSerialization.jsonObject(with: data, options: []) as? [JSONDictionary] {
                        self.proposals = proposals
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }

    // MARK: - TableView delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proposals?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        if let title = getTitle(at: indexPath.row) {
            config.text = title
        }
        cell.contentConfiguration = config

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let proposal = self.proposals?[indexPath.row], let title = getTitle(at: indexPath.row) {
            let detailsViewController = ProposalDetails()
            detailsViewController.title = title
            detailsViewController.proposal = proposal
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }

    // MARK: - Reusable
    func getTitle(at index: Int) -> String? {
        return proposals?[index].first(where: { (key: String, value: Any) in
            key == "title"
        })?.1 as? String
    }
}


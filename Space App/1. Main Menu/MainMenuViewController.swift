//
//  MainMenuViewController.swift
//  Space App
//
//  Created by Kacper Cichosz on 03/11/2022.
//

import UIKit

class MainMenuViewController: ModelledViewController<MainMenuViewModel> {

	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewModel.update?(.loading)
		self.tableView.register(UINib(nibName: "SpacecraftTableViewCell", bundle: nil),
								forCellReuseIdentifier: "SpacecraftTableViewCell")
	}
	
	override func updateView(_ type: MainMenuViewModel.UpdateType) {
		switch type {
		case .loaded:
			self.tableView.reloadOnMainThread()
		case .loading:
			self.viewModel.downloadData()
		case .reload:
			self.tableView.reloadData()
		}
	}
}

// MARK: - UITableViewDataSource
extension MainMenuViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.spacecrafts?.results.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpacecraftTableViewCell", for: indexPath) as? SpacecraftTableViewCell,
			  let spacecrafts = self.viewModel.spacecrafts?.results else {
			return SpacecraftTableViewCell()
		}
		
		cell.setupCell(spacecraft: spacecrafts[indexPath.row])
		return cell
	}
}

// MARK: - UITableViewDelegate
extension MainMenuViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableView.bounds.height
	}
}

//
//  MainMenuViewModel.swift
//  Space App
//
//  Created by Kacper Cichosz on 04/11/2022.
//

import UIKit

class MainMenuViewModel: ViewModel, ViewModelProtocol {
	var spacecrafts: Spacecraft?
	
	// MARK: - Updates and Errors
	var update: ((MainMenuViewModel.UpdateType) -> Void)?
	enum UpdateType {
		case loading
		case loaded
		case reload
	}
	var error: ((MainMenuViewModel.ErrorType) -> Void)?
	enum ErrorType {
		case canNotProcessData
	}
	
	func downloadData() {
		NetworkManager.shared.downloadData(classType: Spacecraft.self,
										   settingsKey: Constants.Networking.NetworkingAPIKey) { data, _, _ in
			self.spacecrafts = data
			self.update?(.loaded)
		}
	}
}

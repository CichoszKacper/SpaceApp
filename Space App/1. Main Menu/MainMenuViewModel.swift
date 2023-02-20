//
//  MainMenuViewModel.swift
//  Space App
//
//  Created by Kacper Cichosz on 04/11/2022.
//

import SwiftUI
import Kingfisher

class MainMenuViewModel: ObservableObject {
	@Published var spacecrafts: Spacecraft?
	var averageColor: UIColor = .clear
	
	@MainActor func downloadSpacecrafts() async {
		guard self.spacecrafts == nil else { return }
		
		do {
			async let spacecrafts = try NetworkManager.shared.downloadSpacecrafts(settingsKey: Constants.Networking.NetworkingAPIKey)
			
			let spacecraftsResults = try await spacecrafts
			
			self.spacecrafts = spacecraftsResults
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func downloadBackgroundImage() -> URL? {
		let spacecraftToUseImage = self.returnRandomSpacecraft()
		guard let url = URL(string: spacecraftToUseImage?.spacecraftConfig.imageURL ?? "") else {
			return nil
		}
		
		return url
	}
	
	func returnRandomSpacecraft() -> Result? {
		if let spacecrafts = self.spacecrafts?.results {
				return spacecrafts.first(where: {$0.name == "Space Shuttle Challenger"})
		}
		return nil
	}
}

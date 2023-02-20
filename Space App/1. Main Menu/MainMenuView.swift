//
//  MainMenuView.swift
//  Space App
//
//  Created by Kacper Cichosz on 2/9/23.
//

import SwiftUI

struct MainMenuView: View {
	@StateObject var viewModel: MainMenuViewModel
    var body: some View {
		ZStack {
			AsyncImage(
				url: self.viewModel.downloadBackgroundImage(),
				content: { image in
					image.resizable()
						.aspectRatio(contentMode: .fill)
						.ignoresSafeArea()
				},
				placeholder: {
					ProgressView()
				}
			)
		}
		.background(Color(uiColor: self.viewModel.averageColor))
		.task {
			await self.viewModel.downloadSpacecrafts()
		}
    }
}

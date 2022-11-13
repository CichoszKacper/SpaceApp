//
//  SpacecraftTableViewCell.swift
//  Space App
//
//  Created by Kacper Cichosz on 10/11/2022.
//

import UIKit
import Kingfisher

class SpacecraftTableViewCell: UITableViewCell {

	@IBOutlet weak var spacecraftImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	func setupCell(spacecraft: Result) {
		self.spacecraftImageView.blurCorners(radius: 5)
		self.titleLabel.text = spacecraft.name
		self.descriptionLabel.text = spacecraft.resultDescription
		self.spacecraftImageView.kf.indicatorType = .activity
		self.spacecraftImageView.kf.setImage(with: URL(string: spacecraft.spacecraftConfig.imageURL)) { _ in
			self.contentView.backgroundColor = self.spacecraftImageView.image?.averageColor
		}
	}
}

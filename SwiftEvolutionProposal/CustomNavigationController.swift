//
//  CustomNavigationController.swift
//  SwiftEvolutionProposal
//
//  Created by Ion Ostafi on 30.12.2021.
//

import Foundation
import UIKit

final class CustomNavigationController: UINavigationController, UINavigationBarDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        navigationBar.prefersLargeTitles = true
    }

    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        item.setValue(1, forKey: "__largeTitleTwoLineMode")
        return true
    }
}

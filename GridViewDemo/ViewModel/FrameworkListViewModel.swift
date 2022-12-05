//
//  FrameworkListViewModel.swift
//  GridViewDemo
//
//  Created by Aaron on 2022/12/04.
//

import Foundation
import Combine

final class FrameworkListViewModel {
    init(items: [AppleFrameworkModel], selectedItem: AppleFrameworkModel? = nil) {
        self.frameworks = CurrentValueSubject(items)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    
    // Data => Output
    let frameworks: CurrentValueSubject<[AppleFrameworkModel], Never>
    let selectedItem: CurrentValueSubject<AppleFrameworkModel?, Never>
    
    
    // User Action => Input
    func didSelect(at indexPath: IndexPath) {
        let framework = frameworks.value[indexPath.item]
        print(">>> Selected: \(framework.name)")
        selectedItem.send(framework)
    }
}

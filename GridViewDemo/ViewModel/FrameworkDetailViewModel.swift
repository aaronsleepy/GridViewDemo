//
//  FrameworkDetailViewModel.swift
//  GridViewDemo
//
//  Created by Aaron on 2022/12/04.
//

import Foundation
import Combine

final class FrameworkDetailViewModel {
    init(framework: AppleFrameworkModel) {
        self.framework = CurrentValueSubject(framework)
    }
    
    // Data => Output
    var framework: CurrentValueSubject<AppleFrameworkModel, Never>
    
    // User Action => Input
    let buttonTapped = PassthroughSubject<AppleFrameworkModel, Never>()
    
    func learenMoreTapped() {
        buttonTapped.send(framework.value)
    }
}

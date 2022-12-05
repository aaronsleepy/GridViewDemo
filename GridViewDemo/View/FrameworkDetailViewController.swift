//
//  FrameworkDetailViewController.swift
//  GridViewDemo
//
//  Created by Aaron on 2022/11/24.
//

import UIKit
import SafariServices
import Combine

class FrameworkDetailViewController: UIViewController {
    
//    @Published var framework: AppleFrameworkModel = AppleFrameworkModel(name: "Unknown", imageName: "", urlString: "", description: "")
    
    // Combine
    var subscriptions = Set<AnyCancellable>()
    
    // ViewModel
    var viewModel: FrameworkDetailViewModel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        // input: Button tapped
        // framework -> url -> safari -> present
        viewModel.buttonTapped
            .receive(on: RunLoop.main)
            .compactMap { framework in
            URL(string: framework.urlString)
        }
            .sink { url in
            let safari = SFSafariViewController(url: url)
            self.present(safari, animated: true)
                
            }.store(in: &subscriptions)
        
        // output: Data 설정될 때 UI 업데이트
        viewModel.framework
            .receive(on: RunLoop.main)
            .sink { item in
                self.updateUI(item: item)
            }.store(in: &subscriptions)
    }
    
    func updateUI(item framework: AppleFrameworkModel) {
        imageView.image = UIImage(named: framework.imageName)
        titleLabel.text = framework.name
        descriptionLabel.text = framework.description
    }
    
    
    @IBAction func learnMoreTapped(_ sender: Any) {
        viewModel.learenMoreTapped()
    }
    
    
}

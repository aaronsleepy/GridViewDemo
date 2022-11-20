//
//  ViewController.swift
//  GridViewDemo
//
//  Created by Aaron on 2022/11/19.
//

import UIKit

class GridViewDemoViewController: UIViewController {
    let frameworks: [AppleFrameworkModel] = AppleFrameworkModel.list
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
     }
}

extension GridViewDemoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framework = frameworks[indexPath.item]
        print(">>> Selected: \(framework.name)")
    }
}

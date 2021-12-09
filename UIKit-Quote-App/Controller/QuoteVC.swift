//
//  QuoteVC.swift
//  UIKit-Quote-App
//
//  Created by Pavan Mikkilineni on 08/12/21.
//

import UIKit

class QuoteVC: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get quote from api
        NetWorkManager.shared.getQuote{ result in
            switch result{
              case .success(let quote):
                 self.updateUI(with: quote)
              case .failure(let error):
                 print(error.rawValue)
            }
        }
    
    }

    func updateUI(with:Quote){
        DispatchQueue.main.async {
            self.quoteLabel.text = "\"\(with.text)\""
            self.authorLabel.text = "- \(with.author)"
        }
        
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        NetWorkManager.shared.getQuote{ result in
            switch result{
              case .success(let quote):
                 self.updateUI(with: quote)
              case .failure(let error):
                 print(error.rawValue)
            }
        }
    }
    
}


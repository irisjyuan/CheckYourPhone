//
//  ViewController.swift
//  CheckYourEmail
//
//  Created by Iris Yuan on 11/28/18.
//  Copyright © 2018 Iris Yuan. All rights reserved.
//

import UIKit
//import MessageUI
//import Foundation
//import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var emailInputBoxView: UIView!
    @IBOutlet weak var emailInputView: UIStackView!
    @IBOutlet weak var emailInputLabel: UILabel!
    @IBOutlet weak var emailInputTextField: UITextField!

    @IBOutlet weak var quoteLabel: UILabel!
    
    let quotes = ["Can February march? No but April may.",
                  "What kind of shorts do clouds wear? Thunderwear!",
                  "Donut worry, be happy!",
                  "Let’s taco bout it!",
                  "After an explosion at a French cheese factory, all that was left was de brie.",
                  "When should you keep an eye on your cheese? When it’s up to no gouda!",
                  "What do you call a magic dog? A labracadabador.",
                  "What do you call a pig that does karate? Pork chop!",
                  "What do you call a cow with no legs? Ground beef!",
                  "Avocados, avocatres, avoquatro.",
                  "Is my pun irr-elephant?",
                  "You cheetah! No you lion!",
                  "Velcro is just a big rip-off.",
                  "I asked my boss if I can come to work a little late today. He said “Dream on.” I think that was really nice of him.",
                  "What do you call somebody who keeps abandoning their diet plans? A desserter.",
                  "I told my girlfriend to come with me to the gym. Then I stood her up. Hopefully, she’ll realize the two of us are not going to work out.",
                  "Why was the chef arrested? He was beating eggs every day.",
                  "Which country’s capital is the fastest growing? Ireland’s. Every year it’s Dublin.",
                  "One pen to the other: You are INKredible.",
                  "Two wi-fi antennas got married last Saturday. The reception was fantastic.",
                  "Why don’t teddy bears ever really eat at their picnics? Because they’re already stuffed.",
                  "Why are programmers no fans of the outdoors? There are too many bugs.",
                  "Why is the math book so sad? It's got too many problems!",
                  "How do you organize a fantastic space party? You planet.",
                  "What did the fish say when it hit its head on a wall? Dam!!!",
                  "What is the computer’s favorite food? Microchips.",
                  "Why is a skeleton a bad liar? You can see right through it.",
                  "A man sued an airline company after it lost his luggage. Sadly, he lost his case.",
                  "37 consonants, 25 vowels, a question mark, and a comma went to court. They will be sentenced next Friday.",
                  "I just found out I’m colorblind. The diagnosis came completely out of the purple.",
                  "Code-blooded"]
    
    @IBOutlet weak var changeMessageLabel: UIButton!
    @IBOutlet weak var sendEmailLabel: UIButton!
    
    func setupViews() {
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.45
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        emailInputBoxView.layer.cornerRadius = 8
        emailInputBoxView.layer.masksToBounds = true
        
        quoteLabel.layer.cornerRadius = 8
        quoteLabel.layer.masksToBounds = true
        
        changeMessageLabel.layer.cornerRadius = 8
        changeMessageLabel.layer.masksToBounds = true
        
        sendEmailLabel.layer.cornerRadius = 8
        sendEmailLabel.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupViews()
    }

    @IBAction func changeMessageButton(_ sender: Any) {
        
        let maxQuoteNumber = UInt32(quotes.count)
        let randomQuoteNumber = Int(arc4random_uniform(maxQuoteNumber))
        
        quoteLabel.text = quotes[randomQuoteNumber]
    }
    
    @IBAction func sendEmailButton(_ sender: Any) {
        
        var messageToSend = quoteLabel.text
        quoteLabel.text = "Text sent!"
        emailInputTextField.text = ""
        
        let url = URL(string: "http://localhost:8080/send")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let postString = "message=" + messageToSend! + "&to=+16502835523 "
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
}


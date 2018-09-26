//
//  ViewController.swift
//  simon
//
//  Created by ALEJANDRO MORA on 9/20/18.
//  Copyright © 2018 ALEJANDRO MORA. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var colorDisplays: [UIView]!
    @IBOutlet weak var onStartButtonTapped: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var colorsFrame: UIView!
    
    var sound: AVAudioPlayer?
    var timer = Timer()
    var pattern = [Int]()
    var index = 0
    var playerTurn = false
    var gameOver = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func playSound(fileName: String){
        if let path = Bundle.main.path(forResource: fileName, ofType:"wav"){
            let  url = URL(fileURLWithPath: path)
            do{
                self.sound = try AVAudioPlayer(contentsOf: url)
                self.sound?.play()
                
            }
            catch {
                print("cant find file")
            }
            
        }
    }
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        for number in 0..<colorDisplays.count{
            if colorDisplays[number].frame.contains(sender.location(in: colorsFrame)){
                flashColor(number: number)
                index += 1 
            }
        }
    }
    @IBAction func onStartButtonTapped(_ sender: UIButton) {
    }
    
    func addToPattern(){
        pattern.append(Int(arc4random_uniform(4)))
    }
    func restart(){
        pattern.removeAll()
        index = 0
        addToPattern()
        onStartButtonTapped.alpha = 1.0
    }
    func flashColor(number: Int){
        self.playSound(fileName: String(number))
        UIView.transition(with: colorDisplays[number], duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.colorDisplays[number].alpha = 1.0
        }) { (true) in
            UIView.transition(with: self.colorDisplays[number], duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.colorDisplays[number].alpha = 0.4
            }, completion: nil)
        }
    }
    func displayPattern() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.nextColor), userInfo: nil, repeats: true)
    }
    @objc func nextColor() {
        if index < pattern.count {
            flashColor(number: pattern[index])
            index += 1
        }
        else {
            timer.invalidate()
            index = 0
            playerTurn = true
            messageLabel.text  = "your .turn"
        }
        
        
        
        
        
        
        
    }
    
}

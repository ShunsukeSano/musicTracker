//
//  ViewController.swift
//  musicTracker
//
//  Created by 佐野隼輔 on 2019/09/10.
//  Copyright © 2019 佐野隼輔. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet weak var ttlArea: UITextField!
    var canSendServer:Bool = true
    var player = MPMusicPlayerController.systemMusicPlayer
    
    @IBAction func agreeBtn(_ sender: UISwitch) {
        canSendServer = sender.isOn
        ttlArea.text = "値変わったよ"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showMusicInfo()
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(showMusicInfo), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        player.beginGeneratingPlaybackNotifications()
    }
    
    @objc func showMusicInfo() {
        if let music = player.nowPlayingItem {
            if let title = music.title {
                ttlArea.text = title
                print(title)
            } else {
                ttlArea.text = "---"
            }
        }
    }
}

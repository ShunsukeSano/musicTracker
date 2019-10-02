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
            let title = music.title ?? ""
            let artist = music.artist ?? ""
            
            if title != "" {
                ttlArea.text = title
            } else {
                ttlArea.text = "---"
            }
            sendData(title:title, artist: artist)
        }
    }
    func sendData(title:String, artist:String) {
        let urlString = "http://localhost:8888/test/postTest.php"
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let param:[String:Any] = [
            "title": title,
            "artist": artist
        ]
        print(param)
    }
}

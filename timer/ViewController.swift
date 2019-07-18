import UIKit

class ViewController: UIViewController {

    //OUTLETS
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    //VARIABLES
    var seconds = 300
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume",for: .normal)
            
        } else {
            runTimer()
            self.resumeTapped = false
            self.pauseButton.setTitle("Pause",for: .normal)
        }

    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timer.invalidate()
        seconds = 300
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true

    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            
// WILL SEND ALERT WHEN TIMERS COMPLETE
            let alert = UIAlertController(title: "Times Up!", message: "Meditation Complete.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
}

















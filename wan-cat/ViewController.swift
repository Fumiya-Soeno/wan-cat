import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    var catCount = 0
    var dogCount = 0
    
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var awesomeLabel: UILabel!
    @IBOutlet weak var buttonCat: UIButton!
    @IBOutlet weak var buttonDog: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var inputText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.tapped_window(_:)))
        
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        let realm = try! Realm()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        for num in realm.objects(Tweet.self){
            textView.text.append("\n\(formatter.string(from: num.createdAt)) \(num.body)")
        }
        label.text = "ラベル"
        print(UIFont.fontNames(forFamilyName: "Font Awesome 5 Brands"))
        awesomeLabel.font = UIFont(name: "FontAwesome5Brands-Regular", size: 20)
        awesomeLabel.text = "twitter"
        awesomeLabel.textColor = UIColor(hex: "00ACEE")
        let buttonSize = UIFont.systemFont(ofSize: 60)
        buttonCat.setTitle("追加", for: .normal)
        buttonDog.setTitle("削除", for: .normal)
        label.font = buttonSize
        buttonCat.titleLabel?.font = buttonSize
        buttonDog.titleLabel?.font = buttonSize
    }

    @IBAction func closeTextField(_ sender: UITextField) {
        let realm = try! Realm()
        let tweet: Tweet = Tweet.create(realm: realm)
        guard let body = sender.text else { return }
        tweet.body = body
        try! realm.write() {
            realm.add(tweet)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        textView.text.append("\n\(formatter.string(from: tweet.createdAt)) \(tweet.body)")
        inputText.text = ""
    }
    
    @objc func tapped_window(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            inputText.endEditing(true)
        }
    }
    
    
    func tapped(model: Optional<String>, count: inout Int){
        guard let unwrapped = model else { return }
        count += 1
        label.text = "\(unwrapped)+\(count)"
    }
    @IBAction func tapCat(_ sender: Any) {
        tapped(model: buttonCat.currentTitle, count: &catCount)
    }
    @IBAction func tapDog(_ sender: Any) {
        tapped(model: buttonDog.currentTitle, count: &dogCount)
        
        let realm = try! Realm()
        let human = realm.objects(Human.self).filter("name == '田中'")
        let tweet = realm.objects(Tweet.self)
        textView.text = "ツイートが表示されます"
        try! realm.write {
            realm.delete(human)
            realm.delete(tweet)
        }
        for num in realm.objects(Human.self){
            print(num)
        }
    }
}

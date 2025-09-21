import UIKit
import WebKit

class ViewController: UIViewController {
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // UI changes must happen on main thread
        view.addSubview(webView)
        webView.frame = view.bounds // or use Auto Layout

        // Create URL (cheap operation)
        guard let url = URL(string: "https://app.achieveropraexam.com/") else {
            return
        }

        // Do ANY heavy or blocking work on a background queue
        DispatchQueue.global(qos: .userInitiated).async {
            // Example of heavy work you might do off the main thread:
            // - Synchronously downloading something (not recommended),
            // - Checking a local file,
            // - Preparing/processing data

            // Here we only create the URLRequest (this is cheap),
            // but if you had blocking work, do it here.
            let request = URLRequest(url: url)

            // Now return to the main thread to update UI (load the web view)
            DispatchQueue.main.async {
                self.webView.load(request)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}


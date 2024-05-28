import UIKit

//MARK: - Abstraction: Analytical Services

protocol AnalyticalEngine {
    func sendAnalyticsEvent(name: String, metaData: [String: String])
}

enum AnalyticalEvent {
    case screenViewed
    case screenTapped
    case screenAppeared
    case buttonTapped
}

extension AnalyticalEvent {
    var name: String {
        switch self {
        case .screenViewed:
            return "screenViewed"
        case .screenTapped:
            return "screenTapped"
        case .screenAppeared:
            return "screenAppeared"
        case .buttonTapped:
            return "buttonTapped"
        }
    }
    
    var metaData: [String: String] {
        switch self {
        default:
            return [:]
        }
    }
}

final class AnalyticalManager {
    private let engine: AnalyticalEngine
    
    init(engine: AnalyticalEngine) {
        self.engine = engine
    }
    
    func log(_ event: AnalyticalEvent) {
        engine.sendAnalyticsEvent(name: event.name, metaData: event.metaData)
    }
}



//MARK: - Module: Analytical frameworks

class CloudKitAnalyticsEngine: AnalyticalEngine {
    func sendAnalyticsEvent(name: String, metaData: [String : String]) {
        // send event to the database
        print(name, metaData)
    }
}

class FirebaseAnalyticsEngine: AnalyticalEngine {
    func sendAnalyticsEvent(name: String, metaData: [String : String]) {
        // send event to the database
        print(name, metaData)
    }
}

//MARK: - Module: ViewControllers

class SomeViewController: UIViewController {
    private let analytics: AnalyticalManager
    
    init(analytics: AnalyticalManager) {
        self.analytics = analytics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidAppear() {
        analytics.log(.screenAppeared)
    }
}








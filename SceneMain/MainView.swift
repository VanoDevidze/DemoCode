import Foundation
import UIKit

class MainView: UIView {
    
    lazy var menuView: MenuView = {
        let view = MenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()
    
    lazy var kolodaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 16.0
        view.clipsToBounds = true
        return view
    }()
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleHeader.text = "SomeName"
        return view
    }()
    
    lazy var bottomView: BottomView = {
        let view = BottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16.0
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatalError")
    }
    
    private func addViews() {
        addSubview(menuView)
        addSubview(headerView)
        addSubview(contentView)
        contentView.addSubview(kolodaView)
        addSubview(shadowView)
        addSubview(bottomView)
    }
    
    private func setConstraint() {
    
        let leftMenuMarginClose = 0.0;
        let bottomMenu = 60.0
        let bottomKolodaViewMargin = 72.0 + bottomMenu
        let topHeaderSize = 60.0
        let defaultBottomHeightSize = 64.0
        
        NSLayoutConstraint.activate([
        
            // Header View
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: topHeaderSize),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            // Bottom View
            bottomView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -defaultBottomHeightSize),
            bottomView.heightAnchor.constraint(equalToConstant: defaultBottomHeightSize + 600.0),
            bottomView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            // Menu View
            menuView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            menuView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            menuView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: -30.0),
            menuView.widthAnchor.constraint(equalTo: widthAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: leftMenuMarginClose),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            // Shadow View
            shadowView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            shadowView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            // Koloda View
            kolodaView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 24.0),
            kolodaView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -48.0),
            kolodaView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            kolodaView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -bottomKolodaViewMargin),
   
        ])
    }
}

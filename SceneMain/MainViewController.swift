
import UIKit

protocol MainDisplayLogic: AnyObject {
    func displaySomething(viewModel: Main.Model.ViewModel.ViewModelType)
}

class MainViewController: UIViewController, MainDisplayLogic {
    
    // MARK: Property
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    
    private let mainView = MainView()
    private let networkingService: Networking = NetworkService()
    private var mainListViewModel = MainListViewModel.init(cells: [])
    
    var menuTableView: UITableView!
    private var menuListViewModel = MenuListViewModel.init(items: [])
    private var menuIsOpen = false
    
    var categoryTableView: UITableView!
    private var categoryViewModel = CategoryViewModel.init(items: [])
    private var categoryIsOpen = false

    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupResponsibility()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupResponsibility()
    }
    
    // MARK: View lifecycle
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        
        interactor?.sendRequest(request: Main.Model.Request.RequestType.getBiologicalItems)
        interactor?.sendRequest(request: Main.Model.Request.RequestType.getMenuItems)
        interactor?.sendRequest(request: Main.Model.Request.RequestType.getCategoryItems)
    }
    
    // MARK: Setup
    private func setupResponsibility() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupViews() {
        menuTableView = mainView.menuView.tableView
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        
        categoryTableView = mainView.bottomView.categoryTableView
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        
        view = mainView
    }
    
    private func addTargets() {
        
        self.mainView.headerView.menuButton.addTarget(self, action: #selector (toggleMenu), for: .touchUpInside)
        self.mainView.bottomView.categoryButton.addTarget(self, action: #selector (toggleCategory), for: .touchUpInside)
        let tapForCategory = UITapGestureRecognizer(target: self, action: #selector (toggleCategory))
        self.mainView.shadowView.addGestureRecognizer(tapForCategory)
        
        let tapForMenu = UITapGestureRecognizer(target: self, action: #selector (toggleMenuTap))
        self.mainView.contentView.addGestureRecognizer(tapForMenu)
   
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: Display
    func displaySomething(viewModel: Main.Model.ViewModel.ViewModelType) {
        switch viewModel {
        case .displaySetBio(let mainListViewModel):
            self.mainListViewModel = mainListViewModel
            
        case .displayMenu(let menuListViewModel):
            self.menuListViewModel = menuListViewModel
            
        case .displayCategory(let categoryViewModel):
            self.categoryViewModel = categoryViewModel
            categoryTableView.reloadData()
            print("categoryViewModel \(categoryViewModel.items)")
        }
    }
    
    @objc func toggleCategory() {
        print("toggleCategory")
        categoryAction()
    }
    
    func categoryAction() {
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            
            if self.categoryIsOpen {
                self.mainView.bottomView.transform = .init(translationX: 0, y: 0)
                self.mainView.shadowView.alpha = 0
                self.mainView.bottomView.categoryTableView.alpha = 0.0
            } else {
                self.mainView.bottomView.transform = .init(translationX: 0, y: -550.0)
                self.mainView.shadowView.alpha = 0.6
                self.mainView.bottomView.categoryTableView.alpha = 1.0
            }
            self.categoryIsOpen.toggle()
            
        } completion: { res in
            print("log :: completion menu")
        }
    }
    
    @objc func toggleMenu() {
        menuAction()
    }
    
    @objc func toggleMenuTap() {
        if menuIsOpen {
            menuAction()
        }
    }
    
    func menuAction() {
        let leftMenuMarginOpen = UIScreen.main.bounds.width / 1.75;
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            if self.menuIsOpen {
                self.mainView.contentView.transform = .init(translationX: 0, y: 0)
                self.mainView.menuView.transform = .init(translationX: 0.0, y: 0.0)
                self.mainView.headerView.menuButton.setImage(UIImage(named: "FrameOpenMenu"), for: .normal)
                self.mainView.headerView.titleHeader.text = "Menu"
            } else {
                self.mainView.contentView.transform = .init(translationX: leftMenuMarginOpen, y: 0)
                self.mainView.menuView.transform = .init(translationX: 30.0, y: 0.0)
                self.mainView.headerView.menuButton.setImage(UIImage(named: "FrameCloseMenu"), for: .normal)
                self.mainView.headerView.titleHeader.text = "Menu"
            }
            self.menuIsOpen.toggle()
            
        } completion: { res in
            print("log :: completion menu")
        }
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menuTableView {
            return menuListViewModel.items.count
        } else if tableView == categoryTableView {
            return categoryViewModel.items.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == menuTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell
            let viewModel = menuListViewModel.items[indexPath.row]
            cell.set(viewModel: viewModel)
            return cell
            
        } else if tableView == categoryTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
            
            let viewModel = categoryViewModel.items[indexPath.row]
            
            cell.set(viewModel: viewModel)
            return cell
            
        } else {
            return UITableViewCell()
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}

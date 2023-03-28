import UIKit

enum Main {
    enum Model {
        struct Request {
            enum RequestType {
                case getBiologicalItems
                case getMenuItems
                case getCategoryItems
            }
        }
        struct Response {
            enum ResponseType {
                case presentBiological(bio: BioResponse)
                case presentMenu(menu: MenuListViewModel)
                case presentCategory(category: CategoryResponse)
            }
        }
        struct ViewModel {
            enum ViewModelType {
                case displaySetBio(mainListViewModel: MainListViewModel)
                case displayMenu(menuListViewModel: MenuListViewModel)
                case displayCategory(categoryViewModel: CategoryViewModel)
            }
        }
    }
}

struct MainListViewModel {
    struct Cell: MainListViewModelProtocol {
        var name: String
        var nameInter: String
        var nameFamily: String
        var status: String
        var image: String
    }
    let cells: [Cell]
}

struct MenuListViewModel {
    struct Item: MenuViewModelProtocol {
        var name: String
        var ico: String
    }
    let items: [Item]
}

struct CategoryViewModel {
    struct Item: CategoryViewModelProtocol {
        var id: String
        var name: String
        var ico: String
    }
    let items: [Item]
}

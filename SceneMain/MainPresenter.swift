
import UIKit

protocol MainPresentationLogic {
    func presentationData(response: Main.Model.Response.ResponseType)
}

class MainPresenter: MainPresentationLogic {
    
    weak var viewController: MainDisplayLogic?
    
    // MARK: Do something
    
    func presentationData(response: Main.Model.Response.ResponseType) {
        
        switch response {
        case .presentBiological(let bio):
            let cells = bio.bio.map { cellViewModel(from: $0) }
            let mainListViewModel = MainListViewModel(cells: cells)
            let viewModel = Main.Model.ViewModel.ViewModelType.displaySetBio(mainListViewModel: mainListViewModel)
            viewController?.displaySomething(viewModel: viewModel)
            
        case .presentMenu(let menu):
            viewController?.displaySomething(viewModel: Main.Model.ViewModel.ViewModelType.displayMenu(menuListViewModel: menu))
            
        case .presentCategory(let category):
            
            let items = category.categories.map { cellCategoryViewModel(from: $0) }
            let categoryViewModel = CategoryViewModel(items: items)
            let viewModel = Main.Model.ViewModel.ViewModelType.displayCategory(categoryViewModel: categoryViewModel)
            viewController?.displaySomething(viewModel: viewModel)
            
        }
        
    }
    
    private func cellViewModel(from bioItem: Bio) -> MainListViewModel.Cell {
        return MainListViewModel.Cell.init(
            name: bioItem.subName ?? "",
            nameInter: bioItem.subNameInter ?? "",
            nameFamily: bioItem.familyName ?? "",
            status: "-",
            image: bioItem.imageURL ?? ""
        )
    }
    
    private func cellCategoryViewModel(from categoryItem: Category) -> CategoryViewModel.Item {
        return CategoryViewModel.Item.init(id: categoryItem.id, name: categoryItem.name, ico: "-")
    }
    
}

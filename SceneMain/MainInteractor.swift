

import UIKit

protocol MainBusinessLogic {
    func sendRequest(request: Main.Model.Request.RequestType)
}

protocol MainDataStore {
 
}

class MainInteractor: MainBusinessLogic, MainDataStore {

    var presenter: MainPresentationLogic?

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    func sendRequest(request: Main.Model.Request.RequestType) {
        switch request {
        case .getBiologicalItems:
            fetcher.getBiological { [weak self] bioResponse in
                guard let bioResponse = bioResponse else { return }
                let response = Main.Model.Response.ResponseType.presentBiological(bio: bioResponse)
                self?.presenter?.presentationData(response: response)
            }
            
        case .getMenuItems:
            let response =  Main.Model.Response.ResponseType.presentMenu(menu: MenuStaticData.getMenu())
            self.presenter?.presentationData(response: response)
        
        case .getCategoryItems:
            fetcher.getCategories { [weak self] categoryResponse in
                guard let categoryResponse = categoryResponse else { return }
                let response = Main.Model.Response.ResponseType.presentCategory(category: categoryResponse)
                self?.presenter?.presentationData(response: response)
            }
            
        }
        
    }
       

    
}

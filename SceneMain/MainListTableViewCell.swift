import Foundation
import UIKit

protocol MainListViewModelProtocol {
    var name: String { get }
    var nameInter: String { get }
    var nameFamily: String { get }
    var status: String { get }
    var image: String { get }
    
}

class MainListTableViewCell: UITableViewCell {
    static let identification = "MainListTableViewCell"
    
    @IBOutlet weak var cardImageView: WebImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardNameInter: UILabel!
    @IBOutlet weak var cardFamilyName: UILabel!
    @IBOutlet weak var cardStatus: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: MainListViewModelProtocol) {
        cardName.text = viewModel.name
        cardNameInter.text = viewModel.nameInter
        cardFamilyName.text = viewModel.nameFamily
        
        cardImageView.set(imageUrl: viewModel.image)
        cardImageView.contentMode = .scaleAspectFill
    }
}

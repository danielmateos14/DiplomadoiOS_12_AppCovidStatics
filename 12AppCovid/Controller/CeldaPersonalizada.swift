//
//  CeldaPersonalizada.swift
//  12AppCovid
//
//  Created by djdenielb on 30/04/22.
//

import UIKit

class CeldaPersonalizada: UITableViewCell {
//    variables graficas
    @IBOutlet weak var ivBandera: UIImageView!
    @IBOutlet weak var labelPais: UILabel!
    @IBOutlet weak var casosDarios: UILabel!
    @IBOutlet weak var muertesDiarias: UILabel!
    @IBOutlet weak var recuperadosDiarios: UILabel!
    @IBOutlet weak var labelMuertesEnRojo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

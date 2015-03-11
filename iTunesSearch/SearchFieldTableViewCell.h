//
//  SearchFieldTableViewCell.h
//  iTunesSearch
//
//  Created by Gabriel Alberto de Jesus Preto on 11/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchFieldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *buttonBusca;
@property (weak, nonatomic) IBOutlet UITextField *textBusca;
- (IBAction)buscarMidias:(id)sender;

@end

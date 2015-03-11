//
//  SearchFieldTableViewCell.m
//  iTunesSearch
//
//  Created by Gabriel Alberto de Jesus Preto on 11/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "SearchFieldTableViewCell.h"
#import "iTunesManager.h"

@implementation SearchFieldTableViewCell
@synthesize buttonBusca;
- (void)awakeFromNib {
    [buttonBusca setTitle:NSLocalizedString(@"Buscar",nil) forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buscarMidias:(id)sender {
//    iTunesManager *itunes = [[iTunesManager alloc]init];
//    [itunes buscarMidias:_textBusca.text];
//    [self reloadData
    
}

@end

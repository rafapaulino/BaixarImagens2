//
//  PrincipalViewController.h
//  BaixarImagens2
//
//  Created by Rafael Brigagão Paulino on 25/08/12.
//  Copyright (c) 2012 Rafael Brigagão Paulino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrincipalViewController : UIViewController

//criando as referencias dos objetos da view

//imageview
@property (nonatomic, weak) IBOutlet UIImageView *image1;
@property (nonatomic, weak) IBOutlet UIImageView *image2;
@property (nonatomic, weak) IBOutlet UIImageView *image3;
@property (nonatomic, weak) IBOutlet UIImageView *image4;

//buttons
@property (nonatomic, weak) IBOutlet UIButton *botaoTodas;
@property (nonatomic, weak) IBOutlet UIButton *botaoThread;

//carregando
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *carregando;


//metodo que dispara a acao do botao
-(IBAction)botaoClicado:(id)sender;


@end

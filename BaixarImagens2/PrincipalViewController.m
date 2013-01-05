//
//  PrincipalViewController.m
//  BaixarImagens2
//
//  Created by Rafael Brigagão Paulino on 25/08/12.
//  Copyright (c) 2012 Rafael Brigagão Paulino. All rights reserved.
//

#import "PrincipalViewController.h"

@interface PrincipalViewController ()
{
    //declarando aqui o valor fica private e só é visto nessa classe
    int qtdeFotosBaixadas;
    int totalFotos;
}
@end

@implementation PrincipalViewController


-(IBAction)botaoClicado:(id)sender
{
    //setando os valores iniciais quando o botao for clicado
    _image1.image = nil;
    _image2.image = nil;
    _image3.image = nil;
    _image4.image = nil;
    _carregando.hidden = NO;
    qtdeFotosBaixadas = 0;
    
    //criando as url com as imagens
    
    //inicio criando um array que guarda a url das imagens e referencias do objeto
    NSMutableArray *listaImagens = [[NSMutableArray alloc] init];
    
    //crio o dicionario com os valores das imagens
    NSMutableDictionary * img1 = [[NSMutableDictionary alloc] init];
    //setando os valores para o objeto1
    [img1 setObject:_image1 forKey:@"objeto"];
    [img1 setObject:@"http://www.hdcarwallpapers.com/walls/ferrari_hd_widescreen-wide.jpg" forKey:@"url"];
    //adiciono o objeto ao array
    [listaImagens addObject:img1];
    
    //setando os valores para o objeto2
    NSMutableDictionary * img2 = [[NSMutableDictionary alloc] init];
    [img2 setObject:_image2 forKey:@"objeto"];
    [img2 setObject:@"http://1.bp.blogspot.com/--DOM08lguXU/TsV8GUQI0cI/AAAAAAAAFUQ/ZPCvlV76NVU/s1600/01.jpeg" forKey:@"url"];
    //adiciono o objeto ao array
    [listaImagens addObject:img2];
    
    //setando os valores para o objeto3
    NSMutableDictionary * img3 = [[NSMutableDictionary alloc] init];
    [img3 setObject:_image3 forKey:@"objeto"];
    [img3 setObject:@"http://allthecars.files.wordpress.com/2011/05/chevrolet-vectra-collection-2011-01.jpg" forKey:@"url"];
    //adiciono o objeto ao array
    [listaImagens addObject:img3];
    
    //setando os valores para o objeto4
    NSMutableDictionary * img4 = [[NSMutableDictionary alloc] init];
    [img4 setObject:_image4 forKey:@"objeto"];
    [img4 setObject:@"http://allthecars.files.wordpress.com/2011/09/chevrolet-cruze-2012-brasil-oficial-01.jpg" forKey:@"url"];
    //adiciono o objeto ao array
    [listaImagens addObject:img4];

    //NSLog(@"lista imagens = %@",listaImagens.description);

    //pegando o total de fotos
    totalFotos = listaImagens.count;
    
    //verificando qual botao foi clicado
    if(sender == _botaoTodas)
    {
        //chamando o metodo que faz o download de todas as imagens de uma vez
        [self downloadTodas:listaImagens];

    }
    else
    {
        //chamando o metodo que faz o download de uma imagem por vez
        for (int i = 0; i < listaImagens.count; i++)
        {
            //selector = @selector(<nome do meotodo>:)
            //target = onde o selector esta implementado (self e no mesmo arquivo)
            //withObject = paramero que posso passar p/o metodo disparado
            [NSThread detachNewThreadSelector:@selector(downloadThread:) toTarget:self withObject:[listaImagens objectAtIndex:i]];
        }
    }
    
}

//faz o download multiplo das imagens (1 por 1)
-(void)downloadThread:(NSMutableDictionary*)valores
{
    //arc nao atual muito bem em thread secundaria
    //criamos uma sintaxe para todos os obj criados por este metodo sejam dealocados no final do seu processamento paralelo
    @autoreleasepool {
        //NSLog(@"lista imagens = %@",valores.description);
        NSURL *url = [NSURL URLWithString: [valores objectForKey:@"url"]];
        //nsdata sao dados binarios que representam os objetos
        NSData *dadosImagem = [[NSData alloc] initWithContentsOfURL:url];
        //uiimage = a imagem que será carregada
        //imagem a partir dos dados baixados
        UIImage *foto = [UIImage imageWithData:dadosImagem];
        //criando o bjeto da view
        UIImageView *imagem = [valores objectForKey:@"objeto"];
        //associando a foto baixada ao imageView
        imagem.image = foto;
        
        qtdeFotosBaixadas++;
        if(qtdeFotosBaixadas == totalFotos){
            _carregando.hidden = YES;
        }
    }
    
}


//faz o download tudo de uma vez
-(void)downloadTodas:(NSMutableArray*)valores
{
    //NSLog(@"lista imagens = %@",valores.description);
    //recuperando o valor dos elementos
    
    for (int i = 0; i < valores.count; i++)
    {
        NSURL *url = [NSURL URLWithString: [[valores objectAtIndex:i] objectForKey:@"url"]];
        //nsdata sao dados binarios que representam os objetos
        NSData *dadosImagem = [[NSData alloc] initWithContentsOfURL:url];
        //uiimage = a imagem que será carregada
        //imagem a partir dos dados baixados
        UIImage *foto = [UIImage imageWithData:dadosImagem];
        //criando o bjeto da view
        UIImageView *imagem = [[valores objectAtIndex:i] objectForKey:@"objeto"];
        //associando a foto baixada ao imageView
        imagem.image = foto;
    }
    _carregando.hidden = YES;    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end

//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Aaron Marquez on 23/12/15.
//  Copyright © 2015 Aaron Marquez. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var imagen: UIImageView!
    private var reproductor: AVAudioPlayer!
    private var musica = musicaDatos()
    @IBOutlet var volumen: UISlider!
    @IBOutlet var titulo: UILabel!
    @IBOutlet var playList: UITableView!
    @IBOutlet var listaCanciones: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playList.dataSource = self
        playList.delegate = self
        reproducir(0)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return musica.cancion.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let myCell:UITableViewCell = playList.dequeueReusableCellWithIdentifier("myList", forIndexPath: indexPath)
        
        myCell.textLabel?.text = musica.artista[indexPath.row]
        return myCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        reproducir(indexPath.row)
    }
    
    
    @IBAction func volumenSlide(sender: UISlider) {
        reproductor.volume = sender.value
    }
    
    
    @IBAction func play() {
        if !reproductor.playing{
            reproductor.play()
        }
    }

    @IBAction func stop() {
        if reproductor.playing{
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }

    
    @IBAction func pause() {
        if reproductor.playing{
            reproductor.pause()
        }
    }
    
    @IBAction func shuflle() {
        let random = Int(arc4random_uniform( UInt32(musica.cancion.count)))
        reproducir(random)
        
    }
    
    
    func reproducir(seleccion: NSInteger){
        let sonidoURL = NSBundle.mainBundle().URLForResource(musica.cancion[seleccion], withExtension:"mp3")
        let portada = musica.portada[seleccion]
        let tituloCancion = musica.titulo[seleccion]
        do { try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
            if !reproductor.playing {
                reproductor.play()
                imagen.image  = UIImage(named: portada)
                titulo.text = tituloCancion
            }
            
        }catch{
            let alerta = UIAlertController(title: "Aviso", message:  "No se puede reproducir el archivo", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alerta.addAction(defaultAction)
            self.presentViewController(alerta, animated: true, completion: nil)
        }

    }
    
}


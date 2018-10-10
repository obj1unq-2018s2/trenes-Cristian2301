import vagones.*
import locomotoras.*


class Deposito {
	var formaciones
	var locomotorasSueltas
}



class Tren {
	var locomotoras
	var vagones
	
	method totalPasajerosQuePuedeTransportar(){
		return vagones.sum({vagon => vagon.cantidadPasajerosQuePuedeTransportar()})
	}
	
	method cantVagonesLivianos(){
		return vagones.count({vagon => vagon.pesoMaximo() < 2500})
	}
	
	method velocidadMaxima(){
		return locomotoras.min({locomotora => locomotora.velocidadMaxima()}).velocidadMaxima()
	}
	
	
}

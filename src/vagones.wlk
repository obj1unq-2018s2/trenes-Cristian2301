class VagonPasajeros {
	var property largo 
	var property ancho
	var property cantBanios
	
	method cantidadPasajerosQuePuedeTransportar(){
		if(ancho <= 2.5){
			return largo * 8
		}
		else{
			return largo * 10
		}
	}
	
	method pesoMaximo(){
		return self.cantidadPasajerosQuePuedeTransportar() * 80
	}
}


class VagonCarga {
	var cargaMaxima
	
	method pesoMaximo(){
		return cargaMaxima + 160 
	}
	
	method cantidadPasajerosQuePuedeTransportar(){
		return 2
	}
	
}






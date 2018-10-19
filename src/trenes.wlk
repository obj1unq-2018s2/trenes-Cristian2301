import vagones.*
import locomotoras.*


class Deposito {
	var property formaciones
	var locomotorasSueltas
	
	method necesitaConductorExperimentado(){
		return formaciones.any({formacion => formacion.esCompleja()})
	}
	
	method agregarLocomotoraA(formacion){
		if(not formacion.puedeMoverse()  and self.existeLocomotoraAAgregar(formacion)){
			formacion.locomotoras().add({self.locomotoraAAgregar(formacion)})
		}
	}
	
	method existeLocomotoraAAgregar(formacion){
		return locomotorasSueltas.any({locomotora => locomotora.arrastreUtil() >= formacion.kilosDeEmpujeQueFaltaParaMoverse()})
	}
	
	method locomotoraAAgregar(formacion){
		return locomotorasSueltas.find({locomotora => locomotora.arrastreUtil() >= formacion.kilosDeEmpujeQueFaltaParaMoverse()})
	}
}



class Tren {
	var property locomotoras
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
	
	method esEficiente(){
		return locomotoras.all({locomotora => locomotora.arrastreUtil() >= (locomotora.peso() * 5)})
	}
	
	method puedeMoverse(){
		return self.arrastreUtilTotalLocomotoras() >= self.pesoMaximoTotalVagones()
	}
	
	method arrastreUtilTotalLocomotoras(){
		return locomotoras.sum({locomotora => locomotora.arrastreUtil()})
	}
	
	method pesoMaximoTotalVagones(){
		return vagones.sum({vagon => vagon.pesoMaximo()})
	}
	
	method kilosDeEmpujeQueFaltaParaMoverse(){
		return if(self.puedeMoverse()) 0 else self.pesoMaximoTotalVagones() - self.arrastreUtilTotalLocomotoras()
	}
	
	method vagonesMasPesados(deposito){
		return deposito.formaciones().map({formacion => formacion.vagonMasPesado()}).asSet()    
	}
	
	method vagonMasPesado(){
		return vagones.max({vagon => vagon.pesoMaximo()})
	}
	
	method esCompleja(){
		return self.cantUnidades() > 20 or self.pesoTotal() > 10000
	}
	
	method cantUnidades(){
		return locomotoras.size() + vagones.size()
	}
		
	method pesoTotal(){
		return self.pesoMaximoTotalVagones() + self.pesoMaximoTotalLocomotoras()
	}
	
	method pesoMaximoTotalLocomotoras(){
		return locomotoras.sum({locomotora => locomotora.peso()})
	}
}

class TrenCortaDistancia inherits Tren {
	
    method bienArmada(){
		return not self.esCompleja()
	}
	
	override method puedeMoverse(){
		return self.bienArmada()
	}	
	
	override method velocidadMaxima(){
		return 60
	}
}

class TrenLargaDistancia inherits Tren {
	var uneDosCiudadesGrandes
	
	method bienArmada(){
		return self.tieneBanioPorCada50Pasajeros()
	}
	
	method tieneBanioPorCada50Pasajeros(){
		return 
	}
	
	override method velocidadMaxima(){
		if(uneDosCiudadesGrandes){
			return 200
		}
		else{
			return 150
		}
	}
}


class TrenAltaVelocidad inherits TrenLargaDistancia {
	var velocidadMaxima
	
	override method bienArmada(){
		return velocidadMaxima >= 250 and self.tieneTodosVagonesLivianos()
	}
	
	method tieneTodosVagonesLivianos(){
		return self.cantVagonesLivianos() == self.cantTotalVagones()
	}
	
	method cantTotalVagones(){
		return vagones.size()
	}
	
}




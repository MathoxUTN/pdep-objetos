//PUNTO 1
class Lugar{
  var property name//consy

  method tieneCantLetrasPar() = (name.size() % 2) == 0 //name.length().even()

  method esDivertido()= self.tieneCantLetrasPar() and self.esDivertidoParticular()

  method esRaro() = name.size() > 10// Ojo que tenes 2 veces el name.size()

  method esDivertidoParticular()
  method esTranquilo()// No es necesario escribirlo aca, podes tenerlo en cada subclase necesaria. Acordate que no es necesario la abstraccion para el polimorfismo
}
class Ciudad inherits Lugar{
  var property cantHabitantes
  var property atracciones//const
  var property dbPromedio

  override method esDivertidoParticular()= (cantHabitantes > 100000) and (atracciones.size() > 3)

  override method esTranquilo() = dbPromedio < 20
}

class Pueblo inherits Lugar{
  var property extension//wtf
  var property fundadoEn//const
  var property provincia//const
  const property provinciasLitoral = ["Entre Ríos","Corrientes","Misiones"]

  method esDelLitoral() = provinciasLitoral.contains(provincia)

  override method esDivertidoParticular() = fundadoEn < 1800 and self.esDelLitoral()
  
  override method esTranquilo() = provincia == "La Pampa"

}

class Balneario inherits Lugar{
  var property metrosPlaya
  var property marPeligroso
  var property tienePeatonal

  override method esDivertidoParticular()= metrosPlaya > 300 and marPeligroso

  override method esTranquilo() = !tienePeatonal
}

//PUNTO 2
class Persona{
  var property preferencia
  //var property presupuestoMaximo
  //method puedePagar(monto) =  monto <= presupuestoMaximo
  
  /*
  method eligeLugares(lugares) = lugares.all{ (lugar => self.elige(lugar)) }
  */
  method vacacionaEn(lugar) = preferencia.cumplePreferencia(lugar)
}

object tranquilidad{
  method cumplePreferencia(lugar) = lugar.esTranquilo()
}

object diversion{
  method cumplePreferencia(lugar) = lugar.esDivertido()
}

object rareza{
  method cumplePreferencia(lugar) = lugar.esRaro()
}

class PreferenciaVariada{
  var property preferencias//const y lista vacia
  method cumplePreferencia(lugar) = preferencias.any( {preferencia => preferencia.cumplePreferencia(lugar)} )
}

//PUNTO 3
class Tour{
  var property fechaSalida
  var property cantidadRequeridaPersonas//const
  var property lugaresARecorrrer//const
  var property montoXPersona
  var property personas//const
  
  //method esDeEsteAnio() = fechaSalida.year == new Date().year()
  
  //method montoTotal() = montoTour * integrantes.size()

  method incorporarPersona(persona) {
    if(self.tourAdecuadoPara(persona) and self.estaConfirmado()){
      personas.add(persona)
    } else{
      throw new Exception(message = "La persona no puede incorporarse al tour.")//La excepcion es muy generica
    }
  }
  /*
  method agregarPersona(persona){
    if(!persona.puedePagar(persona)){
      throw new DomainException(message= "La persona no puede pagar el monto del tour")
    }
    if(!self.lugaresSonAdecuados(persona))
      throw new DomainException(message= "Algun lugar no lo elegiria")
    if(!self.hayLugar())
      throw nes DomainException(message= "No hay lugar")
    integrantes.add(persona)
  }
  Separar las 3 condiciones en metodos individuales
  OJO CON EL ACOPLAMIENTO
  method agregarPersona(persona){
    self.validadPago(persona)
    self.validarLugares(persona)
    self.validadCupos()
    integrantes.add(persona)
  }
  */

  method estaConfirmado() = personas.size() == cantidadRequeridaPersonas

  method tourAdecuadoPara(persona) = self.montoEsAdecuado(persona) and self.lugaresSonAdecuados(persona)

  method montoEsAdecuado(persona) = montoXPersona < persona.presupuestoMaximo() 

  method lugaresSonAdecuados(persona) = lugaresARecorrrer.all({lugar => persona.vacacionaEn(lugar)})

  method darDeBajaPersona(persona) = personas.remove(persona)
}

//PUNTO 4

//Una clase reporte? Que contenga todos los tours?
class Reporte{
  
}
/*PATRON SINGLETON
object reporte{
  const tours = []
  
  method toursPendientesDeConfirmacion() =
         tours.filter(tour => !tour.estaConfirmado)
         
  method montoTotal() = self.toursDeEsteAnio().sum{tour => tour.montoTotal()}
         
  method toursDeEsteAnio() = tours.filter(tour => tour.esDeEsteAnio())
}
*/
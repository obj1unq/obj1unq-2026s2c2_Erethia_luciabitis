import rolando.*
import erethia.*


//artefactos

object espadaDelDestino {
  var fueUsado = false
  
  method usar() {
    fueUsado = true
  }
  
  method poderAportado(personaje) = if (fueUsado) personaje.poderBase() * 0.5
                                    else personaje.poderBase()
}

object libroDeHechizos {
  const hechizos = []
  var hechizoActual = []
  
  method agregarHechizos(_hechizos) {
    hechizos.addAll(_hechizos)
  }


  method hechizoActual() = hechizos.first()
  
  method poderAportado(personaje) = if (hechizos.isEmpty()) 0
                                    else self.hechizoActual().poder(personaje)
  
  method usar() {
    if (!hechizos.isEmpty()) hechizos.remove(self.hechizoActual())
  }
}

object bendición {
  const poder = 4
  
  method poder(personaje) = poder
}

object invisibilidad {
  method poder(personaje) = personaje.poderBase()
}

object invocación {
  method poder(personaje) = castilloDePiedra.artefactoMasPoderoso(personaje)
}

object collarDivino {
  const puntos = 3
  var usos = 0
  
  method puntos() = puntos
  
  method usar() {
    usos += 1
  }
  
  method poderAportado(personaje) = if (personaje.poderBase() > 6) puntos + usos
                                    else puntos
}

object armaduraDeAceroValyrio {
  const poder = 6
  var usos = 0
  
  method usar() {
    usos += 1
  }
  
  method poderAportado(personaje) = poder
} 


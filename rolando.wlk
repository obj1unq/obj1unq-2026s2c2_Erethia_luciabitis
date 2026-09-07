//rolando
object rolando {
  var mochila = []
  var capacidadDeMochi = 2
  var encuentros = []
  var poderBase = 0
  var cantidadDeBatallas = 0
  
  method poderBase() = poderBase
  
  method poderBase(_poder) {
    poderBase = _poder
  }
  
  method poderPotenciado(_poder) = poderBase + _poder
  
  method capacidadDeMochi() = capacidadDeMochi
  
  method capacidadDeMochi(capacidad) {
    capacidadDeMochi = capacidad
  }
  
  method encuentros() = encuentros
  
  method encontrar(artefacto) {
    encuentros += [artefacto]
    if (mochila.size() < 2) mochila.add(artefacto)
  }
  
  method mochila() = mochila

  method mochila(artefactos) {
    mochila = artefactos
  }
  
  method llegadaAlHogar() {
    castilloDePiedra.almacen(self.mochila())
    mochila.clear()
  }
  
  method artefactosEnTotal() = mochila + castilloDePiedra.almacen()
  
  method tieneArtefacto(artefacto) {
    mochila.contains(artefacto)
  }
  
  method poderDeBatalla() = poderBase + mochila.sum(
    { artefacto => artefacto.poderAportado(self) }
  )
  
  method batalla() {
    cantidadDeBatallas += 1
    mochila.forEach({ artefacto => artefacto.usar() })
  }
} 

//castillo

object castilloDePiedra {
  const almacen = []
  
  method almacen(artefactos) {
    almacen.addAll(artefactos)
  }
  
  method almacen() = almacen
} 

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
  var poder = 500
}

object collarDivino {
  var puntos = 3
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
    usos = usos + 1
  } 
  
  method poderAportado(personaje) = poder
}
//rolando
object rolando {
  var encuentros = []
  var poderBase = 0
  var cantidadDeBatallas = 0
  
  method poderBase() = poderBase
  
  method poderBase(_poder) {
    poderBase = _poder
  }
  
  method poderPotenciado(_poder) = poderBase + _poder
  
  method encuentros() = encuentros
  
  method encontrar(artefacto) {
    encuentros += [artefacto]
    mochila.rolandoEncuentra(artefacto)
  }
  
  method llegadaAlHogar() {
    castilloDePiedra.almacen(mochila.artefactos())
    mochila.limpiar()
  }
  
  method artefactosEnTotal() = mochila.artefactos() + castilloDePiedra.almacen()
  
  method poderDeBatalla() = poderBase + mochila.sumaDePoderes()
  
  method batalla() {
    poderBase += 1
    cantidadDeBatallas += 1
    mochila.usarArtefactos()
  }
}

object mochila {
  const artefactos = #{}
  var capacidadDeMochi = 2
  
  method rolandoEncuentra(artefacto) {
    if (artefactos.size() < 2) artefactos.add(artefacto)
  }
  
  method capacidadDeMochi() = capacidadDeMochi
  
  method capacidadDeMochi(capacidad) {
    capacidadDeMochi = capacidad
  }
  
  method artefactos() = artefactos
  
  method limpiar() {
    artefactos.clear()
  }
  
  method sumaDePoderes() = artefactos.sum(
    { artefacto => artefacto.poderAportado(rolando) }
  )
  
  method usarArtefactos() {
    artefactos.forEach({ artefacto => artefacto.usar() })
  }
  
  method tieneArtefacto(artefacto) {
    artefactos.contains(artefacto)
  }
} //castillo

object castilloDePiedra {
  const almacen = #{}
  
  method almacen() = almacen
  
  method artefactoMasPoderoso(personaje) = almacen.map(
    { artefacto => artefacto.poderAportado(personaje) }
  ).max()
  
  method agregarArtefactos(_artefactos) {
    almacen.addAll(_artefactos)
  }
} //artefactos

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

  method agregarHechizos(_hechizos) {
    
  }
  
  method poderAportado(personaje) = if (hechizos.isEmpty()) 0
                                    else hechizos.first().poder(personaje)

  method usar() {  
    if (! hechizos.isEmpty()) hechizos.remove(hechizos.first())
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
    usos += 1
  }
  
  method poderAportado(personaje) = poder
}
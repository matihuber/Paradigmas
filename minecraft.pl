%jugador(Jugador, Items, NivelHambre).
jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra, pan], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

%lugar(Lugar, Jugadores, NivelOscuridad).
lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

%comestible(Item).
comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).


%1)
%a)
tieneItem(Jugador, Item) :-
	jugador(Jugador, Items, _),
	member(Item, Items).
	
%b)-- este no se como ver que tenga mas de un item comestible
sePreocupaPorSuSalud(Jugador):-
	tieneItem(Jugador, Item), 
	comestible(Item).

%c)
cantidadDeItem(Jugador, Item, Cantidad) :-
	existeItem(Item),
	esJugador(Jugador),
	findall(Item, jugador(Jugador, Item, _), Items),
	length(Items, Cantidad).
existeItem(Item) :-
	jugador(_, Item, _).
esJugador(Jugador) :-
	jugador(Jugador, _, _).
	
%d)-- no se como resolverlo, en el parcial en el punto 5 habia que hacer algo parecido y no lo pude hacer.

	
	
%2)
%a)		
hayMonstruos(Lugar) :-
	oscuridad(Lugar, NivelOscuridad).
	
oscuridad(Lugar, NivelOscuridad) :-
	lugar(Lugar, _, NivelOscuridad),
	NivelOscuridad > 6.
	
%b)
correPeligro(Jugador) :-
	lugar(Lugar, Jugador, _),
	hayMonstruos(Lugar).
	
correPeligro(Jugador) :-
	hambriento(Jugador),
	noTieneItemsComestibles(Jugador).

hambriento(Jugador) :-
	jugador(Jugador, _, NivelHambre),
	NivelHambre < 4.
	
noTieneItemsComestibles(Jugador) :-
	tieneItem(Jugador, Item),
	not(comestible(Item)).

%c)
nivelPeligrosidad(Lugar, NivelPeligrosidad) :-
	not(hayMonstruos(Lugar)),
	poblacionTotal(Lugar, Poblacion),
	hambrientos(Lugar, Hambrientos),
	porcentajeHambrientos(Hambrientos, Poblacion, Porcentaje),
	NivelPeligrosidad = Porcentaje.
poblacionTotal(Lugar, Poblacion) :-
	lugar(Lugar, Jugadores, _),
	length(Jugadores, Poblacion).		
hambrientos(Lugar, JugadoresHambrientos) :-
	lugar(Lugar, Jugadores, _),
	findall(Hambriento, (member(Hambriento, Jugadores), hambriento(Hambriento)), Hambrientos), %puse dos consultas en el findall
	length(Hambrientos, JugadoresHambrientos).
porcentajeHambrientos(Hambrientos, Poblacion, Porcentaje) :-
	Multiplicacion is Hambrientos * 100,
	Porcentaje is Multiplicacion / Poblacion.

nivelPeligrosidad(Lugar, NivelPeligrosidad) :-
	hayMonstruos(Lugar),
	NivelPeligrosidad = 100.
	
nivelPeligrosidad(Lugar, NivelPeligrosidad) :-
	lugarNoPoblado(Lugar),
	lugar(Lugar, _, NivelOscuridad),
	NivelPeligrosidad is NivelOscuridad * 10.
lugarNoPoblado(Lugar) :-
	lugar(Lugar, Jugadores, _),
	length(Jugadores, 0).


%3)-- necesito ayuda para resolver este punto entero.

/*4)
a) Para prolog una consulta da false excepto que haya algo que demuestre lo contrario. En este caso,
   si se consulta por el nivel de peligrosidad del desierto va a dar false ("desierto" no se encuentra en
   los lugares de esta base de conocimientos).
b) Que se pueden hacer distintos tipos de consultas, existenciales, especificas y variables.*/   

	

























	






	
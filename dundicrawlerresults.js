function showDundiCrawlerResult(map)
{
	var DundiIconOffline = L.icon({
	  iconUrl: 'site-red.png',
    iconSize: [19, 25]
	});

	var DundiIconOnline = L.icon({
	  iconUrl: 'site-green.png',
    iconSize: [19, 25]
	});

	L.marker([50.872903, 7.0977], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0kpg</b>");
	L.marker([50.74517, 6.04433], {icon: DundiIconOnline}).addTo(map)
	  .bindPopup("<b>db0wa</b>");
	L.marker([48.5657, 13.4502], {icon: DundiIconOnline}).addTo(map)
	  .bindPopup("<b>db0hup</b>");
	L.marker([48.584656, 13.555797], {icon: DundiIconOnline}).addTo(map)
	  .bindPopup("<b>db0pas</b>");
	L.marker([53.5976, 9.94653], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0fs</b>");
	L.marker([45.72564, 21.24538], {icon: DundiIconOnline}).addTo(map)
	  .bindPopup("<b>yo2loj</b>");
	L.marker([51.66675, 5.36788], {icon: DundiIconOnline}).addTo(map)
	  .bindPopup("<b>pa2eon</b>");
	L.marker([38.663326, -9.155286], {icon: DundiIconOnline}).addTo(map)
	  .bindPopup("<b>cs5nra</b>");
	L.marker([48.110602, 11.324207], {icon: DundiIconOnline}).addTo(map)
	  .bindPopup("<b>db0rta</b>");
	L.marker([52.1609796274699, 10.4312757456855], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0abz</b>");
	L.marker([51.3122, 7.387083], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0tv</b>");
	L.marker([47.975401, 12.780511], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0mbg</b>");
	L.marker([48.587119, 12.343524], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0ffl</b>");
	L.marker([48.99881, 12.093093], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0hsr</b>");
	L.marker([48.829632, 11.736507], {icon: DundiIconOnline}).addTo(map)
	  .bindPopup("<b>db0ntv</b>");
	L.marker([49.618618, 11.029677], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0for</b>");
	L.marker([51.666167, 10.343333], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0oha</b>");
	L.marker([51.201167, 8.108], {icon: DundiIconOffline}).addTo(map)
	  .bindPopup("<b>db0ku</b>");


// Site1: db0wa	Site2: pa2eon
	var mypolyline = new L.Polyline([[50.74517, 6.04433],[51.66675, 5.36788]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0wa	Site2: cs5nra
	var mypolyline = new L.Polyline([[50.74517, 6.04433],[38.663326, -9.155286]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0wa	Site2: db0rta
	var mypolyline = new L.Polyline([[50.74517, 6.04433],[48.110602, 11.324207]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0wa	Site2: db0fs
	var mypolyline = new L.Polyline([[50.74517, 6.04433],[53.5976, 9.94653]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0wa	Site2: db0abz
	var mypolyline = new L.Polyline([[50.74517, 6.04433],[52.1609796274699, 10.4312757456855]], {
		color: 'red',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0wa	Site2: db0kpg
	var mypolyline = new L.Polyline([[50.74517, 6.04433],[50.872903, 7.0977]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0wa	Site2: db0hup
	var mypolyline = new L.Polyline([[50.74517, 6.04433],[48.5657, 13.4502]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0wa	Site2: db0pas
	var mypolyline = new L.Polyline([[50.74517, 6.04433],[48.584656, 13.555797]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0wa	Site2: db0tv
	var mypolyline = new L.Polyline([[50.74517, 6.04433],[51.3122, 7.387083]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0hup	Site2: db0pas
	var mypolyline = new L.Polyline([[48.5657, 13.4502],[48.584656, 13.555797]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0hup	Site2: db0tv
	var mypolyline = new L.Polyline([[48.5657, 13.4502],[51.3122, 7.387083]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: db0rta
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[48.110602, 11.324207]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: db0mbg
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[47.975401, 12.780511]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: yo2loj
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[45.72564, 21.24538]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: cs5nra
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[38.663326, -9.155286]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: db0ffl
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[48.587119, 12.343524]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: db0fs
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[53.5976, 9.94653]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: db0hsr
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[48.99881, 12.093093]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: db0ntv
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[48.829632, 11.736507]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: db0for
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[49.618618, 11.029677]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: db0oha
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[51.666167, 10.343333]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0pas	Site2: db0tv
	var mypolyline = new L.Polyline([[48.584656, 13.555797],[51.3122, 7.387083]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: yo2loj	Site2: db0fs
	var mypolyline = new L.Polyline([[45.72564, 21.24538],[53.5976, 9.94653]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: yo2loj	Site2: db0tv
	var mypolyline = new L.Polyline([[45.72564, 21.24538],[51.3122, 7.387083]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: pa2eon	Site2: pa2eon
	var mypolyline = new L.Polyline([[51.66675, 5.36788],[51.66675, 5.36788]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: pa2eon	Site2: cs5nra
	var mypolyline = new L.Polyline([[51.66675, 5.36788],[38.663326, -9.155286]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: pa2eon	Site2: db0ku
	var mypolyline = new L.Polyline([[51.66675, 5.36788],[51.201167, 8.108]], {
		color: 'red',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: pa2eon	Site2: db0fs
	var mypolyline = new L.Polyline([[51.66675, 5.36788],[53.5976, 9.94653]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: pa2eon	Site2: db0abz
	var mypolyline = new L.Polyline([[51.66675, 5.36788],[52.1609796274699, 10.4312757456855]], {
		color: 'red',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: pa2eon	Site2: db0kpg
	var mypolyline = new L.Polyline([[51.66675, 5.36788],[50.872903, 7.0977]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: pa2eon	Site2: db0hup
	var mypolyline = new L.Polyline([[51.66675, 5.36788],[48.5657, 13.4502]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: pa2eon	Site2: db0pas
	var mypolyline = new L.Polyline([[51.66675, 5.36788],[48.584656, 13.555797]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: pa2eon	Site2: db0tv
	var mypolyline = new L.Polyline([[51.66675, 5.36788],[51.3122, 7.387083]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: cs5nra	Site2: db0fs
	var mypolyline = new L.Polyline([[38.663326, -9.155286],[53.5976, 9.94653]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0ntv	Site2: db0oha
	var mypolyline = new L.Polyline([[48.829632, 11.736507],[51.666167, 10.343333]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0ntv	Site2: db0for
	var mypolyline = new L.Polyline([[48.829632, 11.736507],[49.618618, 11.029677]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0ntv	Site2: db0hsr
	var mypolyline = new L.Polyline([[48.829632, 11.736507],[48.99881, 12.093093]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0ntv	Site2: db0tv
	var mypolyline = new L.Polyline([[48.829632, 11.736507],[51.3122, 7.387083]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0ntv	Site2: db0fs
	var mypolyline = new L.Polyline([[48.829632, 11.736507],[53.5976, 9.94653]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

// Site1: db0ntv	Site2: db0hup
	var mypolyline = new L.Polyline([[48.829632, 11.736507],[48.5657, 13.4502]], {
		color: 'green',
		weight: 3,
		opacity: 0.5,
		smoothFactor: 1
	});
	mypolyline.addTo(map);

};

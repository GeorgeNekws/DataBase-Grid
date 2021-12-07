

function createGrid(){
	var rows = 100;
	var columns = 100;
	var identifier = 1;
	var row;
	var cell;
	var table = document.getElementById("table-grid");
	
	for (var i = columns-1; i >= 0; i--) {
		row = table.insertRow(-1);
		for(var j = 0; j < rows; j++) {
			cell = row.insertCell(-1);
			cell.id = identifier;
			identifier++;
		}
	}
	/*var c = document.getElementById("1");
	console.log(c);
	c.style.backgroundColor = "red";*/

}

  
function createCircle(ids_array){
	//i have to retrieve the rect elements which id is in the ids _array and change their color
	for(var i=0; i<ids_array.length; i++){
		var cell = document.getElementById(ids_array[i]);	
		//cell.setAttribute("fill", "white");
		cell.style.backgroundColor = "red";	
	}
}
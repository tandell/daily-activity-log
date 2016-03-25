var count = 1;
function addRef()
{
	var referenceName = "reference" + count;
	var node = 	'<div class="container flex-row" style="flex-grow: 1; align-self: center; width: 90%">' + 
					'<div class="container flex-column" style="flex-shrink: 1;">' + 
						'<label><small>Type:</small></label><input list="types" />' + 
					'</div>' + 
					'<div class="container flex-column" style="flex-grow: 1;">' + 
						'<label><small>URL: </small></label><input type="text" id="' + referenceName + '"/>' + 
					'</div>' + 
					'<div class="container flex-column" style="flex-shrink: 1;">' + 
						'<input  type="button" onclick="removeRef()" value="Remove" />' + 
					'</div>' +
				'</div>';
	document.getElementById('references').innerHTML += node;
	count += 1;
}

function removeRef()
{
	
}
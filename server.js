const http = require('http')

const port = 8000

function sendResponse(response, statusCode, content = null) {
	response.writeHead(statusCode, {'Content-Type': 'text/plain'})
	if (content === null) {
		response.end()
	} else {
		response.end(content)
	}
}

const server = http.createServer((req, res) => {
	
	if (req.url === '/ok') {
		console.log('/ok hit')
		sendResponse(res, 204)
	} else if (req.url === '/delay') {
		console.log('/delay hit')
		setTimeout(() => {
			sendResponse(res, 204)
		}, 2000) // 2 second delay
	} else {
		console.log('404 response')
		sendResponse(res, 404)
	}

});

server.listen(port, () => {
  console.log('Server is running on http://localhost:' + port);
});

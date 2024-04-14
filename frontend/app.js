function fetchData() {
    const perPage = document.getElementById('perPage').value;
    const magType = document.getElementById('magType').value;
    alert('Cargando elementos');
    fetch(`http://127.0.0.1:3000/api/features?page=1&per_page=${perPage}&mag_type[]=${magType}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Error en la solicitud.');
            }
            return response.json();
        })
        .then(data => {
            displayData(data);
        })
        .catch(error => {
            console.error('Error fetching data:', error);
        });
}


function displayData(data) {
    const resultsDiv = document.getElementById('results');
    resultsDiv.innerHTML = ''; 

    if (data && data.data && data.data.length > 0) {
        data.data.forEach(item => {
            const featureItem = document.createElement('div');
            featureItem.classList.add('feature-item');

            const title = document.createElement('h1');
            title.textContent = item.attributes.title || 'Sin título'; 

            const magnitude = document.createElement('p');
            magnitude.textContent = `Magnitud: ${item.attributes.magnitude}`;

            const place = document.createElement('p');
            place.textContent = `Lugar: ${item.attributes.place}`;

            const time = document.createElement('p');
            time.textContent = `Fecha y hora: ${item.attributes.time}`;

            const externalLink = document.createElement('a');
            externalLink.textContent = 'Enlace externo';
            externalLink.href = item.links.external_url;
            externalLink.target = '_blank';

            featureItem.appendChild(title);
            featureItem.appendChild(magnitude);
            featureItem.appendChild(place);
            featureItem.appendChild(time);
            featureItem.appendChild(externalLink);

            resultsDiv.appendChild(featureItem);
        });
    } else {
        resultsDiv.innerHTML = '<p>No se encontraron eventos.</p>';
    }

    const clearBtn = document.createElement('button');
    clearBtn.textContent = 'Limpiar';
    clearBtn.id = 'clearBtn';
    clearBtn.onclick = clearResults;
    resultsDiv.appendChild(clearBtn);
}

function addComment() {
    const elementId = document.getElementById('elementId').value;
    const comment = document.getElementById('comment').value;

    if (!elementId || !comment) {
        alert('Por favor, completa todos los campos.');
        return;
    }

    alert('Añadiendo comentario');

    fetch(`http://127.0.0.1:3000/api/features/${elementId}/comments`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ body: comment }),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Error en la solicitud.');
        }
        return response.json();
    })
    .then(data => {
        alert('Comentario añadido con éxito');
        clearForm(); // Limpiar el formulario
    })
    .catch(error => {
        console.error('Error adding comment:', error);
    });
}

function getCommentsById() {
    const elementId = document.getElementById('elementId').value;

    if (!elementId) {
        alert('Por favor, introduce un ID válido.');
        return;
    }

    alert('Cargando comentarios');

    fetch(`http://127.0.0.1:3000/api/features/${elementId}/comments`)
    .then(response => {
        if (!response.ok) {
            throw new Error('Error en la solicitud.');
        }
        return response.json();
    })
    .then(data => {
        displayComments(data);
    })
    .catch(error => {
        console.error('Error fetching comments:', error);
    });
}

function displayComments(data) {
    const resultsDiv = document.getElementById('results');
    resultsDiv.innerHTML = '';

    if (data && data.length > 0) {
        data.forEach(comment => {
            const commentItem = document.createElement('div');
            commentItem.classList.add('comment-item');

            const body = document.createElement('p');
            body.textContent = comment.body;

            commentItem.appendChild(body);

            resultsDiv.appendChild(commentItem);
        });
    } else {
        resultsDiv.innerHTML = '<p>No se encontraron comentarios para este elemento.</p>';
    }
}

function clearResults() {
    const resultsDiv = document.getElementById('results');
    resultsDiv.innerHTML = '';
}
function clearForm() {
    document.getElementById('elementId').value = '';
    document.getElementById('comment').value = '';
}
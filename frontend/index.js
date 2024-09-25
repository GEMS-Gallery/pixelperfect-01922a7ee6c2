import { backend } from 'declarations/backend';

let currentImageId = null;

document.getElementById('imageUpload').addEventListener('change', async (event) => {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = async (e) => {
            const imageData = new Uint8Array(e.target.result);
            currentImageId = await backend.uploadImage(imageData);
            displayImage(imageData);
        };
        reader.readAsArrayBuffer(file);
    }
});

document.getElementById('grayscaleBtn').addEventListener('click', async () => {
    if (currentImageId !== null) {
        const result = await backend.applyGrayscale(currentImageId);
        if (result) {
            displayImage(result.data);
        }
    }
});

document.getElementById('sepiaBtn').addEventListener('click', async () => {
    if (currentImageId !== null) {
        const result = await backend.applySepia(currentImageId);
        if (result) {
            displayImage(result.data);
        }
    }
});

function displayImage(imageData) {
    const blob = new Blob([imageData], { type: 'image/jpeg' });
    const imageUrl = URL.createObjectURL(blob);
    document.getElementById('displayImage').src = imageUrl;
}

# CoreDataDrawing

Hello!

This is a test project that I've created to debug an issue that I'm experiencing with PencilKit on iPad running iPadOS 16.2

### Steps to reproduce the issue:
1. Run the app on iPad using Xcode (app has a canvas view where the user can draw, along with 3 buttons to delete, save, and fetch pencil strokes)
2. Draw anything on the canvas
3. Click on the Save button (saves your drawing using Core Data)
4. Use the Eraser tool on the 'Pixel Eraser' mode and erase the complete drawing
5. Click on the Fetch button (opens a new view controller showing all saved drawings)
6. On this new view controller, select your drawing (will dismiss the new view controller and display your saved drawing on the canvas)
7. While your saved drawing is on the canvas, draw any other new stroke on the canvas
8. Does the saved drawing disappear automatically from the canvas?

I haven't been able to figure out why the saved drawing disappears from the canvas. 
Expected: the saved drawing should keep displaying even when I draw any new strokes.

Thanks for taking the time to download and test this project.

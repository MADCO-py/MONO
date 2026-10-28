const rl = @cImport({
    @cInclude("raylib.h");
});

pub fn main() !void {
    if (!rl.FileExists("modelo.obj")) return error.ModeloNoEncontrado;
    rl.InitWindow(800, 600, "Wireframe con Zig");
    if (!rl.IsWindowReady()) return error.VentanaNoDisponible;
    defer rl.CloseWindow();

    const modelo = rl.LoadModel("modelo.obj");
    defer rl.UnloadModel(modelo);
    const camara = rl.Camera3D{
        .position = .{ .x = 0, .y = 0.3, .z = 5 },
        .target = .{ .x = 0, .y = 0, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = rl.CAMERA_PERSPECTIVE,
    };
    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        rl.ClearBackground(rl.BLACK);
        rl.BeginMode3D(camara);
        rl.DrawModelWires(modelo, .{ .x = 0, .y = 0, .z = 0 }, 1, rl.WHITE);
        rl.EndMode3D();
        rl.DrawText("Zig | S: captura | ESC: salir", 20, 570, 20, rl.WHITE);
        rl.EndDrawing();
        if (rl.IsKeyPressed(rl.KEY_S)) rl.TakeScreenshot("resultado.png");
    }
}

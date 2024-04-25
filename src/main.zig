const std = @import("std");
const glfw = @import("mach-glfw");
const app = @import("app/App.zig");

fn errorCallback(error_code: glfw.ErrorCode, description: [:0]const u8) void {
    std.log.err("GLFW error: {}: {s}\n", .{ error_code, description });
}

pub fn main() !void {
    glfw.setErrorCallback(errorCallback);
    if (!glfw.init(.{})) {
        std.log.err("Failed to init GLFW: {?s}\n", .{ glfw.getErrorString() });
        std.process.exit(1);
    }
    defer glfw.terminate();

    const window = glfw.Window.create(
        800, 600, "Vulkan learn",
        null, null,
        .{ .client_api = .no_api, .resizable = false }
    ) orelse {
        std.log.err("Failed to create window: {?s}\n", .{ glfw.getErrorString() });
        std.process.exit(1);
    };
    defer window.destroy();

    try app.init();
    while (!window.shouldClose()) {
        window.swapBuffers();
        glfw.pollEvents();

        if (window.getKey(glfw.Key.escape) == glfw.Action.press) {
            window.setShouldClose(true);
        }

        app.run();
    }
}

const std = @import("std");
const vk = @import("vulkan");
const glfw = @import("mach-glfw");

var instance: vk.Instance = undefined;

pub fn init() !void {
    const appInfo = vk.ApplicationInfo{
        .s_type = vk.StructureType.application_info,
        .p_application_name = "Hello Vulkan",
        .application_version = vk.makeApiVersion(1, 0, 0, 0),
        .engine_version = vk.makeApiVersion(1, 0, 0, 0),
        .p_engine_name = "No Engine",
        .api_version = vk.API_VERSION_1_3,
    };
    const glfwExtensions = glfw.getRequiredInstanceExtensions().?;
    const createInfo = vk.InstanceCreateInfo{
        .s_type = vk.StructureType.instance_create_info,
        .p_application_info = &appInfo,
        .pp_enabled_extension_names = glfwExtensions.ptr,
        .enabled_extension_count = @as(u32, @intCast(glfwExtensions.len)),
    };
    const result = vk.PfnCreateInstance(&createInfo, null, &instance);
    if (result != vk.Result.success) {
        std.debug.print("Failed to create Vulkan instance\n", .{});
        return;
    }
}

pub fn run() void {
    std.debug.print("Hello, Vulkan!\n", .{});
}
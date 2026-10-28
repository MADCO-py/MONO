const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "wireframe",
        .root_source_file = b.path("main.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });
    exe.addIncludePath(b.path("vendor"));
    exe.addObjectFile(b.path("vendor/libraylib.a"));
    exe.linkLibC();
    for ([_][]const u8{ "GL", "m", "pthread", "dl", "rt", "X11" }) |lib| {
        exe.linkSystemLibrary(lib);
    }
    b.installArtifact(exe);
    const run = b.addRunArtifact(exe);
    run.setCwd(b.path("."));
    b.step("run", "Abrir el modelo en wireframe").dependOn(&run.step);
}

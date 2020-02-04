// SQLCl's Command Registry
var CommandRegistry = Java.type("oracle.dbtools.raptor.newscriptrunner.CommandRegistry");

// CommandListener for creating any new command
var CommandListener =  Java.type("oracle.dbtools.raptor.newscriptrunner.CommandListener");

var cmd = {};

cmd.handle = function(conn, ctx, cmd) {
    if (cmd.getSql().trim().startsWith("hellworld")) {
        ctx.write("Hello World!!\n");
        return true;
    }
    return false
}

cmd.begin = function(conn, ctx, cmd) {
}

cmd.end = function(conn, ctx, cmd) {
}

var MyCmd2 = Java.extend(CommandListener, {
    handleEvent: cmd.handle ,
    beginEvent: cmd.begin,
    endEvent: cmd.end
});

CommandRegistry.addForAllStmtsListener(MyCmd2.class);

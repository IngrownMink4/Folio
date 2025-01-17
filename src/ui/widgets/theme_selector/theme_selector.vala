
[GtkTemplate (ui = "/com/toolstack/Folio/theme_selector.ui")]
public class Folio.ThemeSelector : Gtk.Box {

    [GtkChild] unowned Gtk.CheckButton _auto;
    [GtkChild] unowned Gtk.CheckButton light;
    [GtkChild] unowned Gtk.CheckButton dark;

    construct {
	    var settings = new Settings (@"$(Config.APP_ID).Theme");
    	    var style_manager = Adw.StyleManager.get_default ();
	    switch (settings.get_enum ("variant")) {
	        case Adw.ColorScheme.DEFAULT: _auto.active = true; break;
	        case Adw.ColorScheme.FORCE_LIGHT: light.active = true; break;
	        case Adw.ColorScheme.FORCE_DARK: dark.active = true; break;
	    }
	    _auto.toggled.connect (() => {
	        if (_auto.active) {
				settings.set_enum ("variant", Adw.ColorScheme.DEFAULT);
				style_manager.color_scheme = Adw.ColorScheme.DEFAULT;
			}
	    });
	    light.toggled.connect (() => {
	        if (light.active) {
				settings.set_enum ("variant", Adw.ColorScheme.FORCE_LIGHT);
				style_manager.color_scheme = Adw.ColorScheme.FORCE_LIGHT;
			}
	    });
	    dark.toggled.connect (() => {
	        if (dark.active) {
				settings.set_enum ("variant", Adw.ColorScheme.FORCE_DARK);
				style_manager.color_scheme = Adw.ColorScheme.FORCE_DARK;
			}
	    });
    }
}

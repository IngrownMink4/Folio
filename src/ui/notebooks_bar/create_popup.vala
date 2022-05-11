
[GtkTemplate (ui = "/io/posidon/Paper/notebooks_bar/create_popup.ui")]
public class Paper.CreatePopup : Adw.Window {

	[GtkChild]
	unowned Gtk.Entry entry;

	[GtkChild]
	unowned Gtk.ColorButton button_color;

	[GtkChild]
	unowned Gtk.Button button_create;

	[GtkChild]
	unowned NotebookPreview preview;

	public CreatePopup (Application app, Notebook? notebook = null) {
		Object ();

        if (notebook != null) {
            button_create.label = Strings.APPLY;
	        button_color.rgba = notebook.color;
	        entry.text = notebook.name;
		    entry.activate.connect (() => change (app, notebook));
            button_create.clicked.connect (() => change (app, notebook));
        } else {
            entry.activate.connect (() => create (app));
            button_create.clicked.connect (() => create (app));
        }

        entry.changed.connect (() => {
            preview.notebook_name = entry.text;
        });
        button_color.color_set.connect (() => {
            preview.color = button_color.rgba;
        });
        entry.changed ();
        button_color.color_set ();
	}

    private void create (Application app) {
	    var name = entry.text;
	    var color = button_color.rgba;
	    close ();
	    app.try_create_notebook (name, color);
	}

	private void change (Application app, Notebook notebook) {
        var name = entry.text;
        var color = button_color.rgba;
        close ();
        app.try_change_notebook (notebook, name, color);
    }
}

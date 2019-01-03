/*
* Copyright 2018 elementary, Inc. (https://elementary.io)
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 2.1 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Library General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/

public class Friends.ContactRow : Gtk.ListBoxRow {
    public Folks.Individual individual { get; construct; }

    public ContactRow (Folks.Individual individual) {
        Object (individual: individual);
    }

    construct {
        var avatar = new Friends.Avatar.from_individual (individual, 32);

        string display_name;
        if (individual.structured_name != null) {
            string[] name_array = {};

            var family_name = individual.structured_name.family_name;
            var given_name = individual.structured_name.given_name;

            if (individual.structured_name.prefixes != "") {
                name_array += individual.structured_name.prefixes;
            }

            if (family_name != "") {
                if (given_name != "") {
                    name_array += given_name;
                }

                if (family_name.@get (0).isalpha ()) {
                    name_array += "<b>%s</b>".printf (family_name);
                } else {
                    name_array += family_name;
                }
            } else if (given_name != "") {
                if (given_name.@get (0).isalpha ()) {
                    name_array += "<b>%s</b>".printf (given_name);
                } else {
                    name_array += given_name;
                }
            }

            if (individual.structured_name.suffixes != "") {
                name_array += individual.structured_name.suffixes;
            }

            display_name = string.joinv (" ", name_array);
        } else {
            display_name = individual.display_name;
        }

        var individual_name = new Gtk.Label (display_name);
        individual_name.ellipsize = Pango.EllipsizeMode.MIDDLE;
        individual_name.use_markup = true;
        individual_name.xalign = 0;

        var grid = new Gtk.Grid ();
        grid.column_spacing = 6;
        grid.margin = 6;
        grid.add (avatar);
        grid.add (individual_name);

        add (grid);
    }
}

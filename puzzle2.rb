require "gtk3"
require "ruby-nfc"
require "thread"
require_relative "puzzle1.rb"

	@red=Gdk::RGBA::new(1.0,0,1.0)
	@blue=Gdk::RGBA::new(0,0,1.0,1.0)
	@white=Gdk::RGBA::new(1.0,1.0,1.0,1.0)
	
	@uid=""
	@rf=Rfid.new
	
	@window=Gtk::Window.new("Lector tarjeta Rfid")
	@window.set_size_request(300,100)
	@window.set_border_width(7)
	@window.set_window_position(:center)
	
	@window.signal_connect("delete-event"){
		|_widget| Gtk.main_quit}
	
	@grid=Gtk::Grid.new
	
	@label=Gtk::Label.new("Porfavor, acerque tarjeta para lectura")
	@label.override_background_color(:normal, @blue)
	@label.override_color(:normal, @white)
	
	@grid.attach(@label, 0, 0, 2, 1)
	
	@clear_button=Gtk::Button.new(:label=>"Clear")
	
	@grid.attach(@clear_button, 0, 1, 2, 1)
	
	@grid.set_row_homogeneous(true)
	@grid.set_column_homogeneous(true)
	
	@window.add(@grid)
	
	@clear_button.signal_connect "clicked" do
		
		@uid=""
		
		@label.override_background_color(:normal, @blue)
		@label.set_text("Porfavor, acerque tarjeta para lectura")
		thraux
		
	end
	
	def thraux
		t=Thread.new{
			read
			puts "thraux finished"
			t.exit
		}
	end
	
	thraux
	
	def read
		puts "reading"
		
		@uid=@rf.read_uid
		GLib::Idle.add{show_uid}
	end
	
	def show_uid
	
		if @uid != ""
			@label.override_background_color(:normal, @red)
			@label.text=@uid
		end
	end
	
	@window.show_all
	
	Gtk.main
	
	
	
	
	
	

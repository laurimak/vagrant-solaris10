# Copyright (c) 2014 Tnarik Innael - repackaged
# Copyright (c) 2014 Mitchell Hashimoto - from plugins/guest/linux/cap/shell_expand_guest_path.rb
module Vagrant
  module Solaris10
    module Cap
      class ShellExpandGuestPath

        def self.shell_expand_guest_path(machine, path)
          real_path = nil
          machine.communicate.execute("echo; printf #{path}") do |type, data|
            if type == :stdout
              real_path ||= ""
              real_path += data
            end
          end

          # The last line is the path we care about
          real_path = real_path.split("\n").last.chomp

          if !real_path
            # If no real guest path was detected, this is really strange
            # and we raise an exception because this is a bug.
            raise ShellExpandFailed
          end

          # Chomp the string so that any trailing newlines are killed
          return real_path.chomp
        end
        
      end
    end
  end
end
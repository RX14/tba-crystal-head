module Hydra::Head::Util
  def self.inspect_pretty(object)
    str = object.inspect
    out = String::Builder.new(str.size + 10)

    depth = 0
    is_string = false
    is_obj_start = false
    is_hash = false
    str.each_char_with_index do |char, idx|
      if is_string && char != '"'
        out << char
        next
      end

      case char
      when ','
        out << ",\n"
        out << "  " * depth
        next
      when ' '
        next if str[idx - 1] == ','
      when '<'
        if str[idx - 1] == '#'
          is_obj_start = true
          depth += 1
        end
      when '@'
        if is_obj_start
          is_obj_start = false
          out << '\n'
          out << "  " * depth
        end
      when '>'
        unless is_hash
          depth -= 1
          unless is_obj_start
            out << '\n'
            out << "  " * depth
          end
          is_obj_start = false
        end
      when '"'
        is_string = !is_string unless str[idx - 1] == '\\'
      when '['
        unless str[idx + 1] == ']'
          depth += 1
          out << "[\n"
          out << "  " * depth
          next
        end
      when ']'
        unless str[idx - 1] == '['
          depth -= 1
          out << '\n'
          out << "  " * depth
        end
      when '{'
        is_hash = true
      when '}'
        is_hash = false
      when '\n'
        out << '\n'
        out << "  " * depth
        next
      end

      out << char
    end

    out.to_s
  end
end

module TBA::Head::Util
  def self.inspect_pretty(object)
    inspect_str = object.inspect
    out_str = String::Builder.new(inspect_str.size + 10)

    depth = 0
    is_string = false
    inspect_str.each_char_with_index do |char, idx|
      case char
      when ','
        out_str << ",\n"
        out_str << "  " * depth
      when ' '
        unless inspect_str[idx - 1] == ','
          out_str << ' '
        end
      when '<'
        if inspect_str[idx - 1] == '#'
          depth += 1
        end
        out_str << '<'
      when '>'
        depth -= 1
        out_str << '>'
      when '"'
        is_string = !is_string unless inspect_str[idx - 1] == '\\'
        out_str << '"'
      when '['
        depth += 1
        out_str << "[\n"
        out_str << "  " * depth
      when ']'
        depth -= 1
        out_str << '\n'
        out_str << "  " * depth
        out_str << ']'
      when '\n'
        out_str << '\n'
        out_str << "  " * depth
      else
        out_str << char
      end
    end

    out_str.to_s
  end
end

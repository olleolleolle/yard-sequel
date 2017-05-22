module YardSequel
  # The standard error for the plugin. All other errors inherit from this.
  # @author Kai Moschcau
  Error = Class.new ::StandardError

  # Error that is raised, when a AstNode could not be parsed into a usable
  # option value.
  # @author Kai Moschcau
  class OptionValueParseError < Error
    # @param [#to_s, YARD::Parser::Ruby::AstNode] message Either a message or
    #   the AstNode, that could not be parsed.
    # @param [String] file_name The file name to use. Overrides the one set in
    #   the AstNode, if one is passed.
    # @param [Integer] line_number The line number to use. Overrides the one set
    #   in the AstNode, if one is passed.
    def initialize(message = nil, file_name = nil, line_number = nil)
      super(case message
            when YARD::Parser::Ruby::AstNode
              message_from_ast_node(message, file_name, line_number)
            else
              message_from_string(message, file_name, line_number)
            end)
    end

    private

    # @param [YARD::Parser::Ruby::AstNode] message Either a message or the
    #   AstNode, that could not be parsed.
    # @param [String] file_name The file name to use. Overrides the one set in
    #   the AstNode, if one is passed.
    # @param [Integer] line_number The line number to use. Overrides the one set
    #   in the AstNode, if one is passed.
    def message_from_ast_node(message, file_name = nil, line_number = nil)
      location = [file_name || message.file,
                  line_number || message.line].compact.join(':')
      [(location unless /^\s*$/ =~ location),
       "Can't infer option value from a #{message.type} node"]
        .compact.join(': ')
    end

    # @param [#to_s] message The message to use.
    # @param [String] file_name The file name to use. Overrides the one set in
    #   the AstNode, if one is passed.
    # @param [Integer] line_number The line number to use. Overrides the one set
    #   in the AstNode, if one is passed.
    def message_from_string(message, file_name = nil, line_number = nil)
      location = [file_name, line_number].compact.join(':')
      [(location unless /^\s*$/ =~ location),
       message].compact.join(': ')
    end
  end
end
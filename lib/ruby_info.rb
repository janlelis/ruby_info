require 'rbconfig'
require 'etc'
require 'socket'

module RubyInfo
  VERSION = '1.0.1'

  class << self
    def [](what)
      send what
    end

    def list
      singleton_methods.map(&:to_sym) - [:[], :list, :all]
    end

    def all
      Hash[ list.map{ |l| [l, self.public_send(l)] }]
    end
  end

  module_function

  # # #
  # program info

  def program_name
    $0
  end

  def program_arguments
    $*
  end

  def loaded_programs
    $"
  end

  def program_data
    defined?(::DATA) && DATA
  end

  def script_lines
    defined?(::SCRIPT_LINES__) && SCRIPT_LINES__
  end

  def child_program_status
    $CHILD_STATUS
  end

  # # #
  # system info

  def env
    ::ENV
  end

  def os
    RbConfig::CONFIG['host_os']
  end

  def process_id
    $$
  end

  def load_path
    $:
  end

  def gc
    GC.stat
  end

  # # #
  # user info

  def user_login
    Etc.getlogin
  end

  def user_name
    Etc.getpwnam(user_login).gecos.split(',')[0]
  end

  def user_home
    Dir.home
  end

  # # #
  # network info

  def hostname
    Socket.gethostname
  end

  # # #
  # current info

  def current_file #  __FILE__
    return $` if caller[0].rindex(/:\d+(:in `.*')?$/)
  end

  def working_directory
    Dir.pwd
  end

  def current_file_directory
    if current_file[0,1] == '(' && current_file[-1,1] == ')'
      current_file
    else
      File.dirname(current_file)
    end
  end

  def current_line # __LINE__
    return $1.to_i if caller[0].rindex( /:(\d+)(:in `.*')?$/ )
  end

  def current_method # __method__ (except aliases)
    return $1.to_sym if caller(1)[0].rindex( /\`([^\']+)\'/ )
  end

  def current_callstack
    caller
  end

  # # #
  # input / string info

  def last_input_file
    $FILENAME
  end

  def last_input_line_number
    $.
  end

  def last_input
    $_
  end

  def gets_separator
    $/
  end

  def join_separator
    $,
  end

  def print_separator
    $,
  end

  def split_separator
    $;
  end

  def external_encoding
    Encoding.default_external
  end

  def internal_encoding
    Encoding.default_internal
  end

  def encodings
    Encoding.name_list
  end

  def encoding_aliases
    Encoding.aliases
  end

  # # #
  # misc

  def security_level
    $SAFE
  end

  def verbose
    $VERBOSE
  end

  def warnings_activated?
    !! $VERBOSE
  end

  def debug
    $DEBUG
  end

  def debug_activated?
    !! $DEBUG
  end

  def last_exception
    $!
  end

  # # #
  # ruby objects

  def global_variables
    Object.send :global_variables
  end

  def global_constants
    Object.constants
  end

  def system_call_errors
    Errno.constants
  end

  def signals
    Signal.list
  end

  # # #
  # ruby info

  def ruby_version # also see the ruby_version gem
    ::RUBY_VERSION
  end

  def ruby_patchlevel
    ::RUBY_PATCHLEVEL
  end

  def ruby_description
    ::RUBY_DESCRIPTION
  end

  def ruby_release_date
    ::RUBY_RELEASE_DATE
  end

  def ruby_engine # also see the ruby_engine gem
    defined?(::RUBY_ENGINE) && ::RUBY_ENGINE
  end

  def ruby_platform
    ::RUBY_PLATFORM
  end

  def ruby_revision
    defined?(::RUBY_REVISION) && ::RUBY_REVISION
  end

  def ruby_copyright
    defined?(::RUBY_COPYRIGHT) && ::RUBY_COPYRIGHT
  end
end


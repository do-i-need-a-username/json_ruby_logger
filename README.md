# JsonRubyLogger

[![Gem Version](https://badge.fury.io/rb/json_ruby_logger.svg)](https://badge.fury.io/rb/json_ruby_logger)

A simpe ruby [logger](https://ruby-doc.org/3.2.2/stdlibs/logger/Logger.html) that logs in json format with the below information.

```json
{
  "date":"2023-07-06T11:59:51+10:00",
  "file_name":"test_logging.rb",
  "calling_class":"LogTest::TestLogging",
  "function_name":"call",
  "lineno":8,
  "severity":"INFO",
  "pid":"27365",
  "message":"Hello World call from LogTest::TestLogging"
}
```

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [Example 1 - Single file](#example-1)
- [Example 2 - Multiple files file](#example-2)

## Installation

gem install:

```bash
gem install json_ruby_logger
```

bundler install:

```Gemfile
gem 'json_ruby_logger'
```

## Usage

### Examples

#### Example 1

Example 1 - Single function in a single file called `test_logging.rb`:


```ruby
include JsonRubyLogger
def test
  logger.info("Hello World call from #{self.class.name}")
end

test
```

Run `ruby test_logging.rb`

Output from example 1:

```json
{"date":"2023-07-06T15:10:24+10:00","file_name":"test_logger.rb","calling_class":"Object","function_name":"test","lineno":31,"severity":"INFO","pid":44665,"message":"Hello World call from Object"}
```

#### Example 2

Example 2 in a single files called `test_logging.rb`:

```ruby
require 'json_ruby_logger'

module LogTest
  class TestLogging
    include JsonRubyLogger

    def call
      logger.info("Hello World call from #{self.class.name}")
      call2
    end

    def call2
      logger.info("Hello World call2 from #{self.class.name}")
    end
  end
end


class TestLogging2
  include JsonRubyLogger

  def call
    logger.info("Hello World call from #{self.class.name}")
    call2
  end

  def call2
    logger.info("Hello World call2 from #{self.class.name}")
  end
end

LogTest::TestLogging.new.call
TestLogging2.new.call
```

Run `ruby test_logging.rb`

Output from example 2:

```json
{"date":"2023-07-06T11:59:51+10:00","file_name":"test_logging.rb","calling_class":"LogTest::TestLogging","function_name":"call","lineno":8,"severity":"INFO","pid":"#27365","message":"Hello World call from LogTest::TestLogging"}
{"date":"2023-07-06T11:59:51+10:00","file_name":"test_logging.rb","calling_class":"LogTest::TestLogging","function_name":"call2","lineno":13,"severity":"INFO","pid":"#27365","message":"Hello World call2 from LogTest::TestLogging"}
{"date":"2023-07-06T11:59:51+10:00","file_name":"test_logging.rb","calling_class":"TestLogging2","function_name":"call","lineno":23,"severity":"INFO","pid":"#27365","message":"Hello World call from TestLogging2"}
{"date":"2023-07-06T11:59:51+10:00","file_name":"test_logging.rb","calling_class":"TestLogging2","function_name":"call2","lineno":28,"severity":"INFO","pid":"#27365","message":"Hello World call2 from TestLogging2"}
```

#### Example 3

Example 3 multi files in sub folders:

File `./lib/another_class.rb`

```ruby
require 'json_ruby_logger'

class AnotherClass
  include JsonRubyLogger

  def another_class_call
    logger.info("AnotherClass Hello World call from #{self.class.name}")
    another_class
  end

  def another_class
    logger.info("Hello World call2 from #{self.class.name}")
  end
end
```

File `./test_logging.rb`

```ruby
require_relative 'lib/another_class'
require 'json_ruby_logger'

class TestLogging
  include JsonRubyLogger

  def call
    logger.info("Hello World call from #{self.class.name}")
    another_class
  end

  def another_class
    logger.info("Hello World call2 from #{self.class.name}")
    AnotherClass.new.another_class_call
  end
end

TestLogging.new.call
```

Run `ruby test_logging.rb`

Output from example 3:

```json
{"date":"2023-07-06T12:08:48+10:00","file_name":"test_logger.rb","calling_class":"TestLogging","function_name":"call","lineno":8,"severity":"INFO","pid":"#29554","message":"Hello World call from TestLogging"}
{"date":"2023-07-06T12:08:48+10:00","file_name":"test_logger.rb","calling_class":"TestLogging","function_name":"another_class","lineno":13,"severity":"INFO","pid":"#29554","message":"Hello World call2 from TestLogging"}
{"date":"2023-07-06T12:08:48+10:00","file_name":"another_class.rb","calling_class":"AnotherClass","function_name":"another_class_call","lineno":7,"severity":"INFO","pid":"#29554","message":"AnotherClass Hello World call from AnotherClass"}
{"date":"2023-07-06T12:08:48+10:00","file_name":"another_class.rb","calling_class":"AnotherClass","function_name":"another_class","lineno":12,"severity":"INFO","pid":"#29554","message":"Hello World call2 from AnotherClass"}
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Creating a Gem

### Create a Gem Skeleton

```bash
bundle gem json_ruby_logger \
--mit \
--linter=rubocop \
--test=rspec \
--ci=github \
--no-coc
```

### Build the gem

```bash
  gem build json_ruby_logger.gemspec
```

### push the gem to rubygems.org

```bash
  gem push json_ruby_logger-0.1.0.gem
```

## Revoke/yank a gem

```bash
  gem yank json_ruby_logger -v 0.1.0
```

## Bump Gem Version

```bash
  gem install gem-release
  gem bump patch --skip-ci --push
```

                        
## Stargazers over time :joy:
[![Stargazers over time](https://starchart.cc/do-i-need-a-username/json_ruby_logger.svg?variant=adaptive)](https://starchart.cc/do-i-need-a-username/json_ruby_logger)

                    

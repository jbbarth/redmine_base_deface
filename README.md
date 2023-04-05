Redmine base_deface plugin
======================

Integrate with the deface gem to manage view modifications in plugins

Installation
------------

This plugin is compatible with Redmine 2.1.0+.

Please apply general instructions for plugins [here](http://www.redmine.org/wiki/redmine/Plugins).

First download the source or clone the plugin and put it in the "plugins/" directory of your redmine instance. Note that this is crucial that the directory is named redmine_base_deface !

Then execute from redmine root directory:

    $ bundle install
    $ rake redmine:plugins

And finally restart your Redmine instance.

Test status
-----------

|Plugin branch| Redmine Version | Test Status       |
|-------------|-----------------|-------------------|
|master       | 5.0.4           | [![5.0.4][1]][5]  |  
|master       | 4.2.9           | [![4.2.9][2]][5]  |
|master       | master          | [![master][4]][5] |

[1]: https://github.com/jbbarth/redmine_base_deface/actions/workflows/5_0_4.yml/badge.svg
[2]: https://github.com/jbbarth/redmine_base_deface/actions/workflows/4_2_9.yml/badge.svg
[4]: https://github.com/jbbarth/redmine_base_deface/actions/workflows/master.yml/badge.svg
[5]: https://github.com/jbbarth/redmine_base_deface/actions

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


License
-------

This project is released under the MIT license, see LICENSE file.

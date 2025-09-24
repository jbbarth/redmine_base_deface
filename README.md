Redmine base_deface plugin
======================

Integrate with the deface gem to manage view modifications in plugins

Installation
------------

This plugin is compatible with Redmine 2.1.0+.

Please apply general instructions for plugins [here](https://www.redmine.org/projects/redmine/wiki/Plugins).

First download the source or clone the plugin and put it in the "plugins/" directory of your redmine instance. Note that this is crucial that the directory is named redmine_base_deface !

Then execute from redmine root directory:

    $ bundle install
    $ rake redmine:plugins

And finally restart your Redmine instance.

Test status
-----------

|Plugin branch| Redmine Version | Test Status       |
|-------------|-----------------|-------------------|
|master       | 6.0.7           | [![6.0.7][1]][5]  |
|master       | 6.1.0           | [![6.1.0][2]][5]  |
|master       | master          | [![master][3]][5] |

[1]: https://github.com/jbbarth/redmine_base_deface/actions/workflows/6_0_7.yml/badge.svg
[2]: https://github.com/jbbarth/redmine_base_deface/actions/workflows/6_1_0.yml/badge.svg
[3]: https://github.com/jbbarth/redmine_base_deface/actions/workflows/master.yml/badge.svg
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

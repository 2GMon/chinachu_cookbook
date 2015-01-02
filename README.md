chinachu Cookbook
=================
This cookbook set up chinachu.

Requirements
------------

#### platforms
- `Debian` - This cookbook is tested with only debian-7.6.

#### packages

#### cookbooks
- `recpt1_cookbook` - https://github.com/2GMon/recpt1_cookbook
- `bcas_reader_cookbook` - https://github.com/2GMon/bcas_reader_cookbook

Attributes
----------
#### chinachu::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['chinachu']['user']</tt></td>
    <td>String</td>
    <td>chinachu install user</td>
    <td><tt>chinachu</tt></td>
  </tr>
</table>

Usage
-----
#### chinachu::default
Just include `chinachu` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chinachu]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Takaaki TSUJIMOTO

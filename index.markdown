---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

<h1>Site Data Keys</h1>
<ul>
{% for data in site.data.videos.keys %}
  <li>{{ data[0] }}: {{ data[1] | inspect }}</li>
{% endfor %}
</ul>

<h2>Leadership</h2>
{% for post in site.data.videos.Leadership %}
<li><a href="{{ post.link }}" target="_blank">{{ post.title }}</a></li>
{% endfor %}

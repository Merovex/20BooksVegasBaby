---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

<h2>Leadership</h2>
{% for post in site.data.videos.HighPoweredAuthorsPanel %}
<li><a href="{{ post.link }}">{{ post.title }} ({{post.year}})</a></li>
{% endfor %}
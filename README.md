# README

## Development
```
docker build --no-cache --build-arg HUGO_SITE_REPO=https://github.com/paulcoghlan/pixse1.git -t hugo-nginx .
docker run -it hugo-nginx
```

## Deployment
```
docker build --build-arg HUGO_SITE_REPO=git@github.com:paulcoghlan/pixse1.git -t hugo-nginx .
docker run -p 8080:80 hugo-nginx
```

## Site Changes due to Hugo versions


```
 git diff
diff --git a/config.toml b/config.toml
index 7af4ee5..fae1c25 100644
--- a/config.toml
+++ b/config.toml
@@ -3,7 +3,6 @@ languageCode = "en-us"
 # Add it only if you keep the theme in the `themes` directory.
 # Remove it if you use the theme as a remote Hugo Module.
 theme = "hello-friend"
-paginate = 5


 # contentDir = "content-debug"
@@ -54,4 +53,4 @@ contentDir = "content"
         identifier = "gallery"
         name = "Collections"
         url = "/gallery"
-
\ No newline at end of file
+
diff --git a/themes/hello-friend b/themes/hello-friend
--- a/themes/hello-friend
+++ b/themes/hello-friend
@@ -1 +1 @@
-Subproject commit 61ca4a83f79853a826446e8cefa6062f5406e8a4
+Subproject commit 61ca4a83f79853a826446e8cefa6062f5406e8a4-dirty
root@5d4a9521b1fd:/site# cd themes/hello-friend/
root@5d4a9521b1fd:/site/themes/hello-friend# git diff
diff --git a/layouts/_default/baseof.html b/layouts/_default/baseof.html
index 4d09da5..b2f88b2 100644
--- a/layouts/_default/baseof.html
+++ b/layouts/_default/baseof.html
@@ -23,8 +23,5 @@
       {{ end }}
     </div>

-    {{ if $.Site.GoogleAnalytics }}
-      {{ template "_internal/google_analytics.html" . }}
-    {{ end }}
   </body>
 </html>
diff --git a/layouts/partials/head.html b/layouts/partials/head.html
index 5e19888..8052673 100644
--- a/layouts/partials/head.html
+++ b/layouts/partials/head.html
@@ -21,7 +21,7 @@
 <link rel="stylesheet" href="{{ "style.css" | absURL }}" />

 {{ $sass := resources.Get "sass/gallery.scss" }}
-{{ $style := $sass | resources.ToCSS }}
+{{ $style := $sass | css.Sass }}
 <link rel="stylesheet" href="{{ $style.Permalink }}" integrity="{{ $style.Data.Integrity }}">


```

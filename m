Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126ADC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32A4204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="deIL1mqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgICA6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:58:33 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:10763 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgICA6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 20:58:30 -0400
Date:   Thu, 03 Sep 2020 00:58:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599094708;
        bh=PET/ZuwCWRekPho7nwRhHPhm2jKjqqcgzZxgmDViWgk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=deIL1mqhhMYKTA6H36+VRTZmWWK6+AfNUZT56WtFWBtXnGxvDgvuHJXfazEv1lmc9
         prXWNHR/2vWkQMWWVmPAeH1b2RX+OuL7LO8jQFPXm8SZioO7C/BRsyiF7U03bXqazP
         PeFETr+l4g8/rpZybLSF3sz0MKi3l0DwNtNS2xos=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH 1/2] docs: Add automatic cross-reference for C types
Message-ID: <20200903005747.3900333-2-nfraprado@protonmail.com>
In-Reply-To: <20200903005747.3900333-1-nfraprado@protonmail.com>
References: <20200903005747.3900333-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cross-reference C types in the documentation, Sphinx
requires the syntax :c:type:`type_name`, or even :c:type:`struct
type_name <type_name>` in order to have the link text different from the
target text.

Extend automarkup to enable automatic cross-reference of C types by
matching any "struct|union|enum|typedef type_name" expression.
This makes the documentation's plain text cleaner and adds
cross-reference to types without any additional effort by the author.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---
 Documentation/sphinx/automarkup.py | 37 +++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/auto=
markup.py
index b18236370742..272eb2bdfab1 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -13,6 +13,7 @@ if sphinx.version_info[0] < 2 or \
 else:
     from sphinx.errors import NoUri
 import re
+from itertools import chain
=20
 #
 # Regex nastiness.  Of course.
@@ -21,7 +22,8 @@ import re
 # :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
 # bit tries to restrict matches to things that won't create trouble.
 #
-RE_function =3D re.compile(r'([\w_][\w\d_]+\(\))')
+RE_function =3D re.compile(r'(([\w_][\w\d_]+)\(\))')
+RE_type =3D re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d_]+)')
=20
 #
 # Many places in the docs refer to common system calls.  It is
@@ -35,31 +37,39 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcnt=
l', 'mmap',
               'socket' ]
=20
 #
-# Find all occurrences of function() and try to replace them with
-# appropriate cross references.
+# Find all occurrences of C references (function() and struct/union/enum/t=
ypedef
+# type_name) and try to replace them with appropriate cross references.
 #
-def markup_funcs(docname, app, node):
+def markup_c_refs(docname, app, node):
+    class_str =3D {RE_function: 'c-func', RE_type: 'c-type'}
+    reftype_str =3D {RE_function: 'function', RE_type: 'type'}
+
     cdom =3D app.env.domains['c']
     t =3D node.astext()
     done =3D 0
     repl =3D [ ]
-    for m in RE_function.finditer(t):
+    #
+    # Sort all C references by the starting position in text
+    #
+    sorted_matches =3D sorted(chain(RE_type.finditer(t), RE_function.findi=
ter(t)),
+                            key=3Dlambda m: m.start())
+    for m in sorted_matches:
         #
-        # Include any text prior to function() as a normal text node.
+        # Include any text prior to match as a normal text node.
         #
         if m.start() > done:
             repl.append(nodes.Text(t[done:m.start()]))
         #
         # Go through the dance of getting an xref out of the C domain
         #
-        target =3D m.group(1)[:-2]
-        target_text =3D nodes.Text(target + '()')
+        target =3D m.group(2)
+        target_text =3D nodes.Text(m.group(0))
         xref =3D None
-        if target not in Skipfuncs:
-            lit_text =3D nodes.literal(classes=3D['xref', 'c', 'c-func'])
+        if not (m.re =3D=3D RE_function and target in Skipfuncs):
+            lit_text =3D nodes.literal(classes=3D['xref', 'c', class_str[m=
.re]])
             lit_text +=3D target_text
             pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
-                                          reftype =3D 'function',
+                                          reftype =3D reftype_str[m.re],
                                           reftarget =3D target, modname =
=3D None,
                                           classname =3D None)
             #
@@ -68,7 +78,8 @@ def markup_funcs(docname, app, node):
             #
             try:
                 xref =3D cdom.resolve_xref(app.env, docname, app.builder,
-                                         'function', target, pxref, lit_te=
xt)
+                                         reftype_str[m.re], target, pxref,
+                                         lit_text)
             except NoUri:
                 xref =3D None
         #
@@ -97,7 +108,7 @@ def auto_markup(app, doctree, name):
     for para in doctree.traverse(nodes.paragraph):
         for node in para.traverse(nodes.Text):
             if not isinstance(node.parent, nodes.literal):
-                node.parent.replace(node, markup_funcs(name, app, node))
+                node.parent.replace(node, markup_c_refs(name, app, node))
=20
 def setup(app):
     app.connect('doctree-resolved', auto_markup)
--=20
2.28.0



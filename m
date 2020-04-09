Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D46C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517DA20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duYC2sW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgDIQ7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:59:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50402 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726728AbgDIQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586451543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIlNiJb3ausYuUxni1zU+nLq9ARdN6KgHNOnahfy3D8=;
        b=duYC2sW3uk0LSqlj2ZNh0LdYBbf83vIqOqYsjTtTDm8Ot62JbddhkHSJS5afx2GsuQOkAf
        QipAsl8pBdu+rCvxTLsQDBcIiZzjNziR/aQikIKb6Urx7Rz5jrem8O6vrd9BZu8cBMDWyl
        Y/AasEJBMlotbvG+PGBHTf24y0NO430=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-cNAfnu6LPDSY90YRtKWIXg-1; Thu, 09 Apr 2020 12:58:54 -0400
X-MC-Unique: cNAfnu6LPDSY90YRtKWIXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C213100727C;
        Thu,  9 Apr 2020 16:58:53 +0000 (UTC)
Received: from agerstmayr-thinkpad.redhat.com (unknown [10.40.193.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46EB960BFB;
        Thu,  9 Apr 2020 16:58:48 +0000 (UTC)
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf script flamegraph: python2 support, update cli args
Date:   Thu,  9 Apr 2020 18:57:31 +0200
Message-Id: <20200409165734.165260-1-agerstmayr@redhat.com>
In-Reply-To: <20200406151118.GC32649@kernel.org>
References: <20200406151118.GC32649@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* removed --indent argument
* renamed -F to -f argument to be consistent with other arguments

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
---
 tools/perf/scripts/python/flamegraph.py | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts=
/python/flamegraph.py
index 5835d190ca42..61f3be9add6b 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -14,6 +14,7 @@
 # Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
 # Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.co=
m>
=20
+from __future__ import print_function
 import sys
 import os
 import argparse
@@ -43,11 +44,11 @@ class FlameGraphCLI:
=20
         if self.args.format =3D=3D "html" and \
                 not os.path.isfile(self.args.template):
-            print(f"Flame Graph template {self.args.template} does not "=
 +
-                  f"exist. Please install the js-d3-flame-graph (RPM) or=
 " +
-                  f"libjs-d3-flame-graph (deb) package, specify an " +
-                  f"existing flame graph template (--template PATH) or "=
 +
-                  f"another output format (--format FORMAT).",
+            print("Flame Graph template {} does not exist. Please instal=
l "
+                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (=
deb) "
+                  "package, specify an existing flame graph template "
+                  "(--template PATH) or another output format "
+                  "(--format FORMAT).".format(self.args.template),
                   file=3Dsys.stderr)
             sys.exit(1)
=20
@@ -76,8 +77,7 @@ class FlameGraphCLI:
         node.value +=3D 1
=20
     def trace_end(self):
-        json_str =3D json.dumps(self.stack, default=3Dlambda x: x.toJSON=
(),
-                              indent=3Dself.args.indent)
+        json_str =3D json.dumps(self.stack, default=3Dlambda x: x.toJSON=
())
=20
         if self.args.format =3D=3D "html":
             try:
@@ -85,7 +85,7 @@ class FlameGraphCLI:
                     output_str =3D f.read().replace("/** @flamegraph_jso=
n **/",
                                                   json_str)
             except IOError as e:
-                print(f"Error reading template file: {e}", file=3Dsys.st=
derr)
+                print("Error reading template file: {}".format(e), file=3D=
sys.stderr)
                 sys.exit(1)
             output_fn =3D self.args.output or "flamegraph.html"
         else:
@@ -95,24 +95,22 @@ class FlameGraphCLI:
         if output_fn =3D=3D "-":
             sys.stdout.write(output_str)
         else:
-            print(f"dumping data to {output_fn}")
+            print("dumping data to {}".format(output_fn))
             try:
                 with open(output_fn, "w") as out:
                     out.write(output_str)
             except IOError as e:
-                print(f"Error writing output file: {e}", file=3Dsys.stde=
rr)
+                print("Error writing output file: {}".format(e), file=3D=
sys.stderr)
                 sys.exit(1)
=20
=20
 if __name__ =3D=3D "__main__":
     parser =3D argparse.ArgumentParser(description=3D"Create flame graph=
s.")
-    parser.add_argument("-F", "--format",
+    parser.add_argument("-f", "--format",
                         default=3D"html", choices=3D["json", "html"],
                         help=3D"output file format")
     parser.add_argument("-o", "--output",
                         help=3D"output file name")
-    parser.add_argument("--indent",
-                        type=3Dint, help=3D"JSON indentation")
     parser.add_argument("--template",
                         default=3D"/usr/share/d3-flame-graph/d3-flamegra=
ph-base.html",
                         help=3D"path to flamegraph HTML template")
--=20
2.25.2


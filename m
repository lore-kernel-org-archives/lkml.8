Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65928C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BA320722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNLpHMpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgBUR4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:56:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33091 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBUR4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582307805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=88Nxd/8ku9aw8ZzcS+9T+V3Q+Oha7xL17ZgefCeO0Ts=;
        b=RNLpHMpzDpi4ErEQwHrwo/aAMbT0DYaBaT+zpVdZ7sGSSlyEfO3uPcqromTBJ0qdZovR2k
        t8Pl3sLWriWQjemyt+VTey5cihWpjXDh+czrL9LZSX7Uwb9tCiSU4qohybILs8Wau6pEr+
        vXnnAeaKl4Pg8LATcfnx3vu6IgP0SG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-kK2a9-HfNzq8c8Z5J2Azsg-1; Fri, 21 Feb 2020 12:56:39 -0500
X-MC-Unique: kK2a9-HfNzq8c8Z5J2Azsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7B60107ACC9;
        Fri, 21 Feb 2020 17:56:37 +0000 (UTC)
Received: from agerstmayr-thinkpad.redhat.com (ovpn-204-47.brq.redhat.com [10.40.204.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4BE3790CF;
        Fri, 21 Feb 2020 17:56:29 +0000 (UTC)
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kabbott@redhat.com, skozina@redhat.com, mpetlan@redhat.com,
        nathans@redhat.com, mgoodwin@redhat.com,
        linux-perf-users@vger.kernel.org, bgregg@netflix.com,
        mspier@netflix.com, Andreas Gerstmayr <agerstmayr@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC] perf script: add flamegraph.py script
Date:   Fri, 21 Feb 2020 18:55:01 +0100
Message-Id: <20200221175500.83774-1-agerstmayr@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script works in tandem with d3-flame-graph to generate flame graphs
from perf. It supports two output formats: JSON and HTML (the default).
The HTML format will look for a standalone d3-flame-graph template file i=
n
/usr/share/d3-flame-graph/template.html and fill in the collected stacks.

Usage:

    perf script flamegraph -a -F 99 sleep 60

Alternative usage:

    perf record -a -g -F 99 sleep 60
    perf script report flamegraph

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---

I'm currently preparing packages for d3-flame-graph. For Fedora, the copr
at
https://copr.fedorainfracloud.org/coprs/agerstmayr/reviews/package/js-d3-=
flame-graph/
can be installed, or alternatively the prebuilt standalone d3-flame-graph
template can be downloaded from
https://raw.githubusercontent.com/andreasgerstmayr/specs/master/reviews/j=
s-d3-flame-graph/template.html
and moved into /usr/share/d3-flame-graph/template.html

 .../perf/scripts/python/bin/flamegraph-record |   2 +
 .../perf/scripts/python/bin/flamegraph-report |   3 +
 tools/perf/scripts/python/flamegraph.py       | 117 ++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-record
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-report
 create mode 100755 tools/perf/scripts/python/flamegraph.py

diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf=
/scripts/python/bin/flamegraph-record
new file mode 100755
index 000000000000..725d66e71570
--- /dev/null
+++ b/tools/perf/scripts/python/bin/flamegraph-record
@@ -0,0 +1,2 @@
+#!/usr/bin/sh
+perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf=
/scripts/python/bin/flamegraph-report
new file mode 100755
index 000000000000..b1a79afd903b
--- /dev/null
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -0,0 +1,3 @@
+#!/usr/bin/sh
+# description: create flame graphs
+perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts=
/python/flamegraph.py
new file mode 100755
index 000000000000..2e9139ef2c4a
--- /dev/null
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -0,0 +1,117 @@
+# flamegraph.py - create flame graphs from perf samples
+# SPDX-License-Identifier: GPL-2.0
+#
+# Usage:
+#
+#  perf record -a -g -F 99 sleep 60
+#  perf script report flamegraph
+#
+# Combined data collection and flamegraph generation:
+#
+#  perf script flamegraph -a -F 99 sleep 60
+#
+# Written by Andreas Gerstmayr <agerstmayr@redhat.com>
+# Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
+# Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.co=
m>
+
+import sys
+import os
+import argparse
+import json
+
+
+class Node:
+    def __init__(self, name, libtype=3D""):
+        self.name =3D name
+        self.libtype =3D libtype
+        self.value =3D 0
+        self.children =3D []
+
+
+class FlameGraphCLI:
+    def __init__(self, args):
+        self.args =3D args
+        self.stack =3D Node("root")
+
+        if self.args.format =3D=3D "html" and \
+                not os.path.isfile(self.args.template):
+            print(f"Flame Graph template '{self.args.template}' does not=
 " +
+                  f"exist. Please install the d3-flame-graph package, " =
+
+                  f"specify an existing flame graph template " +
+                  f"(--template PATH) or another output format " +
+                  f"(--format FORMAT).", file=3Dsys.stderr)
+            sys.exit(1)
+
+    def find_or_create_node(self, node, name, dso):
+        libtype =3D "kernel" if dso =3D=3D "[kernel.kallsyms]" else ""
+        if name is None:
+            name =3D "[unknown]"
+
+        for child in node.children:
+            if child.name =3D=3D name and child.libtype =3D=3D libtype:
+                return child
+
+        child =3D Node(name, libtype)
+        node.children.append(child)
+        return child
+
+    def process_event(self, event):
+        node =3D self.find_or_create_node(self.stack, event["comm"], Non=
e)
+        if "callchain" in event:
+            for entry in reversed(event['callchain']):
+                node =3D self.find_or_create_node(
+                    node, entry.get("sym", {}).get("name"), event.get("d=
so"))
+        else:
+            node =3D self.find_or_create_node(
+                node, entry.get("symbol"), event.get("dso"))
+        node.value +=3D 1
+
+    def trace_end(self):
+        def encoder(x): return x.__dict__
+        json_str =3D json.dumps(self.stack, default=3Dencoder,
+                              indent=3Dself.args.indent)
+
+        if self.args.format =3D=3D "html":
+            try:
+                with open(self.args.template) as f:
+                    output_str =3D f.read().replace("/** @flamegraph_par=
ams **/",
+                                                  json_str)
+            except IOError as e:
+                print(f"Error reading template file: {e}", file=3Dsys.st=
derr)
+                sys.exit(1)
+            output_fn =3D self.args.output or "flamegraph.html"
+        else:
+            output_str =3D json_str
+            output_fn =3D self.args.output or "stacks.json"
+
+        if output_fn =3D=3D "-":
+            sys.stdout.write(output_str)
+        else:
+            try:
+                with open(output_fn, "w") as out:
+                    out.write(output_str)
+            except IOError as e:
+                print(f"Error writing output file: {e}", file=3Dsys.stde=
rr)
+                sys.exit(1)
+
+
+if __name__ =3D=3D "__main__":
+    parser =3D argparse.ArgumentParser(description=3D"Create flame graph=
s.")
+    parser.add_argument("-F", "--format",
+                        default=3D"html", choices=3D["json", "html"],
+                        help=3D"output file format")
+    parser.add_argument("-o", "--output",
+                        help=3D"output file name")
+    parser.add_argument("--indent",
+                        type=3Dint, help=3D"JSON indentation")
+    parser.add_argument("--template",
+                        default=3D"/usr/share/d3-flame-graph/template.ht=
ml",
+                        help=3D"path to flamegraph HTML template")
+    parser.add_argument("-i", "--input",
+                        help=3Dargparse.SUPPRESS)
+
+    args =3D parser.parse_args()
+    cli =3D FlameGraphCLI(args)
+
+    process_event =3D cli.process_event
+    trace_end =3D cli.trace_end
--=20
2.24.1


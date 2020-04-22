Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD8C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87AAC2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgDVMSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727782AbgDVMRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94461C03C1A8;
        Wed, 22 Apr 2020 05:17:42 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJr-0007sr-TT; Wed, 22 Apr 2020 14:17:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD77C1C04CF;
        Wed, 22 Apr 2020 14:17:27 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:27 -0000
From:   "tip-bot2 for Andreas Gerstmayr" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf script: Add flamegraph.py script
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Martin Spier <mspier@netflix.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320151355.66302-1-agerstmayr@redhat.com>
References: <20200320151355.66302-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Message-ID: <158755784751.28353.7167213129774266352.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5287f926920688e1151741d49da37a533ccf1960
Gitweb:        https://git.kernel.org/tip/5287f926920688e1151741d49da37a533ccf1960
Author:        Andreas Gerstmayr <agerstmayr@redhat.com>
AuthorDate:    Fri, 20 Mar 2020 16:13:48 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:14 -03:00

perf script: Add flamegraph.py script

This script works in tandem with d3-flame-graph to generate flame graphs
from perf. It supports two output formats: JSON and HTML (the default).
The HTML format will look for a standalone d3-flame-graph template file
in /usr/share/d3-flame-graph/d3-flamegraph-base.html and fill in the
collected stacks.

Usage:

    perf record -a -g -F 99 sleep 60
    perf script report flamegraph

Combined:

    perf script flamegraph -a -F 99 sleep 60

Committer testing:

Tested both with "PYTHON=python3" and with the default, that uses
python2-devel:

Complete set of instructions:

  $ mkdir /tmp/build/perf
  $ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin
  $ export PATH=~/bin:$PATH
  $ perf record -a -g -F 99 sleep 60
  $ perf script report flamegraph

Now go and open the generated flamegraph.html file in a browser.

At first this required building with PYTHON=python3, but after I
reported this Andreas was kind enough to send a patch making it work
with both python and python3.

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Brendan Gregg <bgregg@netflix.com>
Cc: Martin Spier <mspier@netflix.com>
Link: http://lore.kernel.org/lkml/20200320151355.66302-1-agerstmayr@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/bin/flamegraph-record |   2 +-
 tools/perf/scripts/python/bin/flamegraph-report |   3 +-
 tools/perf/scripts/python/flamegraph.py         | 124 +++++++++++++++-
 3 files changed, 129 insertions(+)
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-record
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-report
 create mode 100755 tools/perf/scripts/python/flamegraph.py

diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/scripts/python/bin/flamegraph-record
new file mode 100755
index 0000000..725d66e
--- /dev/null
+++ b/tools/perf/scripts/python/bin/flamegraph-record
@@ -0,0 +1,2 @@
+#!/usr/bin/sh
+perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
new file mode 100755
index 0000000..b1a79af
--- /dev/null
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -0,0 +1,3 @@
+#!/usr/bin/sh
+# description: create flame graphs
+perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
new file mode 100755
index 0000000..61f3be9
--- /dev/null
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -0,0 +1,124 @@
+# flamegraph.py - create flame graphs from perf samples
+# SPDX-License-Identifier: GPL-2.0
+#
+# Usage:
+#
+#     perf record -a -g -F 99 sleep 60
+#     perf script report flamegraph
+#
+# Combined:
+#
+#     perf script flamegraph -a -F 99 sleep 60
+#
+# Written by Andreas Gerstmayr <agerstmayr@redhat.com>
+# Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
+# Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
+
+from __future__ import print_function
+import sys
+import os
+import argparse
+import json
+
+
+class Node:
+    def __init__(self, name, libtype=""):
+        self.name = name
+        self.libtype = libtype
+        self.value = 0
+        self.children = []
+
+    def toJSON(self):
+        return {
+            "n": self.name,
+            "l": self.libtype,
+            "v": self.value,
+            "c": self.children
+        }
+
+
+class FlameGraphCLI:
+    def __init__(self, args):
+        self.args = args
+        self.stack = Node("root")
+
+        if self.args.format == "html" and \
+                not os.path.isfile(self.args.template):
+            print("Flame Graph template {} does not exist. Please install "
+                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
+                  "package, specify an existing flame graph template "
+                  "(--template PATH) or another output format "
+                  "(--format FORMAT).".format(self.args.template),
+                  file=sys.stderr)
+            sys.exit(1)
+
+    def find_or_create_node(self, node, name, dso):
+        libtype = "kernel" if dso == "[kernel.kallsyms]" else ""
+        if name is None:
+            name = "[unknown]"
+
+        for child in node.children:
+            if child.name == name and child.libtype == libtype:
+                return child
+
+        child = Node(name, libtype)
+        node.children.append(child)
+        return child
+
+    def process_event(self, event):
+        node = self.find_or_create_node(self.stack, event["comm"], None)
+        if "callchain" in event:
+            for entry in reversed(event['callchain']):
+                node = self.find_or_create_node(
+                    node, entry.get("sym", {}).get("name"), event.get("dso"))
+        else:
+            node = self.find_or_create_node(
+                node, entry.get("symbol"), event.get("dso"))
+        node.value += 1
+
+    def trace_end(self):
+        json_str = json.dumps(self.stack, default=lambda x: x.toJSON())
+
+        if self.args.format == "html":
+            try:
+                with open(self.args.template) as f:
+                    output_str = f.read().replace("/** @flamegraph_json **/",
+                                                  json_str)
+            except IOError as e:
+                print("Error reading template file: {}".format(e), file=sys.stderr)
+                sys.exit(1)
+            output_fn = self.args.output or "flamegraph.html"
+        else:
+            output_str = json_str
+            output_fn = self.args.output or "stacks.json"
+
+        if output_fn == "-":
+            sys.stdout.write(output_str)
+        else:
+            print("dumping data to {}".format(output_fn))
+            try:
+                with open(output_fn, "w") as out:
+                    out.write(output_str)
+            except IOError as e:
+                print("Error writing output file: {}".format(e), file=sys.stderr)
+                sys.exit(1)
+
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(description="Create flame graphs.")
+    parser.add_argument("-f", "--format",
+                        default="html", choices=["json", "html"],
+                        help="output file format")
+    parser.add_argument("-o", "--output",
+                        help="output file name")
+    parser.add_argument("--template",
+                        default="/usr/share/d3-flame-graph/d3-flamegraph-base.html",
+                        help="path to flamegraph HTML template")
+    parser.add_argument("-i", "--input",
+                        help=argparse.SUPPRESS)
+
+    args = parser.parse_args()
+    cli = FlameGraphCLI(args)
+
+    process_event = cli.process_event
+    trace_end = cli.trace_end

Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3245C20786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R89A4Vk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391076AbgFSPeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:34:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404901AbgFSPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592580845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1gjUns75l8t6S6FnUcYsN6ZlE6IET04KazBXsahJkg8=;
        b=R89A4Vk1fiBeltHWigJoNwYNpFI/7x3JzBZIGYRejPjtRqZwhEvH/aye5EvgwfEDcWHCzr
        w78g5PPSjhAkkUkWcP+2OavZGo7GhLyvVdloDeXAc2iMAorfPJSs5J6I8K/bBWj2WndLpn
        apzsgtdEcqEnCJ+RHNJnxOnPu8I7vZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-NbuglgpSPkKbOHTyzRHHIQ-1; Fri, 19 Jun 2020 11:34:00 -0400
X-MC-Unique: NbuglgpSPkKbOHTyzRHHIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44B44801503;
        Fri, 19 Jun 2020 15:33:59 +0000 (UTC)
Received: from agerstmayr-thinkpad.redhat.com (unknown [10.40.196.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 915942CE8A;
        Fri, 19 Jun 2020 15:33:51 +0000 (UTC)
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Michael Petlan <mpetlan@redhat.com>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf flamegraph: explicitly set utf-8 encoding
Date:   Fri, 19 Jun 2020 17:32:31 +0200
Message-Id: <20200619153232.203537-1-agerstmayr@redhat.com>
In-Reply-To: <20200619130745.153113-1-agerstmayr@redhat.com>
References: <20200619130745.153113-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on some platforms the default encoding is not utf-8,
which causes an UnicodeDecodeError when reading the flamegraph template
and writing the flamegraph

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
---

changelog v2: also write to stdout with utf-8 encoding

 tools/perf/scripts/python/flamegraph.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index 61f3be9add6b..65780013f745 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -17,6 +17,7 @@
 from __future__ import print_function
 import sys
 import os
+import io
 import argparse
 import json
 
@@ -81,7 +82,7 @@ class FlameGraphCLI:
 
         if self.args.format == "html":
             try:
-                with open(self.args.template) as f:
+                with io.open(self.args.template, encoding="utf-8") as f:
                     output_str = f.read().replace("/** @flamegraph_json **/",
                                                   json_str)
             except IOError as e:
@@ -93,11 +94,12 @@ class FlameGraphCLI:
             output_fn = self.args.output or "stacks.json"
 
         if output_fn == "-":
-            sys.stdout.write(output_str)
+            with io.open(sys.stdout.fileno(), "w", encoding="utf-8", closefd=False) as out:
+                out.write(output_str)
         else:
             print("dumping data to {}".format(output_fn))
             try:
-                with open(output_fn, "w") as out:
+                with io.open(output_fn, "w", encoding="utf-8") as out:
                     out.write(output_str)
             except IOError as e:
                 print("Error writing output file: {}".format(e), file=sys.stderr)
-- 
2.25.4


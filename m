Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAB7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE0C208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMFgCmWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgFSNJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:09:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48536 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgFSNJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592572141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OK11zaapoxWJXtILVuIHMvOvKkMZ2TEh815CSjabwLM=;
        b=AMFgCmWRDRAvK1RYZWKW9i5Fnli/60QfcTXo0QfD12Vwk54fw7wGBD22cwhiOMv6LWwJG9
        +3jNpZ1WjwH/uJLb2H0t8Sj/kirSI3108biujgiHEP5CJf/X2G4JPOhTKYk8cE8RtHPcbg
        Ao3SDcJ1QEYthkI4yFgN5dK/ScHHJQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-PA03q-gaMLqEu7SXLAaFYA-1; Fri, 19 Jun 2020 09:08:58 -0400
X-MC-Unique: PA03q-gaMLqEu7SXLAaFYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16C428057B0;
        Fri, 19 Jun 2020 13:08:37 +0000 (UTC)
Received: from agerstmayr-thinkpad.redhat.com (unknown [10.40.196.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9502871667;
        Fri, 19 Jun 2020 13:08:34 +0000 (UTC)
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
Subject: [PATCH] perf flamegraph: explicitly set utf-8 encoding
Date:   Fri, 19 Jun 2020 15:07:43 +0200
Message-Id: <20200619130745.153113-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on some platforms the default encoding is not utf-8,
which causes an UnicodeDecodeError when reading the flamegraph template

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
---
Tested with Python 2.7 and 3.

 tools/perf/scripts/python/flamegraph.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index 61f3be9add6b..8979db910a8f 100755
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
@@ -97,7 +98,7 @@ class FlameGraphCLI:
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


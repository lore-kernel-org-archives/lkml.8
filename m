Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE50C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCCB20739
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDDIl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:41:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41481 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgDDIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:41:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeN3-0000uj-Ps; Sat, 04 Apr 2020 10:41:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5C1501C047B;
        Sat,  4 Apr 2020 10:41:41 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:40 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf pmu-events x86: Use CPU_CLK_UNHALTED.THREAD
 in Kernel_Utilization metric
Cc:     Jin Yao <yao.jin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200309013125.7559-1-yao.jin@linux.intel.com>
References: <20200309013125.7559-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158598970097.28353.12664504602421300829.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8ed1faf0156e569c46f1b3d59e74c9cbd5e557ff
Gitweb:        https://git.kernel.org/tip/8ed1faf0156e569c46f1b3d59e74c9cbd5e557ff
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Mon, 09 Mar 2020 09:31:25 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:56 -03:00

perf pmu-events x86: Use CPU_CLK_UNHALTED.THREAD in Kernel_Utilization metric

The kernel utilization metric does multiplexing currently and is somewhat
unreliable. The problem is that it uses two instances of the fixed counter,
and the kernel has to multipleplex which causes errors. So should use
CPU_CLK_UNHALTED.THREAD instead.

Before:

  # perf stat -M Kernel_Utilization -- sleep 1

  Performance counter stats for 'sleep 1':

          1,419,425      cpu_clk_unhalted.ref_tsc:k
      <not counted>      cpu_clk_unhalted.ref_tsc	(0.00%)

After:

  # perf stat -M Kernel_Utilization -- sleep 1

  Performance counter stats for 'sleep 1':

            746,688      cpu_clk_unhalted.thread:k #      0.7 Kernel_Utilization
          1,088,348      cpu_clk_unhalted.thread

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200309013125.7559-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json     | 2 +-
 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
 tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json    | 2 +-
 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 2 +-
 tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json      | 2 +-
 tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json     | 2 +-
 tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json      | 2 +-
 tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json   | 2 +-
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json      | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index 45a34ce..8cdc7c1 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 961fe43..16fd8a7 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -115,7 +115,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index 746734c..1eb0415 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index a728c6e..7fde0d2 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -316,7 +316,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index 5402cd3..f57c5f3 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -267,7 +267,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index 832f3cb..311a005 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -267,7 +267,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index d69b2a8..28e2544 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -285,7 +285,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 5f465fd..db23db2 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -285,7 +285,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 3e909b3..dbb33e0 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -171,7 +171,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index 50c0532..fb2d7b8 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -171,7 +171,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index f97e831..8704efe 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -304,7 +304,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 35f5db1..b4f9113 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -316,7 +316,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },

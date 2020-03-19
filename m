Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481BCC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149B821473
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgCSOMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:12:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgCSOK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsn-00025y-Jt; Thu, 19 Mar 2020 15:10:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 72E0F1C22AA;
        Thu, 19 Mar 2020 15:10:46 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:46 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf vendor events intel: Add NO_NMI_WATCHDOG metric
 constraint
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1582581564-184429-6-git-send-email-kan.liang@linux.intel.com>
References: <1582581564-184429-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158462704613.28353.4328251690443058213.tip-bot2@tip-bot2>
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

Commit-ID:     b95fcd2c1c25bd14f55d5d6ab268b3ab00b8a774
Gitweb:        https://git.kernel.org/tip/b95fcd2c1c25bd14f55d5d6ab268b3ab00b8a774
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 24 Feb 2020 13:59:24 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 10 Mar 2020 14:56:46 -03:00

perf vendor events intel: Add NO_NMI_WATCHDOG metric constraint

Add NO_NMI_WATCHDOG metric constraint to Page_Walks_Utilization for Sky Lake
and Cascade Lake.

Committer testing:

On a Lenovo T480S, Intel(R) Core(TM) i7-8650U Kaby Lake, that looking at x86's
mapfile.csv file is a:

  $ grep -w skylake tools/perf/pmu-events/arch/x86/mapfile.csv
  GenuineIntel-6-[4589]E,v24,skylake,core
  $

So uses the constraint added in this patch in this file:

  tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json

Before:

  # perf stat -a -M Page_Walks_Utilization sleep 2

   Performance counter stats for 'system wide':

       <not counted>      itlb_misses.walk_pending                                      (0.00%)
       <not counted>      dtlb_load_misses.walk_pending                                     (0.00%)
       <not counted>      dtlb_store_misses.walk_pending                                     (0.00%)
       <not counted>      ept.walk_pending                                              (0.00%)
       <not counted>      cycles                                                        (0.00%)

         2.001750514 seconds time elapsed

  Some events weren't counted. Try disabling the NMI watchdog:
  	echo 0 > /proc/sys/kernel/nmi_watchdog
  	perf stat ...
  	echo 1 > /proc/sys/kernel/nmi_watchdog
  The events in group usually have to be from the same PMU. Try reorganizing the group.
  #

After:

  # perf stat -a -M Page_Walks_Utilization sleep 2
  Splitting metric group Page_Walks_Utilization into standalone metrics.
  Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
      echo 0 > /proc/sys/kernel/nmi_watchdog
      perf stat ...
      echo 1 > /proc/sys/kernel/nmi_watchdog
  ,
   Performance counter stats for 'system wide':

          36,883,102      itlb_misses.walk_pending  #      0.1 Page_Walks_Utilization   (79.99%)
         123,104,146      dtlb_load_misses.walk_pending                                     (80.02%)
          13,720,795      dtlb_store_misses.walk_pending                                     (79.99%)
                   0      ept.walk_pending                                              (79.99%)
       1,519,948,400      cycles                                                        (80.01%)

         2.002170780 seconds time elapsed

  #

Before and after, if we disable the nmi_watchdog we get:

  # echo 0 > /proc/sys/kernel/nmi_watchdog
  # perf stat -a -M Page_Walks_Utilization sleep 2

   Performance counter stats for 'system wide':

          33,721,658      itlb_misses.walk_pending  #      0.1 Page_Walks_Utilization
          84,070,996      dtlb_load_misses.walk_pending
           9,816,071      dtlb_store_misses.walk_pending
                   0      ept.walk_pending
         704,920,899      cycles

         2.002331670 seconds time elapsed

  #

  More information about the metric expressions:

  # perf stat -v -a -M Page_Walks_Utilization sleep 2
  Using CPUID GenuineIntel-6-8E-A
  metric expr ( itlb_misses.walk_pending + dtlb_load_misses.walk_pending + dtlb_store_misses.walk_pending + ept.walk_pending ) / ( 2 * cycles ) for Page_Walks_Utilization
  found event itlb_misses.walk_pending
  found event dtlb_load_misses.walk_pending
  found event dtlb_store_misses.walk_pending
  found event ept.walk_pending
  found event cycles
  adding {itlb_misses.walk_pending,dtlb_load_misses.walk_pending,dtlb_store_misses.walk_pending,ept.walk_pending,cycles}:W
   -> cpu/umask=0x10,(null)=0x186a3,event=0x85/
   -> cpu/umask=0x10,(null)=0x1e8483,event=0x8/
   -> cpu/umask=0x10,(null)=0x1e8483,event=0x49/
   -> cpu/umask=0x10,(null)=0x1e8483,event=0x4f/
  itlb_misses.walk_pending: 8085772 16010162799 16010162799
  dtlb_load_misses.walk_pending: 28134579 16010162799 16010162799
  dtlb_store_misses.walk_pending: 7276535 16010162799 16010162799
  ept.walk_pending: 2 16010162799 16010162799
  cycles: 315140605 16010162799 16010162799

   Performance counter stats for 'system wide':

           8,085,772      itlb_misses.walk_pending  #      0.1 Page_Walks_Utilization
          28,134,579      dtlb_load_misses.walk_pending
           7,276,535      dtlb_store_misses.walk_pending
                   2      ept.walk_pending
         315,140,605      cycles

         2.002333181 seconds time elapsed

  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/1582581564-184429-6-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 3 ++-
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json      | 3 ++-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json     | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index f946532..a728c6e 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -215,7 +215,8 @@
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
-        "MetricName": "Page_Walks_Utilization"
+        "MetricName": "Page_Walks_Utilization",
+        "MetricConstraint": "NO_NMI_WATCHDOG"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index e7feb60..f97e831 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -215,7 +215,8 @@
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
-        "MetricName": "Page_Walks_Utilization"
+        "MetricName": "Page_Walks_Utilization",
+        "MetricConstraint": "NO_NMI_WATCHDOG"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 21d7a0c..35f5db1 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -215,7 +215,8 @@
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
-        "MetricName": "Page_Walks_Utilization"
+        "MetricName": "Page_Walks_Utilization",
+        "MetricConstraint": "NO_NMI_WATCHDOG"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",

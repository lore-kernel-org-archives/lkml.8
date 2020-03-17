Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6104C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FD620754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480814;
	bh=xQUC5I1rRXm7sjS8NVtMBNWTIVmMGA71x+i+8TEAFmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tcCvGX/h+EkSQZDs9/oxkwjhk+HfhCKEEteVYY1vWOyueG7Aie+v8xI6SIJ4W39F5
	 tJry5L44kWXHjpTeW1Z4X0XqnqNa8TKnUYUkoc9pU2TLfO7o1n9G1NSpKr4AjhnPBp
	 /kt8ihGWqG8pN373B7Bpsm+glnIXxxbuMCWvd69E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgCQVdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbgCQVdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:33:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8C22076C;
        Tue, 17 Mar 2020 21:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480810;
        bh=xQUC5I1rRXm7sjS8NVtMBNWTIVmMGA71x+i+8TEAFmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=naKN8Qj9KAx9Amu7xPWzUsnkkj5aVQIMmt9gHZy2u8AFniNK6eok2YviQsOtASYoH
         Qda+aPqHHHZaXNsprxFKAmN9sgOtq0EhdvCJqwpwdCrWOy5H0/sACAeHudYhKFibZ4
         M+pMZv64229xqol7g2DwAE0BMXYrGBUq0KxZuS3w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 06/23] perf vendor events intel: Add NO_NMI_WATCHDOG metric constraint
Date:   Tue, 17 Mar 2020 18:32:42 -0300
Message-Id: <20200317213259.15494-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
index f94653229dd4..a728c6e5119b 100644
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
index e7feb60f9fa9..f97e8316ad2f 100644
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
index 21d7a0c2c2e8..35f5db1786f7 100644
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
-- 
2.21.1


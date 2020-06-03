Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD597C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4BCD20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgFCC0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:26:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:14396 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgFCC0N (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:26:13 -0400
IronPort-SDR: c/aZ9HH6EHhoD/xrCYGQN0aS/CNcAOcSIuEh1OC1x4XuCRV2CfcYnN9lso/1ilpJI68NKVcfp0
 Y8yfd/FbpScg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 19:20:43 -0700
IronPort-SDR: EUMe2M/XBL7ia/qz0Ajfm1U6FCl3w15GvtW2GpWZa0PSuRUzFbPnnP+ZTS//FMpHK9hMnficZt
 y85LOyFqANvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="293792563"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jun 2020 19:20:36 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 1/2] perf vendor events: Update CascadelakeX events to v1.08
Date:   Wed,  3 Jun 2020 10:18:17 +0800
Message-Id: <20200603021818.27028-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603021818.27028-1-yao.jin@linux.intel.com>
References: <20200603021818.27028-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Update CascadelakeX events to v1.08.
- Update CascadelakeX JSON metrics from TMAM 4.0.

Other fixes:
- Add NO_NMI_WATCHDOG metric constraint to Backend_Bound

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 .../arch/x86/cascadelakex/cache.json          |   28 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  153 ++-
 .../arch/x86/cascadelakex/frontend.json       |   34 +
 .../arch/x86/cascadelakex/memory.json         |  704 +++++------
 .../arch/x86/cascadelakex/other.json          | 1100 ++++++++---------
 .../arch/x86/cascadelakex/pipeline.json       |   10 -
 .../arch/x86/cascadelakex/uncore-other.json   |   21 +
 7 files changed, 1061 insertions(+), 989 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json b/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
index 3fba310a5012..3c0f5837480f 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
@@ -8063,6 +8063,20 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_CODE_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1000020004",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event OCR.ALL_PF_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
@@ -9255,20 +9269,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_CODE_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1000020004",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event OCR.ALL_PF_RFO.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index d25eebce34c9..de3193552277 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -4,14 +4,14 @@
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
         "MetricName": "Frontend_Bound",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Machine_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "TopdownL1_SMT",
         "MetricName": "Frontend_Bound_SMT",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Machine_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
@@ -22,13 +22,14 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "TopdownL1_SMT",
         "MetricName": "Bad_Speculation_SMT",
         "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricConstraint": "NO_NMI_WATCHDOG",
         "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
         "MetricName": "Backend_Bound",
@@ -36,7 +37,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) )",
         "MetricGroup": "TopdownL1_SMT",
         "MetricName": "Backend_Bound_SMT",
         "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
@@ -50,7 +51,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "TopdownL1_SMT",
         "MetricName": "Retiring_SMT",
         "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
@@ -58,7 +59,7 @@
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "TopDownL1",
+        "MetricGroup": "Summary",
         "MetricName": "IPC"
     },
     {
@@ -73,24 +74,6 @@
         "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
-    {
-        "BriefDescription": "Branch instructions per taken branch. ",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;PGO",
-        "MetricName": "BpTB"
-    },
-    {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
-        "MetricGroup": "PGO;IcMiss",
-        "MetricName": "IFetch_Line_Utilization"
-    },
-    {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
-        "MetricGroup": "DSB;Fetch_BW",
-        "MetricName": "DSB_Coverage"
-    },
     {
         "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
@@ -104,86 +87,110 @@
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core till ICL; per-Logical Processor ICL onward)",
         "MetricExpr": "4 * cycles",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
-        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
-        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
+        "BriefDescription": "Instructions per Load (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
         "MetricGroup": "Instruction_Type",
-        "MetricName": "IpL"
+        "MetricName": "IpLoad"
     },
     {
-        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
+        "BriefDescription": "Instructions per Store (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
         "MetricGroup": "Instruction_Type",
-        "MetricName": "IpS"
+        "MetricName": "IpStore"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
+        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Branches;Instruction_Type",
-        "MetricName": "IpB"
+        "MetricName": "IpBranch"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
+        "BriefDescription": "Instructions per (near) call (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
+    {
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTkBranch"
+    },
+    {
+        "BriefDescription": "Instructions per Floating Point (FP) Operation (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )",
+        "MetricGroup": "FLOPS;FP_Arith;Instruction_Type",
+        "MetricName": "IpFLOP"
+    },
     {
         "BriefDescription": "Total number of retired Instructions",
         "MetricExpr": "INST_RETIRED.ANY",
-        "MetricGroup": "Summary",
+        "MetricGroup": "Summary;TopDownL1",
         "MetricName": "Instructions"
     },
+    {
+        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop Stream Detector; aka Loop Cache)",
+        "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
+        "MetricGroup": "LSD",
+        "MetricName": "LSD_Coverage"
+    },
+    {
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
+        "MetricGroup": "DSB;Fetch_BW",
+        "MetricName": "DSB_Coverage"
+    },
     {
         "BriefDescription": "Instructions Per Cycle (per physical core)",
         "MetricExpr": "INST_RETIRED.ANY / cycles",
-        "MetricGroup": "SMT",
+        "MetricGroup": "SMT;TopDownL1",
         "MetricName": "CoreIPC"
     },
     {
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "MetricGroup": "SMT",
+        "MetricExpr": "INST_RETIRED.ANY / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
+        "MetricGroup": "SMT;TopDownL1",
         "MetricName": "CoreIPC_SMT"
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / cycles",
+        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
-        "MetricGroup": "Pipeline",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 )",
+        "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
-        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * ( IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE - ( FRONTEND_RETIRED.LATENCY_GE_1 - FRONTEND_RETIRED.LATENCY_GE_2 ) / (UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) ) / (4 * cycles)) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * ( IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE - ( FRONTEND_RETIRED.LATENCY_GE_1 - FRONTEND_RETIRED.LATENCY_GE_2 ) / (UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) ) / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
         "MetricGroup": "BrMispredicts",
         "MetricName": "Branch_Misprediction_Cost"
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
-        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (4 * ( IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE - ( FRONTEND_RETIRED.LATENCY_GE_1 - FRONTEND_RETIRED.LATENCY_GE_2 ) / (UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * ( IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE - ( FRONTEND_RETIRED.LATENCY_GE_1 - FRONTEND_RETIRED.LATENCY_GE_2 ) / (UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) ) * (4 * ( ( CPU_
 CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) / BR_MISP_RETIRED.ALL_BRANCHES",
         "MetricGroup": "BrMispredicts_SMT",
         "MetricName": "Branch_Misprediction_Cost_SMT"
     },
@@ -213,14 +220,14 @@
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricConstraint": "NO_NMI_WATCHDOG",
         "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
-        "MetricName": "Page_Walks_Utilization",
-        "MetricConstraint": "NO_NMI_WATCHDOG"
+        "MetricName": "Page_Walks_Utilization"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ) )",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
@@ -245,7 +252,7 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
         "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
-        "MetricGroup": "Memory_BW",
+        "MetricGroup": "Memory_BW;Offcore",
         "MetricName": "L3_Cache_Access_BW"
     },
     {
@@ -263,7 +270,7 @@
     {
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
-        "MetricGroup": "Cache_Misses",
+        "MetricGroup": "Cache_Misses;Offcore",
         "MetricName": "L2MPKI_All"
     },
     {
@@ -298,7 +305,7 @@
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
+        "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
@@ -310,62 +317,74 @@
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
-        "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 )",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "BriefDescription": "Fraction of cycles spent in the Operating System (OS) Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Summary",
+        "MetricGroup": "OS",
         "MetricName": "Kernel_Utilization"
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
         "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
-        "MetricGroup": "Memory_BW",
+        "MetricGroup": "Memory_BW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
     {
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x35\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
-        "MetricGroup": "Memory_Lat",
-        "MetricName": "DRAM_Read_Latency"
+        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\,umask\\=0x21\\,config\\=0x40433@ / cha@event\\=0x35\\,umask\\=0x21\\,config\\=0x40433@ ) / ( cha_0@event\\=0x0@ / duration_time )",
+        "MetricGroup": "Memory_Lat;SoC",
+        "MetricName": "MEM_Read_Latency"
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x36\\,umask\\=0x21\\,thresh\\=1@",
-        "MetricGroup": "Memory_BW",
-        "MetricName": "DRAM_Parallel_Reads"
+        "MetricExpr": "cha@event\\=0x36\\,umask\\=0x21\\,config\\=0x40433@ / cha@event\\=0x36\\,umask\\=0x21\\,config\\=0x40433\\,thresh\\=1@",
+        "MetricGroup": "Memory_BW;SoC",
+        "MetricName": "MEM_Parallel_Reads"
     },
     {
         "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
         "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ )",
-        "MetricGroup": "Memory_Lat",
+        "MetricGroup": "Memory_Lat;SoC;Server",
         "MetricName": "MEM_PMM_Read_Latency"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
         "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time )",
-        "MetricGroup": "Memory_BW",
+        "MetricGroup": "Memory_BW;SoC;Server",
         "MetricName": "PMM_Read_BW"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
         "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time )",
-        "MetricGroup": "Memory_BW",
+        "MetricGroup": "Memory_BW;SoC;Server",
         "MetricName": "PMM_Write_BW"
     },
+    {
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use for Writes [GB / sec]",
+        "MetricExpr": "( UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3 ) * 4 / 1000000000 / duration_time",
+        "MetricGroup": "IO_BW;SoC;Server",
+        "MetricName": "IO_Write_BW"
+    },
+    {
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use for Reads [GB / sec]",
+        "MetricExpr": "( UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3 ) * 4 / 1000000000 / duration_time",
+        "MetricGroup": "IO_BW;SoC;Server",
+        "MetricName": "IO_Read_BW"
+    },
     {
         "BriefDescription": "Socket actual clocks when any core is active on that socket",
         "MetricExpr": "cha_0@event\\=0x0@",
-        "MetricGroup": "",
+        "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
     {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions. )",
+        "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / ( BR_INST_RETIRED.FAR_BRANCH / 2 )",
-        "MetricGroup": "",
+        "MetricGroup": "Branches;OS",
         "MetricName": "IpFarBranch"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json b/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
index 3553472ad266..0716b2e3ff75 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
@@ -246,6 +246,30 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
+    {
+        "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xAB",
+        "EventName": "DSB2MITE_SWITCHES.COUNT",
+        "PublicDescription": "This event counts the number of the Decode Stream Buffer (DSB)-to-MITE switches including all misses because of missing Decode Stream Buffer (DSB) cache and u-arch forced misses.\nNote: Invoking MITE requires two or three cycles delay.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvation of at least 1 cycle",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x400106",
+        "PEBS": "2",
+        "PublicDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of at least 1 cycle which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Instruction fetch tag lookups that miss in the instruction cache (L1I). Counts at 64-byte cache-line granularity.",
         "Counter": "0,1,2,3",
@@ -359,6 +383,16 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x24"
     },
+    {
+        "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xE6",
+        "EventName": "BACLEARS.ANY",
+        "PublicDescription": "Counts the number of times the front-end is resteered when it finds a branch instruction in a fetch line. This occurs for the first time a branch instruction is fetched or when the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 16 cycles which was not interrupted by a back-end stall.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json b/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
index cc66a51c6a7b..0c07cb4fbf58 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "ALL_READS & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_READS.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -13,7 +13,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_DATA_RD.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -26,7 +26,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -81,7 +81,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -177,7 +177,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -218,7 +218,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -245,7 +245,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -286,7 +286,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -313,7 +313,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -350,7 +350,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -405,7 +405,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS.ANY_SNOOP OCR.PF_L1D_AND_SW.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -432,7 +432,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -473,7 +473,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -513,7 +513,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS.ANY_SNOOP OCR.ALL_PF_RFO.L3_MISS.ANY_SNOOP OCR.ALL_PF_RFO.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -540,7 +540,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS.HIT_OTHER_CORE_FWD OCR.PF_L2_RFO.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -678,7 +678,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -705,7 +705,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -779,7 +779,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -792,7 +792,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -847,7 +847,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_RFO.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_RFO.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -874,7 +874,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -950,7 +950,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -977,7 +977,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1045,7 +1045,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS.REMOTE_HIT_FORWARD OCR.ALL_PF_DATA_RD.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1058,7 +1058,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_RFO.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1071,7 +1071,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1084,7 +1084,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.PF_L2_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1097,7 +1097,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1258,7 +1258,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1285,7 +1285,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP  OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1298,7 +1298,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1339,7 +1339,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_READS.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1380,7 +1380,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD OCR.PF_L2_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1393,7 +1393,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1406,7 +1406,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1419,7 +1419,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS.REMOTE_HITM OCR.ALL_PF_DATA_RD.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1432,7 +1432,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1445,7 +1445,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1513,7 +1513,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS.NO_SNOOP_NEEDED OCR.PF_L1D_AND_SW.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1540,7 +1540,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1619,7 +1619,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1632,7 +1632,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1645,7 +1645,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1672,7 +1672,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS.HITM_OTHER_CORE OCR.PF_L2_DATA_RD.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1699,7 +1699,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS.HITM_OTHER_CORE OCR.ALL_PF_DATA_RD.L3_MISS.HITM_OTHER_CORE OCR.ALL_PF_DATA_RD.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1712,7 +1712,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1725,7 +1725,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS.NO_SNOOP_NEEDED OCR.DEMAND_RFO.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1738,7 +1738,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1765,7 +1765,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS.SNOOP_MISS OCR.ALL_READS.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1806,7 +1806,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_READS.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_READS.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1833,7 +1833,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1874,7 +1874,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1887,7 +1887,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1942,7 +1942,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1969,7 +1969,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED  OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1982,7 +1982,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1995,7 +1995,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2008,7 +2008,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2021,7 +2021,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE  OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2048,7 +2048,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2089,7 +2089,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_LOCAL_DRAM.ANY_SNOOP  OCR.ALL_READS.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2144,7 +2144,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS.ANY_SNOOP OCR.ALL_PF_DATA_RD.L3_MISS.ANY_SNOOP OCR.ALL_PF_DATA_RD.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2185,7 +2185,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE  OCR.ALL_READS.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2212,7 +2212,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2225,7 +2225,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2241,7 +2241,8 @@
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 128 cycles.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "EventCode": "0xCD",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
@@ -2290,7 +2291,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2345,7 +2346,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2386,7 +2387,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.ANY_SNOOP  OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2399,7 +2400,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_PF_DATA_RD.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_PF_DATA_RD.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2426,7 +2427,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2439,7 +2440,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS.HIT_OTHER_CORE_FWD OCR.DEMAND_RFO.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2452,7 +2453,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS.ANY_SNOOP OCR.ALL_DATA_RD.L3_MISS.ANY_SNOOP OCR.ALL_DATA_RD.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2493,7 +2494,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2520,7 +2521,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_PF_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_PF_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2547,7 +2548,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2560,7 +2561,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2586,7 +2587,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED  OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2599,7 +2600,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS.SNOOP_MISS OCR.ALL_PF_DATA_RD.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2612,7 +2613,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP  OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2653,7 +2654,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2694,7 +2695,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2707,7 +2708,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS.ANY_SNOOP OCR.DEMAND_DATA_RD.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2730,7 +2731,7 @@
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE  OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2743,7 +2744,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.ANY_SNOOP  OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2756,7 +2757,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2769,7 +2770,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2782,7 +2783,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2809,7 +2810,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2822,7 +2823,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_LOCAL_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2835,7 +2836,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2848,7 +2849,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2875,7 +2876,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS.REMOTE_HIT_FORWARD OCR.ALL_RFO.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2902,7 +2903,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_READS.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2915,7 +2916,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2928,7 +2929,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS.NO_SNOOP_NEEDED OCR.PF_L2_DATA_RD.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2941,7 +2942,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2954,7 +2955,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2981,7 +2982,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED  OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3050,7 +3051,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3104,7 +3105,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS.HITM_OTHER_CORE OCR.PF_L3_RFO.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3117,7 +3118,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3195,7 +3196,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3222,7 +3223,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_PF_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_PF_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3235,7 +3236,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3290,7 +3291,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3373,7 +3374,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3413,7 +3414,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3426,7 +3427,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3481,7 +3482,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.DEMAND_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3522,7 +3523,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE  OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3535,7 +3536,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3548,7 +3549,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3561,7 +3562,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3588,7 +3589,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3601,7 +3602,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP  OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3614,7 +3615,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE  OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3778,7 +3779,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3791,7 +3792,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3804,7 +3805,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3859,7 +3860,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3886,7 +3887,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3899,7 +3900,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3925,7 +3926,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS.NO_SNOOP_NEEDED OCR.PF_L2_RFO.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3938,7 +3939,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3979,7 +3980,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS.NO_SNOOP_NEEDED OCR.PF_L3_RFO.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4044,7 +4045,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS.SNOOP_MISS OCR.ALL_PF_RFO.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4071,7 +4072,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS.HITM_OTHER_CORE OCR.PF_L3_DATA_RD.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4111,7 +4112,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4138,7 +4139,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED  OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4151,7 +4152,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS.ANY_SNOOP OCR.DEMAND_CODE_RD.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4164,7 +4165,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS.ANY_SNOOP OCR.ALL_READS.L3_MISS.ANY_SNOOP OCR.ALL_READS.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4205,7 +4206,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4243,7 +4244,7 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4284,7 +4285,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4297,7 +4298,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4310,7 +4311,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4323,7 +4324,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4336,7 +4337,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4363,7 +4364,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS.ANY_SNOOP OCR.PF_L3_DATA_RD.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4390,7 +4391,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4503,7 +4504,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4529,7 +4530,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE  OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4556,7 +4557,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4569,7 +4570,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD OCR.DEMAND_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4582,7 +4583,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4623,7 +4624,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS.HITM_OTHER_CORE OCR.PF_L2_RFO.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4636,7 +4637,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4649,7 +4650,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_READS.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_READS.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4662,7 +4663,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4685,7 +4686,7 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4698,7 +4699,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS.SNOOP_NONE OCR.ALL_PF_RFO.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4711,7 +4712,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.DEMAND_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4724,7 +4725,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS.SNOOP_MISS OCR.ALL_RFO.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4765,7 +4766,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4802,7 +4803,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4828,7 +4829,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS.HITM_OTHER_CORE OCR.DEMAND_DATA_RD.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4841,7 +4842,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4909,7 +4910,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4950,7 +4951,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4977,7 +4978,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS.REMOTE_HIT_FORWARD OCR.ALL_READS.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4990,21 +4991,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0110000001",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "ALL_RFO & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_RFO.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_RFO.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5017,7 +5004,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS.HIT_OTHER_CORE_FWD OCR.PF_L3_RFO.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5030,7 +5017,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5043,7 +5030,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_PF_RFO.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_PF_RFO.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5070,7 +5057,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS.REMOTE_HITM OCR.ALL_READS.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5097,7 +5084,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS.ANY_SNOOP OCR.PF_L3_RFO.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5152,7 +5139,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5188,7 +5175,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS.REMOTE_HITM OCR.ALL_RFO.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5201,7 +5188,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5214,7 +5201,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5227,7 +5214,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5240,7 +5227,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5253,7 +5240,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5266,7 +5253,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5335,7 +5322,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5390,7 +5377,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5403,7 +5390,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5419,7 +5406,8 @@
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 32 cycles.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "EventCode": "0xCD",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
@@ -5444,7 +5432,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED  OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5457,7 +5445,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5470,7 +5458,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5510,7 +5498,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5523,7 +5511,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5536,7 +5524,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5549,7 +5537,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5585,7 +5573,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS.SNOOP_NONE OCR.ALL_RFO.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5598,7 +5586,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_PF_RFO.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5667,7 +5655,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5708,7 +5696,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.OTHER.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5747,7 +5735,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5760,7 +5748,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS.SNOOP_NONE OCR.ALL_READS.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5829,7 +5817,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5870,7 +5858,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5925,7 +5913,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5938,7 +5926,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5951,7 +5939,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5964,7 +5952,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5977,7 +5965,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS.SNOOP_MISS OCR.ALL_DATA_RD.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6004,7 +5992,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_PF_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_PF_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6017,7 +6005,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6030,7 +6018,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6099,7 +6087,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6181,7 +6169,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS.HITM_OTHER_CORE OCR.ALL_PF_RFO.L3_MISS.HITM_OTHER_CORE OCR.ALL_PF_RFO.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6222,7 +6210,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6235,7 +6223,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS.ANY_SNOOP OCR.PF_L2_RFO.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6262,7 +6250,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6359,7 +6347,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP  OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6400,7 +6388,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6413,7 +6401,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6426,7 +6414,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6439,7 +6427,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED  OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6452,7 +6440,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS.HITM_OTHER_CORE OCR.OTHER.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6496,7 +6484,8 @@
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 256 cycles.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "EventCode": "0xCD",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
@@ -6592,7 +6581,8 @@
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 16 cycles.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "EventCode": "0xCD",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
@@ -6640,7 +6630,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6694,7 +6684,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6707,7 +6697,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6763,7 +6753,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6776,7 +6766,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6789,7 +6779,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6816,7 +6806,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6843,7 +6833,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE  OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6873,7 +6863,8 @@
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 512 cycles.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "EventCode": "0xCD",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
@@ -6893,7 +6884,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6962,7 +6953,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6975,7 +6966,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7016,7 +7007,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS.NO_SNOOP_NEEDED OCR.DEMAND_CODE_RD.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7029,7 +7020,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS.HITM_OTHER_CORE OCR.PF_L1D_AND_SW.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7070,7 +7061,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7083,7 +7074,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS.NO_SNOOP_NEEDED OCR.DEMAND_DATA_RD.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7096,7 +7087,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7123,7 +7114,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7136,7 +7127,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS.ANY_SNOOP OCR.ALL_RFO.L3_MISS.ANY_SNOOP OCR.ALL_RFO.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7149,7 +7140,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP  OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7204,7 +7195,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS.HIT_OTHER_CORE_FWD OCR.DEMAND_CODE_RD.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7217,7 +7208,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7243,7 +7234,8 @@
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 64 cycles.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "EventCode": "0xCD",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
@@ -7254,7 +7246,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS.HITM_OTHER_CORE OCR.ALL_RFO.L3_MISS.HITM_OTHER_CORE OCR.ALL_RFO.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7295,7 +7287,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS.SNOOP_NONE OCR.ALL_PF_DATA_RD.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7336,7 +7328,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS.NO_SNOOP_NEEDED OCR.OTHER.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7405,7 +7397,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7418,7 +7410,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS.ANY_SNOOP OCR.OTHER.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7431,7 +7423,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7444,7 +7436,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.ALL_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7457,7 +7449,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7470,7 +7462,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD OCR.PF_L3_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7483,7 +7475,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7524,7 +7516,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS.REMOTE_HIT_FORWARD OCR.ALL_PF_RFO.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7551,7 +7543,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE  OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7564,7 +7556,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7577,7 +7569,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.PF_L3_RFO.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7604,7 +7596,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7617,7 +7609,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS.HITM_OTHER_CORE OCR.DEMAND_RFO.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7658,7 +7650,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7681,7 +7673,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7708,7 +7700,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7735,7 +7727,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.PF_L3_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7762,7 +7754,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7789,7 +7781,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7802,7 +7794,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS.SNOOP_NONE OCR.ALL_DATA_RD.L3_MISS.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7815,7 +7807,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_DATA_RD.L3_MISS.NO_SNOOP_NEEDED OCR.ALL_DATA_RD.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7828,7 +7820,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.ANY_SNOOP  OCR.ALL_RFO.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7841,7 +7833,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7854,7 +7846,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7895,7 +7887,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS.HITM_OTHER_CORE OCR.ALL_DATA_RD.L3_MISS.HITM_OTHER_CORE OCR.ALL_DATA_RD.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7922,7 +7914,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7949,7 +7941,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED  OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7975,19 +7967,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0810000001",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event OCR.PF_L2_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
@@ -8003,7 +7982,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8026,7 +8005,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS_LOCAL_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS_LOCAL_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8039,7 +8018,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE  OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8070,7 +8049,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS.ANY_SNOOP OCR.DEMAND_RFO.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8083,7 +8062,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8236,7 +8215,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED  OCR.ALL_READS.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8249,7 +8228,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.DEMAND_CODE_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8262,7 +8241,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS_REMOTE_DRAM & SNOOP_MISS_OR_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS_REMOTE_DRAM.SNOOP_MISS_OR_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8289,7 +8268,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8344,7 +8323,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS.REMOTE_HITM OCR.ALL_DATA_RD.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8357,7 +8336,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8426,7 +8405,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8439,7 +8418,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8452,7 +8431,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8520,7 +8499,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8630,7 +8609,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_MISS & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_MISS.NO_SNOOP_NEEDED OCR.PF_L3_DATA_RD.L3_MISS.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8713,7 +8692,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8726,7 +8705,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8766,7 +8745,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & REMOTE_HIT_FORWARD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS.REMOTE_HIT_FORWARD OCR.ALL_DATA_RD.L3_MISS.REMOTE_HIT_FORWARD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8803,7 +8782,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED  OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8816,7 +8795,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8857,7 +8836,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8968,7 +8947,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.PF_L1D_AND_SW.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8981,7 +8960,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_MISS.HITM_OTHER_CORE OCR.DEMAND_CODE_RD.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8994,7 +8973,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE  OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9021,7 +9000,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9047,7 +9026,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED  OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9060,7 +9039,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_READS.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9073,7 +9052,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_LOCAL_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_LOCAL_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9168,6 +9147,19 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x0810000001",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Number of times an HLE execution aborted due to any reasons (multiple categories may count as one).",
         "Counter": "0,1,2,3",
@@ -9261,7 +9253,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_DATA_RD.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9316,7 +9308,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD  OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9329,7 +9321,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.ANY_SNOOP  OCR.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9356,7 +9348,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS.ANY_SNOOP OCR.PF_L2_DATA_RD.L3_MISS.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9383,7 +9375,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9424,7 +9416,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9465,7 +9457,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9506,7 +9498,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_MISS & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD OCR.PF_L2_DATA_RD.L3_MISS.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9533,7 +9525,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_LOCAL_DRAM & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_LOCAL_DRAM.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9546,7 +9538,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_MISS_REMOTE_HOP1_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9601,7 +9593,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9614,7 +9606,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_MISS.HIT_OTHER_CORE_FWD OCR.PF_L1D_AND_SW.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9641,7 +9633,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9678,7 +9670,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9705,7 +9697,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_REMOTE_HOP1_DRAM & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD  OCR.ALL_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9718,7 +9710,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_PF_RFO.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_PF_RFO.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9745,7 +9737,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS.HITM_OTHER_CORE OCR.ALL_READS.L3_MISS.HITM_OTHER_CORE OCR.ALL_READS.L3_MISS.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9772,7 +9764,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_MISS_REMOTE_HOP1_DRAM & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_MISS_REMOTE_HOP1_DRAM.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9785,7 +9777,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_MISS.HIT_OTHER_CORE_FWD OCR.OTHER.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9812,7 +9804,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & REMOTE_HITM",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_MISS.REMOTE_HITM OCR.ALL_PF_RFO.L3_MISS.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9839,7 +9831,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS_LOCAL_DRAM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9855,7 +9847,8 @@
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 4 cycles.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "EventCode": "0xCD",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
@@ -9883,7 +9876,8 @@
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 8 cycles.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "EventCode": "0xCD",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
@@ -9894,7 +9888,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_MISS & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_READS.L3_MISS.HIT_OTHER_CORE_FWD OCR.ALL_READS.L3_MISS.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -9905,5 +9899,19 @@
         "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_REMOTE_HOP1_DRAM.NO_SNOOP_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x0110000001",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json b/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
index 05d13d53c374..f77d78e90954 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -13,7 +13,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_S.HITM_OTHER_CORE  OCR.ALL_PF_RFO.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -26,7 +26,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_F.NO_SNOOP_NEEDED  OCR.ALL_READS.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -39,7 +39,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT & SNOOP_HIT_WITH_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -52,7 +52,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_RFO.SUPPLIER_NONE.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -65,7 +65,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_M.HIT_OTHER_CORE_FWD  OCR.ALL_READS.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -78,7 +78,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -104,7 +104,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -117,7 +117,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_S.NO_SNOOP_NEEDED  OCR.ALL_RFO.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -130,7 +130,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -143,7 +143,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -156,7 +156,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -169,7 +169,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_S.HIT_OTHER_CORE_FWD  OCR.ALL_PF_RFO.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -182,7 +182,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -195,7 +195,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT.ANY_SNOOP OCR.ALL_PF_RFO.L3_HIT.ANY_SNOOP OCR.ALL_PF_RFO.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -208,7 +208,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_S.HITM_OTHER_CORE  OCR.ALL_DATA_RD.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -221,7 +221,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_S.ANY_SNOOP  OCR.ALL_PF_RFO.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -234,7 +234,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -247,7 +247,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -260,7 +260,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -273,7 +273,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -299,7 +299,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -312,7 +312,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -325,7 +325,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_M.NO_SNOOP_NEEDED  OCR.ALL_READS.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -338,7 +338,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -351,7 +351,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_HIT.HIT_OTHER_CORE_FWD OCR.PF_L2_RFO.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -364,7 +364,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_E.HITM_OTHER_CORE  OCR.ALL_PF_RFO.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -377,7 +377,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT.HITM_OTHER_CORE OCR.ALL_PF_DATA_RD.L3_HIT.HITM_OTHER_CORE OCR.ALL_PF_DATA_RD.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -390,7 +390,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.SUPPLIER_NONE.NO_SNOOP_NEEDED  OCR.ALL_RFO.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -403,7 +403,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_F.HITM_OTHER_CORE  OCR.ALL_DATA_RD.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -416,7 +416,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests OCR.OTHER.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -429,7 +429,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.HITM_OTHER_CORE  OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -442,7 +442,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.PMM_HIT_LOCAL_PMM.ANY_SNOOP OCR.ALL_READS.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -478,7 +478,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_HIT.HITM_OTHER_CORE OCR.DEMAND_CODE_RD.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -491,7 +491,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_E.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_RFO.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -517,7 +517,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -530,7 +530,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -543,7 +543,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.OTHER.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -556,7 +556,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.PMM_HIT_LOCAL_PMM.ANY_SNOOP OCR.ALL_DATA_RD.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -582,7 +582,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -595,7 +595,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_F & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_F.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -621,7 +621,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -634,7 +634,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -660,7 +660,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_E.HIT_OTHER_CORE_FWD  OCR.ALL_PF_RFO.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -673,7 +673,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_S.HIT_OTHER_CORE_NO_FWD  OCR.ALL_RFO.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -699,7 +699,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_FWD  OCR.ALL_PF_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -712,7 +712,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -738,7 +738,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -751,7 +751,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT.SNOOP_MISS OCR.ALL_RFO.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -764,7 +764,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -777,7 +777,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -790,7 +790,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_F.HITM_OTHER_CORE  OCR.ALL_RFO.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -803,7 +803,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -816,7 +816,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -829,7 +829,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -842,7 +842,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -855,7 +855,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -868,7 +868,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_M & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_M.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -881,7 +881,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT.HITM_OTHER_CORE OCR.ALL_RFO.L3_HIT.HITM_OTHER_CORE OCR.ALL_RFO.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -894,7 +894,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -946,7 +946,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -985,7 +985,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -998,7 +998,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1011,7 +1011,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_E.HIT_OTHER_CORE_FWD  OCR.ALL_READS.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1024,7 +1024,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_F.HIT_OTHER_CORE_NO_FWD  OCR.ALL_RFO.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1050,7 +1050,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1063,7 +1063,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1076,7 +1076,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1089,7 +1089,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_HIT.HITM_OTHER_CORE OCR.PF_L3_RFO.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1102,7 +1102,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1115,7 +1115,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1128,7 +1128,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1141,7 +1141,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_E.NO_SNOOP_NEEDED  OCR.ALL_DATA_RD.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1167,7 +1167,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1180,7 +1180,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_HIT.ANY_SNOOP OCR.DEMAND_RFO.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1193,7 +1193,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD  OCR.ALL_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1206,7 +1206,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1219,7 +1219,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_FWD  OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1232,7 +1232,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_RFO.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_RFO.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1245,7 +1245,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1258,7 +1258,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1297,7 +1297,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1310,7 +1310,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & ANY_RESPONSE have any response type.",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.ANY_RESPONSE have any response type.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1323,7 +1323,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1336,7 +1336,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT.SNOOP_MISS OCR.ALL_PF_RFO.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1349,7 +1349,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1362,7 +1362,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1388,7 +1388,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_S & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_S.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1401,7 +1401,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_M.ANY_SNOOP  OCR.ALL_RFO.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1414,7 +1414,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1427,7 +1427,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1440,7 +1440,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_E.ANY_SNOOP  OCR.ALL_READS.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1453,7 +1453,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1466,7 +1466,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1479,7 +1479,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_F.HITM_OTHER_CORE  OCR.ALL_PF_DATA_RD.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1492,7 +1492,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_READS.SUPPLIER_NONE.HIT_OTHER_CORE_FWD  OCR.ALL_READS.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1505,7 +1505,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD  OCR.ALL_READS.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1518,7 +1518,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_E & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_E.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1531,7 +1531,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_NO_FWD  OCR.ALL_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1544,7 +1544,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_E.NO_SNOOP_NEEDED  OCR.ALL_PF_RFO.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1557,7 +1557,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_E.HIT_OTHER_CORE_FWD  OCR.ALL_RFO.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1570,7 +1570,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_F.ANY_SNOOP  OCR.ALL_DATA_RD.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1583,7 +1583,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1596,7 +1596,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1609,7 +1609,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1622,7 +1622,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1635,7 +1635,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_M.HITM_OTHER_CORE  OCR.ALL_RFO.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1661,7 +1661,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & ANY_RESPONSE have any response type.",
+        "BriefDescription": "OCR.ALL_RFO.ANY_RESPONSE have any response type.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1726,7 +1726,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1739,7 +1739,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD OCR.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1752,7 +1752,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_HIT.ANY_SNOOP OCR.PF_L2_RFO.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1765,7 +1765,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1778,7 +1778,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1791,7 +1791,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1804,7 +1804,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1817,7 +1817,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT.SNOOP_MISS OCR.ALL_READS.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1830,7 +1830,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1843,7 +1843,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1856,7 +1856,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1908,7 +1908,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1921,7 +1921,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1934,7 +1934,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_F.ANY_SNOOP  OCR.ALL_PF_DATA_RD.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1947,7 +1947,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_M.HIT_OTHER_CORE_FWD  OCR.ALL_PF_RFO.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1960,7 +1960,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.SUPPLIER_NONE.ANY_SNOOP  OCR.ALL_READS.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1973,7 +1973,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1986,7 +1986,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1999,7 +1999,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_S.NO_SNOOP_NEEDED  OCR.ALL_DATA_RD.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2012,7 +2012,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2025,7 +2025,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_M.HIT_OTHER_CORE_NO_FWD  OCR.ALL_RFO.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2038,7 +2038,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.SUPPLIER_NONE.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2051,7 +2051,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_FWD  OCR.ALL_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2077,7 +2077,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NONE OCR.ALL_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2090,7 +2090,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2103,7 +2103,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_E & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_E.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2116,7 +2116,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2129,7 +2129,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_M & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_M.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2142,7 +2142,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.PMM_HIT_LOCAL_PMM.ANY_SNOOP OCR.ALL_RFO.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2155,7 +2155,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_M.HIT_OTHER_CORE_FWD  OCR.ALL_RFO.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2168,7 +2168,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2194,7 +2194,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2207,7 +2207,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2220,7 +2220,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_PF_RFO.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_PF_RFO.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2233,7 +2233,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2246,7 +2246,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2259,7 +2259,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2272,7 +2272,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2285,7 +2285,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2337,7 +2337,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_F & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_F.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2350,7 +2350,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_M.ANY_SNOOP  OCR.ALL_PF_DATA_RD.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2363,7 +2363,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2376,7 +2376,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_HIT.HIT_OTHER_CORE_FWD OCR.DEMAND_CODE_RD.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2389,7 +2389,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2402,7 +2402,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2428,7 +2428,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_F.HIT_OTHER_CORE_FWD  OCR.ALL_RFO.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2441,7 +2441,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_E.HIT_OTHER_CORE_NO_FWD  OCR.ALL_RFO.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2454,7 +2454,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2490,7 +2490,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NONE OCR.ALL_PF_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2503,7 +2503,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2516,7 +2516,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2529,7 +2529,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.SUPPLIER_NONE.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2542,7 +2542,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2555,7 +2555,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2568,7 +2568,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_S.ANY_SNOOP  OCR.ALL_DATA_RD.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2581,7 +2581,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_F.HIT_OTHER_CORE_FWD  OCR.ALL_READS.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2594,7 +2594,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_F & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_F.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2607,7 +2607,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2620,7 +2620,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & ANY_RESPONSE have any response type.",
+        "BriefDescription": "OCR.ALL_PF_RFO.ANY_RESPONSE have any response type.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2633,7 +2633,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2646,7 +2646,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2659,7 +2659,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2672,7 +2672,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2685,7 +2685,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_M & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_M.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2698,7 +2698,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2711,7 +2711,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2724,7 +2724,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2747,7 +2747,7 @@
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE OCR.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2773,7 +2773,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2799,7 +2799,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2812,7 +2812,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_M & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_M.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2825,7 +2825,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2838,7 +2838,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2851,7 +2851,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads hit in the L3 and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_HIT.NO_SNOOP_NEEDED OCR.DEMAND_DATA_RD.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2877,7 +2877,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2890,7 +2890,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_FWD  OCR.ALL_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2916,7 +2916,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2929,7 +2929,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2942,7 +2942,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2955,7 +2955,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2968,7 +2968,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -2994,7 +2994,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_PF_RFO.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_PF_RFO.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3020,7 +3020,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3046,7 +3046,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3059,7 +3059,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3072,7 +3072,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3085,7 +3085,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3098,7 +3098,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_M.NO_SNOOP_NEEDED  OCR.ALL_PF_RFO.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3111,7 +3111,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_E & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_E.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3124,7 +3124,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3137,7 +3137,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & ANY_RESPONSE have any response type.",
+        "BriefDescription": "OCR.ALL_DATA_RD.ANY_RESPONSE have any response type.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3150,7 +3150,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3163,7 +3163,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_S & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_S.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3189,7 +3189,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3202,7 +3202,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NONE OCR.ALL_PF_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3215,7 +3215,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3241,7 +3241,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_F & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_F.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3254,7 +3254,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3267,7 +3267,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_E.ANY_SNOOP  OCR.ALL_PF_RFO.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3280,7 +3280,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_HIT.HIT_OTHER_CORE_FWD OCR.OTHER.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3306,7 +3306,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_FWD  OCR.ALL_PF_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3319,7 +3319,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3332,7 +3332,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_E.HITM_OTHER_CORE  OCR.ALL_PF_DATA_RD.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3345,7 +3345,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3358,7 +3358,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3371,7 +3371,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3384,7 +3384,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3397,7 +3397,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3423,7 +3423,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_DATA_RD.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_DATA_RD.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3436,7 +3436,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_READS.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_READS.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3449,7 +3449,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3462,7 +3462,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NONE OCR.ALL_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3475,7 +3475,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3488,7 +3488,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3501,7 +3501,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_PF_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_PF_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3514,7 +3514,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT.HITM_OTHER_CORE OCR.ALL_DATA_RD.L3_HIT.HITM_OTHER_CORE OCR.ALL_DATA_RD.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3527,7 +3527,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3540,7 +3540,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3553,7 +3553,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3566,7 +3566,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3579,7 +3579,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3592,7 +3592,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3605,7 +3605,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3618,7 +3618,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_E.ANY_SNOOP  OCR.ALL_DATA_RD.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3631,7 +3631,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3644,7 +3644,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_F.HITM_OTHER_CORE  OCR.ALL_READS.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3657,7 +3657,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.PF_L1D_AND_SW.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3670,7 +3670,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT.HITM_OTHER_CORE OCR.ALL_PF_RFO.L3_HIT.HITM_OTHER_CORE OCR.ALL_PF_RFO.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3696,7 +3696,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_HIT.HIT_OTHER_CORE_FWD OCR.PF_L3_RFO.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3709,7 +3709,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3735,7 +3735,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3748,7 +3748,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_M.HITM_OTHER_CORE  OCR.ALL_DATA_RD.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3771,7 +3771,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3797,7 +3797,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3810,7 +3810,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT & SNOOP_HIT_WITH_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3823,7 +3823,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_M.NO_SNOOP_NEEDED  OCR.ALL_PF_DATA_RD.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3836,7 +3836,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3849,7 +3849,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_F & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_F.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3875,7 +3875,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_F.NO_SNOOP_NEEDED  OCR.ALL_PF_RFO.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3888,7 +3888,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3914,7 +3914,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.PF_L2_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3927,7 +3927,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3940,7 +3940,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3953,7 +3953,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3966,7 +3966,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT.HITM_OTHER_CORE OCR.ALL_READS.L3_HIT.HITM_OTHER_CORE OCR.ALL_READS.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3979,7 +3979,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -3992,7 +3992,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4005,7 +4005,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_READS.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_READS.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4018,7 +4018,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_F.NO_SNOOP_NEEDED  OCR.ALL_PF_DATA_RD.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4031,7 +4031,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4044,7 +4044,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4057,7 +4057,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "Counts any other requests OCR.OTHER.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4070,7 +4070,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_S.HIT_OTHER_CORE_FWD  OCR.ALL_READS.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4092,7 +4092,7 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4118,7 +4118,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4131,7 +4131,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4144,7 +4144,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_FWD  OCR.ALL_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4157,7 +4157,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4170,7 +4170,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_F & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_F.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4196,7 +4196,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4209,7 +4209,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_PF_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_PF_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4235,7 +4235,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.ANY_SNOOP  OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4248,7 +4248,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4261,7 +4261,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_RFO.SUPPLIER_NONE.HITM_OTHER_CORE  OCR.ALL_RFO.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4274,7 +4274,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.PF_L2_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4287,7 +4287,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_F.ANY_SNOOP  OCR.ALL_RFO.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4300,7 +4300,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_S.HITM_OTHER_CORE  OCR.ALL_PF_DATA_RD.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4313,7 +4313,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_S.ANY_SNOOP  OCR.ALL_RFO.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4326,7 +4326,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts any other requests OCR.OTHER.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4339,7 +4339,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4352,7 +4352,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) hit in the L3 and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_HIT.NO_SNOOP_NEEDED OCR.DEMAND_RFO.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4365,7 +4365,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_S.HIT_OTHER_CORE_NO_FWD  OCR.ALL_READS.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4378,7 +4378,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4391,7 +4391,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_S.ANY_SNOOP  OCR.ALL_PF_DATA_RD.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4404,7 +4404,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4417,7 +4417,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_E.HITM_OTHER_CORE  OCR.ALL_DATA_RD.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4430,7 +4430,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_E.NO_SNOOP_NEEDED  OCR.ALL_READS.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4443,7 +4443,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4469,7 +4469,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4495,7 +4495,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4521,7 +4521,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_S.NO_SNOOP_NEEDED  OCR.ALL_PF_RFO.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4534,7 +4534,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4560,7 +4560,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD  OCR.ALL_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4573,7 +4573,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4586,7 +4586,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT.ANY_SNOOP OCR.ALL_READS.L3_HIT.ANY_SNOOP OCR.ALL_READS.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4599,7 +4599,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.PMM_HIT_LOCAL_PMM.SNOOP_NONE OCR.ALL_READS.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4612,7 +4612,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4625,7 +4625,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT.ANY_SNOOP OCR.ALL_PF_DATA_RD.L3_HIT.ANY_SNOOP OCR.ALL_PF_DATA_RD.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4638,7 +4638,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4651,7 +4651,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE OCR.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4677,7 +4677,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT & SNOOP_HIT_WITH_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT.SNOOP_HIT_WITH_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4690,7 +4690,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4716,7 +4716,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT.SNOOP_NONE OCR.ALL_READS.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4729,7 +4729,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4742,7 +4742,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.NO_SNOOP_NEEDED  OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4755,7 +4755,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4768,7 +4768,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_PF_DATA_RD.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_PF_DATA_RD.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4781,7 +4781,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4794,7 +4794,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_S.NO_SNOOP_NEEDED  OCR.ALL_READS.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4807,7 +4807,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_S.HITM_OTHER_CORE  OCR.ALL_RFO.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4820,7 +4820,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT & SNOOP_HIT_WITH_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4833,7 +4833,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_M.ANY_SNOOP  OCR.ALL_READS.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4846,7 +4846,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_READS.L3_HIT.NO_SNOOP_NEEDED OCR.ALL_READS.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4859,7 +4859,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & ANY_RESPONSE have any response type.",
+        "BriefDescription": "OCR.ALL_READS.ANY_RESPONSE have any response type.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4872,7 +4872,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4885,7 +4885,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_M.NO_SNOOP_NEEDED  OCR.ALL_DATA_RD.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4898,7 +4898,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4911,7 +4911,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4924,7 +4924,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT.ANY_SNOOP OCR.ALL_DATA_RD.L3_HIT.ANY_SNOOP OCR.ALL_DATA_RD.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4937,7 +4937,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4950,7 +4950,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4963,7 +4963,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -4976,7 +4976,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5015,7 +5015,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.PMM_HIT_LOCAL_PMM.ANY_SNOOP OCR.ALL_PF_RFO.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5041,7 +5041,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT.SNOOP_MISS OCR.ALL_PF_DATA_RD.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5054,7 +5054,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5067,7 +5067,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5080,7 +5080,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_E & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_E.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5093,7 +5093,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5106,7 +5106,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_S.HITM_OTHER_CORE  OCR.ALL_READS.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5119,7 +5119,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_F.ANY_SNOOP  OCR.ALL_READS.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5132,7 +5132,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_M.HIT_OTHER_CORE_NO_FWD  OCR.ALL_READS.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5145,7 +5145,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_S & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_S.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5158,7 +5158,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5171,7 +5171,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_E & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_E.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5184,7 +5184,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5197,7 +5197,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5210,7 +5210,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_E.HIT_OTHER_CORE_NO_FWD  OCR.ALL_READS.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5236,7 +5236,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_S & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_S.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5249,7 +5249,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5262,7 +5262,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_HIT.ANY_SNOOP OCR.PF_L3_DATA_RD.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5275,7 +5275,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT.SNOOP_NONE OCR.ALL_RFO.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5288,7 +5288,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_M & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_M.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5301,7 +5301,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.DEMAND_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5314,7 +5314,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5327,7 +5327,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_M.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_RFO.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5340,7 +5340,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_E & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_E.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5353,7 +5353,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5366,7 +5366,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_READS.SUPPLIER_NONE.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5379,7 +5379,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5401,7 +5401,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_RFO.L3_HIT.HIT_OTHER_CORE_FWD OCR.ALL_RFO.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5414,7 +5414,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5427,7 +5427,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_NO_FWD  OCR.ALL_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5440,7 +5440,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_M & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_M.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5476,7 +5476,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_HIT.HITM_OTHER_CORE OCR.PF_L1D_AND_SW.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5489,7 +5489,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs hit in the L3 and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_HIT.NO_SNOOP_NEEDED OCR.PF_L2_RFO.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5502,7 +5502,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5515,7 +5515,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_F.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_RFO.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5528,7 +5528,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5541,7 +5541,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5554,7 +5554,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5567,7 +5567,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5580,7 +5580,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_F & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_F.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5593,7 +5593,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.DEMAND_CODE_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5606,7 +5606,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5619,7 +5619,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5645,7 +5645,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.SUPPLIER_NONE.NO_SNOOP_NEEDED  OCR.ALL_READS.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5658,7 +5658,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_F & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_F.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5671,7 +5671,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5684,7 +5684,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_F & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_F.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5697,7 +5697,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_HIT.ANY_SNOOP OCR.PF_L1D_AND_SW.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5710,7 +5710,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_HIT.HITM_OTHER_CORE OCR.PF_L3_DATA_RD.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5723,7 +5723,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5736,7 +5736,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5749,7 +5749,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_M.HITM_OTHER_CORE  OCR.ALL_PF_RFO.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5762,7 +5762,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5775,7 +5775,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_HIT.HIT_OTHER_CORE_FWD OCR.DEMAND_RFO.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5788,7 +5788,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5801,7 +5801,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5814,7 +5814,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.PMM_HIT_LOCAL_PMM.ANY_SNOOP OCR.ALL_PF_DATA_RD.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5827,7 +5827,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5840,7 +5840,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT.SNOOP_NONE OCR.ALL_DATA_RD.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5853,7 +5853,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5866,7 +5866,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_S & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_S.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5879,7 +5879,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_E.ANY_SNOOP  OCR.ALL_PF_DATA_RD.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5905,7 +5905,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5918,7 +5918,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_HIT.ANY_SNOOP OCR.PF_L3_RFO.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5931,7 +5931,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_M & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_M.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5957,7 +5957,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs hit in the L3 and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_HIT.NO_SNOOP_NEEDED OCR.PF_L3_RFO.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5970,7 +5970,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5983,7 +5983,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_F.HIT_OTHER_CORE_FWD  OCR.ALL_PF_RFO.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -5996,7 +5996,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_E & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_E.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6009,7 +6009,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6022,7 +6022,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_M & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_M.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6035,7 +6035,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6048,7 +6048,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6074,7 +6074,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6100,7 +6100,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_F.NO_SNOOP_NEEDED  OCR.ALL_RFO.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6113,7 +6113,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_E.NO_SNOOP_NEEDED  OCR.ALL_PF_DATA_RD.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6139,7 +6139,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6152,7 +6152,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6165,7 +6165,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6191,7 +6191,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6204,7 +6204,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_M.NO_SNOOP_NEEDED  OCR.ALL_RFO.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6217,7 +6217,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6230,7 +6230,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_F.NO_SNOOP_NEEDED  OCR.ALL_DATA_RD.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6243,7 +6243,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6256,7 +6256,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6269,7 +6269,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_HIT.ANY_SNOOP OCR.OTHER.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6282,7 +6282,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6295,7 +6295,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_S & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_S.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6308,7 +6308,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_HIT.HITM_OTHER_CORE OCR.PF_L2_DATA_RD.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6321,7 +6321,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_E.HITM_OTHER_CORE  OCR.ALL_READS.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6347,7 +6347,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & PMM_HIT_LOCAL_PMM & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.PMM_HIT_LOCAL_PMM.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6360,7 +6360,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_NO_FWD  OCR.ALL_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6373,7 +6373,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6386,7 +6386,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6412,7 +6412,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.L3_HIT.ANY_SNOOP OCR.DEMAND_DATA_RD.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6438,7 +6438,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6451,7 +6451,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT & SNOOP_HIT_WITH_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6464,7 +6464,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_RFO.SUPPLIER_NONE.HITM_OTHER_CORE  OCR.ALL_PF_RFO.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6477,7 +6477,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6490,7 +6490,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_PF_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.ALL_PF_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6529,7 +6529,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "OCR.ALL_READS.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED OCR.ALL_READS.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6542,7 +6542,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6555,7 +6555,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6568,7 +6568,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads hit in the L3 and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_HIT.NO_SNOOP_NEEDED OCR.DEMAND_CODE_RD.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6620,7 +6620,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6633,7 +6633,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_M.HITM_OTHER_CORE  OCR.ALL_READS.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6659,7 +6659,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_READS.SUPPLIER_NONE.HITM_OTHER_CORE  OCR.ALL_READS.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6672,7 +6672,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_M.ANY_SNOOP  OCR.ALL_DATA_RD.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6685,7 +6685,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_E.NO_SNOOP_NEEDED  OCR.ALL_RFO.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6698,7 +6698,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6711,7 +6711,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6763,7 +6763,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests hit in the L3 and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_HIT.NO_SNOOP_NEEDED OCR.OTHER.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6776,7 +6776,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_F.HITM_OTHER_CORE  OCR.ALL_PF_RFO.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6789,7 +6789,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6815,7 +6815,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT.ANY_SNOOP OCR.ALL_RFO.L3_HIT.ANY_SNOOP OCR.ALL_RFO.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6828,7 +6828,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs PF_L3_RFO & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs OCR.PF_L3_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.PF_L3_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6841,7 +6841,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6867,7 +6867,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6880,7 +6880,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_DATA_RD.SUPPLIER_NONE.ANY_SNOOP  OCR.ALL_DATA_RD.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6893,7 +6893,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_M & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_M.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6906,7 +6906,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6919,7 +6919,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED OCR.ALL_PF_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6958,7 +6958,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.SUPPLIER_NONE.ANY_SNOOP  OCR.ALL_RFO.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6971,7 +6971,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6984,7 +6984,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -6997,7 +6997,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_M.HITM_OTHER_CORE  OCR.ALL_PF_DATA_RD.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7019,7 +7019,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_S & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_S.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7032,7 +7032,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7045,7 +7045,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_FWD  OCR.ALL_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7058,7 +7058,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_M.ANY_SNOOP  OCR.ALL_PF_RFO.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7071,7 +7071,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_M & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_M.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7084,7 +7084,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7097,7 +7097,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7110,7 +7110,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads DEMAND_CODE_RD & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads OCR.DEMAND_CODE_RD.L3_HIT.ANY_SNOOP OCR.DEMAND_CODE_RD.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7123,7 +7123,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_FWD  OCR.ALL_PF_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7136,7 +7136,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_E & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_E.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7149,7 +7149,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7162,7 +7162,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD OCR.PF_L2_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7175,7 +7175,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7188,7 +7188,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads hit in the L3 and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_HIT.NO_SNOOP_NEEDED OCR.PF_L3_DATA_RD.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7201,7 +7201,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7214,7 +7214,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7227,7 +7227,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.SUPPLIER_NONE.NO_SNOOP_NEEDED  OCR.ALL_PF_RFO.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7240,7 +7240,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_S.HIT_OTHER_CORE_FWD  OCR.ALL_RFO.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7253,7 +7253,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7276,7 +7276,7 @@
         "UMask": "0x18"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7289,7 +7289,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7315,7 +7315,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7328,7 +7328,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads DEMAND_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NONE",
+        "BriefDescription": "Counts demand data reads OCR.DEMAND_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7341,7 +7341,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7354,7 +7354,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7367,7 +7367,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_S & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_S.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7380,7 +7380,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7393,7 +7393,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_E & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_E.ANY_SNOOP  OCR.ALL_RFO.L3_HIT_E.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7406,7 +7406,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_S & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_S.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_RFO.L3_HIT_S.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7419,7 +7419,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED OCR.ALL_DATA_RD.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7432,7 +7432,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_E & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_E.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7445,7 +7445,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7458,7 +7458,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT.SNOOP_NONE OCR.ALL_PF_RFO.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7520,7 +7520,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs PF_L2_RFO & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs OCR.PF_L2_RFO.L3_HIT.HITM_OTHER_CORE OCR.PF_L2_RFO.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7533,7 +7533,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7546,7 +7546,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7572,7 +7572,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) DEMAND_RFO & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts all demand data writes (RFOs) OCR.DEMAND_RFO.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7585,7 +7585,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_NO_FWD  OCR.ALL_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7598,7 +7598,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_FWD  OCR.ALL_PF_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7611,7 +7611,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_S.NO_SNOOP_NEEDED  OCR.ALL_PF_DATA_RD.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7637,7 +7637,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7650,7 +7650,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7676,7 +7676,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & SUPPLIER_NONE & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.SUPPLIER_NONE.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7689,7 +7689,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7702,7 +7702,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7728,7 +7728,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_E & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_E.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7741,7 +7741,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_NO_FWD  OCR.ALL_PF_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7754,7 +7754,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7767,7 +7767,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7780,7 +7780,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT.SNOOP_MISS OCR.ALL_DATA_RD.L3_HIT.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7793,7 +7793,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7806,7 +7806,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads PF_L2_DATA_RD & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_HIT.ANY_SNOOP OCR.PF_L2_DATA_RD.L3_HIT.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7832,7 +7832,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT.SNOOP_NONE OCR.ALL_PF_DATA_RD.L3_HIT.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7845,7 +7845,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.SUPPLIER_NONE.ANY_SNOOP  OCR.ALL_PF_RFO.SUPPLIER_NONE.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7858,7 +7858,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads hit in the L3 and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads OCR.PF_L2_DATA_RD.L3_HIT.NO_SNOOP_NEEDED OCR.PF_L2_DATA_RD.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7884,7 +7884,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7897,7 +7897,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_FWD  OCR.ALL_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7910,7 +7910,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_S & HITM_OTHER_CORE",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_S.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7949,7 +7949,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7962,7 +7962,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -7975,7 +7975,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_M & HITM_OTHER_CORE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_M.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8001,7 +8001,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8014,7 +8014,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_F.HIT_OTHER_CORE_NO_FWD  OCR.ALL_READS.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8027,7 +8027,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_E & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_E.HITM_OTHER_CORE  OCR.ALL_RFO.L3_HIT_E.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8053,7 +8053,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)  DEMAND_RFO & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)  OCR.DEMAND_RFO.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8092,7 +8092,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & NO_SNOOP_NEEDED",
+        "BriefDescription": "OCR.ALL_DATA_RD.SUPPLIER_NONE.NO_SNOOP_NEEDED  OCR.ALL_DATA_RD.SUPPLIER_NONE.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8105,7 +8105,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8118,7 +8118,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_F & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_F.ANY_SNOOP  OCR.ALL_PF_RFO.L3_HIT_F.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8131,7 +8131,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests hit in the L3 and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_HIT.NO_SNOOP_NEEDED OCR.PF_L1D_AND_SW.L3_HIT.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8144,7 +8144,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_M & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_M.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8157,7 +8157,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8170,7 +8170,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8183,7 +8183,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests OTHER & L3_HIT & HITM_OTHER_CORE",
+        "BriefDescription": "Counts any other requests OCR.OTHER.L3_HIT.HITM_OTHER_CORE OCR.OTHER.L3_HIT.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8196,7 +8196,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8222,7 +8222,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_E & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_E.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8235,7 +8235,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_F & HITM_OTHER_CORE",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_F.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8257,7 +8257,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8270,7 +8270,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads  DEMAND_CODE_RD & L3_HIT_M & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all demand code reads  OCR.DEMAND_CODE_RD.L3_HIT_M.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8283,7 +8283,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & L3_HIT_S & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_PF_RFO.L3_HIT_S.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8309,7 +8309,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8322,7 +8322,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests PF_L1D_AND_SW & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests OCR.PF_L1D_AND_SW.L3_HIT.HIT_OTHER_CORE_FWD OCR.PF_L1D_AND_SW.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8348,7 +8348,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_E & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_E.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8361,7 +8361,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8374,7 +8374,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  PF_L2_RFO & L3_HIT_S & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs  OCR.PF_L2_RFO.L3_HIT_S.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8387,7 +8387,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & L3_HIT_F & SNOOP_NONE",
+        "BriefDescription": "OCR.ALL_RFO.L3_HIT_F.SNOOP_NONE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8400,7 +8400,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_HIT & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD OCR.PF_L3_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8413,7 +8413,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads  DEMAND_DATA_RD & L3_HIT_M & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts demand data reads  OCR.DEMAND_DATA_RD.L3_HIT_M.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8426,7 +8426,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_S & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_S.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8439,7 +8439,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & HITM_OTHER_CORE",
+        "BriefDescription": "OCR.ALL_DATA_RD.SUPPLIER_NONE.HITM_OTHER_CORE  OCR.ALL_DATA_RD.SUPPLIER_NONE.HITM_OTHER_CORE",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8452,7 +8452,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_PF_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_FWD  OCR.ALL_PF_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8465,7 +8465,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any other requests  OTHER & L3_HIT_F & NO_SNOOP_NEEDED",
+        "BriefDescription": "Counts any other requests  OCR.OTHER.L3_HIT_F.NO_SNOOP_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8478,7 +8478,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_S & ANY_SNOOP",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_S.ANY_SNOOP  OCR.ALL_READS.L3_HIT_S.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8504,7 +8504,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8517,7 +8517,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads PF_L3_DATA_RD & L3_HIT & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads OCR.PF_L3_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD OCR.PF_L3_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8543,7 +8543,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8556,7 +8556,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "OCR.ALL_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED OCR.ALL_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8569,7 +8569,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  PF_L3_RFO & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  OCR.PF_L3_RFO.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8582,7 +8582,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  PF_L3_DATA_RD & L3_HIT_M & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads  OCR.PF_L3_DATA_RD.L3_HIT_M.ANY_SNOOP",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8595,7 +8595,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_PF_RFO & PMM_HIT_LOCAL_PMM & SNOOP_NOT_NEEDED",
+        "BriefDescription": "OCR.ALL_PF_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED OCR.ALL_PF_RFO.PMM_HIT_LOCAL_PMM.SNOOP_NOT_NEEDED",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8608,7 +8608,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "OCR.ALL_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_FWD  OCR.ALL_DATA_RD.SUPPLIER_NONE.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8621,7 +8621,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  PF_L1D_AND_SW & L3_HIT_E & HIT_OTHER_CORE_FWD",
+        "BriefDescription": "Counts L1 data cache hardware prefetch requests and software prefetch requests  OCR.PF_L1D_AND_SW.L3_HIT_E.HIT_OTHER_CORE_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8634,7 +8634,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  PF_L2_DATA_RD & L3_HIT_F & HIT_OTHER_CORE_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  OCR.PF_L2_DATA_RD.L3_HIT_F.HIT_OTHER_CORE_NO_FWD",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -8647,7 +8647,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "ALL_READS & L3_HIT_S & SNOOP_MISS",
+        "BriefDescription": "OCR.ALL_READS.L3_HIT_S.SNOOP_MISS",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
index 5ec668f46ac1..023f31c72a42 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
@@ -826,16 +826,6 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
-    {
-        "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xE6",
-        "EventName": "BACLEARS.ANY",
-        "PublicDescription": "Counts the number of times the front-end is resteered when it finds a branch instruction in a fetch line. This occurs for the first time a branch instruction is fetched or when the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Loads blocked due to overlapping with a preceding store that cannot be forwarded.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index df355ba7acc8..0cd083839e75 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -537,6 +537,27 @@
         "UMask": "0x10",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Inserts : DRds issued by iA Cores that Missed the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
+        "Filter": "config1=0x40433",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : DRds issued by iA Cores that Missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
+        "Filter": "config1=0x40433",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Clockticks of the IIO Traffic Controller",
         "Counter": "0,1,2,3",
-- 
2.17.1


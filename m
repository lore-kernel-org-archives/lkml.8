Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B6C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E14B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgCPJjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:39:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56919 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgCPJjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:39:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jDmCz-0008DD-9K; Mon, 16 Mar 2020 09:38:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf vendor events: fix spelling mistakes: "occurences" -> "occurrences"
Date:   Mon, 16 Mar 2020 09:38:53 +0000
Message-Id: <20200316093853.117752-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Fix spelling mistake of "occurrences"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json    | 2 +-
 tools/perf/pmu-events/arch/x86/ivytown/pipeline.json      | 2 +-
 tools/perf/pmu-events/arch/x86/jaketown/pipeline.json     | 2 +-
 .../perf/pmu-events/arch/x86/knightslanding/pipeline.json | 8 ++++----
 tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json  | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
index 2a0aad91d83d..e5ca2d85e84d 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
@@ -80,7 +80,7 @@
         "EdgeDetect": "1",
         "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc.)",
+        "BriefDescription": "Number of occurrences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc.)",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
index 2a0aad91d83d..e5ca2d85e84d 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
@@ -80,7 +80,7 @@
         "EdgeDetect": "1",
         "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc.)",
+        "BriefDescription": "Number of occurrences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc.)",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
index 783a5b4a67b1..f32fd4aea6b1 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -1019,7 +1019,7 @@
         "EdgeDetect": "1",
         "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
+        "BriefDescription": "Number of occurrences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
index 92e4ef2e22c6..17c92cdedde0 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
@@ -340,7 +340,7 @@
         "UMask": "0x1",
         "EventName": "RECYCLEQ.LD_BLOCK_ST_FORWARD",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of occurences a retired load gets blocked because its address partially overlaps with a store",
+        "BriefDescription": "Counts the number of occurrences a retired load gets blocked because its address partially overlaps with a store",
         "Data_LA": "1"
     },
     {
@@ -349,7 +349,7 @@
         "UMask": "0x2",
         "EventName": "RECYCLEQ.LD_BLOCK_STD_NOTREADY",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of occurences a retired load gets blocked because its address overlaps with a store whose data is not ready"
+        "BriefDescription": "Counts the number of occurrences a retired load gets blocked because its address overlaps with a store whose data is not ready"
     },
     {
         "PublicDescription": "This event counts the number of retired store that experienced a cache line boundary split(Precise Event). Note that each spilt should be counted only once.",
@@ -358,7 +358,7 @@
         "UMask": "0x4",
         "EventName": "RECYCLEQ.ST_SPLITS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of occurences a retired store that is a cache line split. Each split should be counted only once."
+        "BriefDescription": "Counts the number of occurrences a retired store that is a cache line split. Each split should be counted only once."
     },
     {
         "PEBS": "1",
@@ -367,7 +367,7 @@
         "UMask": "0x8",
         "EventName": "RECYCLEQ.LD_SPLITS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of occurences a retired load that is a cache line split. Each split should be counted only once.",
+        "BriefDescription": "Counts the number of occurrences a retired load that is a cache line split. Each split should be counted only once.",
         "Data_LA": "1"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index b7150f65f16d..d69db55f33e7 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -108,7 +108,7 @@
         "EdgeDetect": "1",
         "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
+        "BriefDescription": "Number of occurrences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-- 
2.25.1


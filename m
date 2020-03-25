Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39110C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7D32078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140163;
	bh=vg7pRGzT4oQ8QP97WHZValzRIpmRmKG16Z64nRYXoE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1rQvIqp6zZ/AFu7D5YY4JVGmVmiySFU0DDTZAu6NgqbM4Z2ymkH/NqbcweoZ4uiIh
	 Y5Kt9oNSEnr3gfCxViiRZsZ0ywbeZTglqmpcH9x3t7Vf0g8gYlRQwf5uZmTw/V/XW1
	 N1B1e/ThD4OWTw7TOvpkSBl8OmnzP+q0pVjAVHcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCYMml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgCYMmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:42:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0DA208E4;
        Wed, 25 Mar 2020 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140157;
        bh=vg7pRGzT4oQ8QP97WHZValzRIpmRmKG16Z64nRYXoE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnzQwdD4yfUuYZMPpD9kX6vZIlbgDzDhJR7taoYMG3qMqtZv2mwcTKa5kLNKV2OLW
         uIV7n8iHzpojiHCwVt/4nC6F4QR/FbORmxu2unghgGuoYQw033v7namCn0Ie3PuYeR
         df2kIHV9w2+kAxOHg8W1rpo52FHXCUZNC03J6bg8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/24] perf jevents: Add some test events
Date:   Wed, 25 Mar 2020 09:41:16 -0300
Message-Id: <20200325124124.32648-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

Add some test PMU events. The events are randomly chosen from x86 and
arm64 JSONs. The events include CPU and uncore events.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1584442939-8911-2-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/test/test_cpu/branch.json | 12 +++++++++
 .../pmu-events/arch/test/test_cpu/other.json  | 26 +++++++++++++++++++
 .../pmu-events/arch/test/test_cpu/uncore.json | 21 +++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/branch.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/other.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/uncore.json

diff --git a/tools/perf/pmu-events/arch/test/test_cpu/branch.json b/tools/perf/pmu-events/arch/test/test_cpu/branch.json
new file mode 100644
index 000000000000..93ddfd8053ca
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/branch.json
@@ -0,0 +1,12 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "L1 BTB Correction."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 BTB Correction."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/other.json b/tools/perf/pmu-events/arch/test/test_cpu/other.json
new file mode 100644
index 000000000000..7d53d7ecd723
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/other.json
@@ -0,0 +1,26 @@
+[
+    {
+        "EventCode": "0x6",
+        "Counter": "0,1",
+        "UMask": "0x80",
+        "EventName": "SEGMENT_REG_LOADS.ANY",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Number of segment register loads."
+    },
+    {
+        "EventCode": "0x9",
+        "Counter": "0,1",
+        "UMask": "0x20",
+        "EventName": "DISPATCH_BLOCKED.ANY",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason"
+    },
+    {
+        "EventCode": "0x3A",
+        "Counter": "0,1",
+        "UMask": "0x0",
+        "EventName": "EIST_TRANS",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_cpu/uncore.json
new file mode 100644
index 000000000000..d0a890cc814d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/uncore.json
@@ -0,0 +1,21 @@
+[
+ {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_ddrc.flux_wcmd",
+	    "BriefDescription": "DDRC write commands",
+	    "PublicDescription": "DDRC write commands",
+	    "Unit": "hisi_sccl,ddrc"
+   },
+   {
+	    "Unit": "CBO",
+	    "EventCode": "0x22",
+	    "UMask": "0x81",
+	    "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
+	    "BriefDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
+	    "PublicDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
+	    "Counter": "0,1",
+	    "CounterMask": "0",
+	    "Invert": "0",
+	    "EdgeDetect": "0"
+  }
+]
-- 
2.21.1


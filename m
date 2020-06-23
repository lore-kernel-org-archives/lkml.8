Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E92C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5962320716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbgFWMcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:32:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6823 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732566AbgFWMcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:32:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FA7A6E18D86B20D8779;
        Tue, 23 Jun 2020 20:32:02 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 20:32:01 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 2/2] perf tools: Fix record failure when mixed with ARM SPE event
Date:   Tue, 23 Jun 2020 20:31:41 +0800
Message-ID: <20200623123141.27747-3-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623123141.27747-1-liwei391@huawei.com>
References: <20200623123141.27747-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When recording with cache-misses and arm_spe_x event, i found that
it will just fail without showing any error info if i put cache-misses
after arm_spe_x event.

[root@localhost 0620]# perf record -e cache-misses -e \
arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,\
jitter=1,store_filter=1,min_latency=0/ sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.067 MB perf.data ]
[root@localhost 0620]# perf record -e \
arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,jitter=1,\
store_filter=1,min_latency=0/ -e cache-misses sleep 1
[root@localhost 0620]#

Finally, i found the reason is that the parameter 'arm_spe_pmu' passed to
arm_spe_recording_init() in auxtrace_record__init() is wrong. When the
arm_spe_x event is not the last event, 'arm_spe_pmus[i]' will be out of
bounds.

It seems that the code can't support concurrent multiple different
arm_spe_x events currently. So add the code to check and record the
found 'arm_spe_pmu' to fix this issue.

In fact, we don't support concurrent multiple same arm_spe_x events either,
that is checked in arm_spe_recording_options(), and it will show the
relevant info.

Fixes: ffd3d18c20b8d ("perf tools: Add ARM Statistical Profiling Extensions (SPE) support")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 62b7b03d691a..7bb6f29e766c 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -58,6 +58,7 @@ struct auxtrace_record
 	bool found_etm = false;
 	bool found_spe = false;
 	static struct perf_pmu **arm_spe_pmus;
+	static struct perf_pmu *arm_spe_pmu;
 	static int nr_spes = 0;
 	int i = 0;
 
@@ -77,6 +78,13 @@ struct auxtrace_record
 
 		for (i = 0; i < nr_spes; i++) {
 			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
+				if (found_spe && (arm_spe_pmu != arm_spe_pmus[i])) {
+					pr_err("Concurrent multiple SPE operation not currently supported\n");
+					*err = -EOPNOTSUPP;
+					return NULL;
+				}
+
+				arm_spe_pmu = arm_spe_pmus[i];
 				found_spe = true;
 				break;
 			}
@@ -94,7 +102,7 @@ struct auxtrace_record
 
 #if defined(__aarch64__)
 	if (found_spe)
-		return arm_spe_recording_init(err, arm_spe_pmus[i]);
+		return arm_spe_recording_init(err, arm_spe_pmu);
 #endif
 
 	/*
-- 
2.17.1


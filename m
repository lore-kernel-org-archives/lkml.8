Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8CBC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7122D2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGXHNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:13:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgGXHNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:13:22 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47816B3546CDA1E9C1F5;
        Fri, 24 Jul 2020 15:13:19 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 15:13:11 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <guohanjun@huawei.com>
Subject: [PATCH v2 1/2] perf tools: Fix record failure when mixed with ARM SPE event
Date:   Fri, 24 Jul 2020 15:11:10 +0800
Message-ID: <20200724071111.35593-2-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724071111.35593-1-liwei391@huawei.com>
References: <20200724071111.35593-1-liwei391@huawei.com>
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
after 'arm_spe_x' event.

[root@localhost 0620]# perf record -e cache-misses -e \
arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,\
jitter=1,store_filter=1,min_latency=0/ sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.067 MB perf.data ]
[root@localhost 0620]# perf record -e \
arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,jitter=1,\
store_filter=1,min_latency=0/ -e cache-misses sleep 1
[root@localhost 0620]#

The current code can only work if the only event to be traced is an
'arm_spe_x', or if it is the last event to be specified. Otherwise the
last event type will be checked against all the arm_spe_pmus[i]->types,
none will match and an out of bound 'i' index will be used in
arm_spe_recording_init().

We don't support concurrent multiple arm_spe_x events currently, that
is checked in arm_spe_recording_options(), and it will show the relevant
info. So add the check and record of the first found 'arm_spe_pmu' to
fix this issue here.

Fixes: ffd3d18c20b8d ("perf tools: Add ARM Statistical Profiling Extensions (SPE) support")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 0a6e75b8777a..28a5d0c18b1d 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -56,7 +56,7 @@ struct auxtrace_record
 	struct perf_pmu	*cs_etm_pmu;
 	struct evsel *evsel;
 	bool found_etm = false;
-	bool found_spe = false;
+	struct perf_pmu *found_spe = NULL;
 	static struct perf_pmu **arm_spe_pmus = NULL;
 	static int nr_spes = 0;
 	int i = 0;
@@ -74,12 +74,12 @@ struct auxtrace_record
 		    evsel->core.attr.type == cs_etm_pmu->type)
 			found_etm = true;
 
-		if (!nr_spes)
+		if (!nr_spes || found_spe)
 			continue;
 
 		for (i = 0; i < nr_spes; i++) {
 			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
-				found_spe = true;
+				found_spe = arm_spe_pmus[i];
 				break;
 			}
 		}
@@ -96,7 +96,7 @@ struct auxtrace_record
 
 #if defined(__aarch64__)
 	if (found_spe)
-		return arm_spe_recording_init(err, arm_spe_pmus[i]);
+		return arm_spe_recording_init(err, found_spe);
 #endif
 
 	/*
-- 
2.17.1


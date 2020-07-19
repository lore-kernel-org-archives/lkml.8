Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A39C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5476E22482
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182461;
	bh=136QSRVCcfl3xwGiJ2b7TZ3Z4I4IDVJfXQZBuQnigzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WNpG/T2lWhct0WpevXYmQGkwTft2KMP1dUSf0s8aMaq4JIOV5VqbDxohRD9RGUnFB
	 0O1tP9jORGI2uut4wFUdWpuXOardahvwdRiAitGjU+RF1uzp8OILvYWTNausYRFbYe
	 b54oFkL2SXvi75pyGT5EubdMRNVQ9icPjU55kxzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGSSOU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:14:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59907 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726714AbgGSSOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:14:19 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-5klR_N-zOdqrqA9FpfFg-Q-1; Sun, 19 Jul 2020 14:14:12 -0400
X-MC-Unique: 5klR_N-zOdqrqA9FpfFg-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9702C106B242;
        Sun, 19 Jul 2020 18:14:08 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE6A574F6C;
        Sun, 19 Jul 2020 18:14:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 13/19] perf metric: Add cache_miss_cycles to metric parse test
Date:   Sun, 19 Jul 2020 20:13:14 +0200
Message-Id: <20200719181320.785305-14-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding test that compute metric with other metrics in it.

  cache_miss_cycles = metric:dcache_miss_cpi + metric:icache_miss_cycles

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-metric.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 8c48251425e1..28f33893338b 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -11,6 +11,8 @@
 #include "debug.h"
 #include "expr.h"
 #include "stat.h"
+#include <perf/cpumap.h>
+#include <perf/evlist.h>
 
 static struct pmu_event pme_test[] = {
 {
@@ -22,6 +24,18 @@ static struct pmu_event pme_test[] = {
 			  "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
 	.metric_name	= "Frontend_Bound_SMT",
 },
+{
+	.metric_expr	= "l1d\\-loads\\-misses / inst_retired.any",
+	.metric_name	= "dcache_miss_cpi",
+},
+{
+	.metric_expr	= "l1i\\-loads\\-misses / inst_retired.any",
+	.metric_name	= "icache_miss_cycles",
+},
+{
+	.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
+	.metric_name	= "cache_miss_cycles",
+},
 };
 
 static struct pmu_events_map map = {
@@ -162,9 +176,28 @@ static int test_frontend(void)
 	return 0;
 }
 
+static int test_cache_miss_cycles(void)
+{
+	double ratio;
+	struct value vals[] = {
+		{ .event = "l1d-loads-misses",  .val = 300 },
+		{ .event = "l1i-loads-misses",  .val = 200 },
+		{ .event = "inst_retired.any",  .val = 400 },
+		{ 0 },
+	};
+
+	TEST_ASSERT_VAL("failed to compute metric",
+			compute_metric("cache_miss_cycles", vals, &ratio) == 0);
+
+	TEST_ASSERT_VAL("cache_miss_cycles failed, wrong ratio",
+			ratio == 1.25);
+	return 0;
+}
+
 int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
 	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
+	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
 	return 0;
 }
-- 
2.25.4


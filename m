Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A3CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0D120720
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200895;
	bh=Yl1zvWtgsNYV5jMZnbgBW6UYz/6JSE6YSInayEPAEQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cPamEK6DHRpPRZt60nknPnbYa4Gnl3MDLzng+T/0u/TErHfi1vy2vXcnMG9gTFtqQ
	 3LXHSqizvWMmw4uNva3uIuwQDBNmmtZ36hF8YsrKueCCKZ0GR8bd3kKq1oOBUvlFNM
	 f7t6brIyepU36ZGYpdGL/1bgI7+WYdve9vqRUzS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgFZTsN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:48:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56416 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbgFZTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:48:10 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-p4_fu2RmP5uNjgUmfC5CxQ-1; Fri, 26 Jun 2020 15:48:03 -0400
X-MC-Unique: p4_fu2RmP5uNjgUmfC5CxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB836107ACF2;
        Fri, 26 Jun 2020 19:48:01 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 143F35BAD2;
        Fri, 26 Jun 2020 19:47:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 10/10] perf tests: Add cache_miss_cycles to metric parse test
Date:   Fri, 26 Jun 2020 21:47:20 +0200
Message-Id: <20200626194720.2915044-11-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-1-jolsa@kernel.org>
References: <20200626194720.2915044-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-metric.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 8c48251425e1..feb97f7c90c8 100644
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
+	.metric_expr	= "(metric:dcache_miss_cpi + metric:icache_miss_cycles)",
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


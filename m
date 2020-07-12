Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F17C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74092068F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560466;
	bh=y3ROa9HhUW2B+qHIr328UHFA2KOF3jC3gHOovJo/tjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W6Q6I6qQGC1A+v5p9pJ4C9eiBKN+pvzupa+0pxFk7ayZrw+E1mS33IdtOUclL7DrS
	 pVK8IK2qQUIeRru0CfnwAjoPjo+HylKQoID4I+j0SwWlABHYaRZi25uBALm+l5yT7T
	 b/YkhnxkLBcMhi4GbEE5hNXOjteSmNqxl23Npbys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgGLN1p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53581 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729038AbgGLN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:35 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-Fcc-h9I_OLC4Vyqx_nOcpQ-1; Sun, 12 Jul 2020 09:27:30 -0400
X-MC-Unique: Fcc-h9I_OLC4Vyqx_nOcpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5163E1081;
        Sun, 12 Jul 2020 13:27:28 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44B871944D;
        Sun, 12 Jul 2020 13:27:25 +0000 (UTC)
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
Subject: [PATCH 15/18] perf metric: Add DCache_L2 to metric parse test
Date:   Sun, 12 Jul 2020 15:26:31 +0200
Message-Id: <20200712132634.138901-16-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-1-jolsa@kernel.org>
References: <20200712132634.138901-1-jolsa@kernel.org>
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

Adding test that compute DCache_L2 metrics with other related metrics in it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-metric.c | 71 +++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 28f33893338b..b50e2a3f3b73 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -36,6 +36,27 @@ static struct pmu_event pme_test[] = {
 	.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
 	.metric_name	= "cache_miss_cycles",
 },
+{
+	.metric_expr	= "L2_RQSTS.DEMAND_DATA_RD_HIT + L2_RQSTS.PF_HIT + L2_RQSTS.RFO_HIT",
+	.metric_name	= "DCache_L2_All_Hits",
+},
+{
+	.metric_expr	= "max(L2_RQSTS.ALL_DEMAND_DATA_RD - L2_RQSTS.DEMAND_DATA_RD_HIT, 0) + "
+			  "L2_RQSTS.PF_MISS + L2_RQSTS.RFO_MISS",
+	.metric_name	= "DCache_L2_All_Miss",
+},
+{
+	.metric_expr	= "DCache_L2_All_Hits + DCache_L2_All_Miss",
+	.metric_name	= "DCache_L2_All",
+},
+{
+	.metric_expr	= "d_ratio(DCache_L2_All_Hits, DCache_L2_All)",
+	.metric_name	= "DCache_L2_Hits",
+},
+{
+	.metric_expr	= "d_ratio(DCache_L2_All_Miss, DCache_L2_All)",
+	.metric_name	= "DCache_L2_Misses",
+},
 };
 
 static struct pmu_events_map map = {
@@ -194,10 +215,60 @@ static int test_cache_miss_cycles(void)
 	return 0;
 }
 
+
+/*
+ * DCache_L2_All_Hits = L2_RQSTS.DEMAND_DATA_RD_HIT + L2_RQSTS.PF_HIT + L2_RQSTS.RFO_HI
+ * DCache_L2_All_Miss = MAX(L2_RQSTS.ALL_DEMAND_DATA_RD - L2_RQSTS.DEMAND_DATA_RD_HIT, 0) +
+ *                      L2_RQSTS.PF_MISS + L2_RQSTS.RFO_MISS
+ * DCache_L2_All      = DCache_L2_All_Hits + DCache_L2_All_Miss
+ * DCache_L2_Hits     = d_ratio(DCache_L2_All_Hits, DCache_L2_All)
+ * DCache_L2_Misses   = d_ratio(DCache_L2_All_Miss, DCache_L2_All)
+ *
+ * L2_RQSTS.DEMAND_DATA_RD_HIT = 100
+ * L2_RQSTS.PF_HIT             = 200
+ * L2_RQSTS.RFO_HI             = 300
+ * L2_RQSTS.ALL_DEMAND_DATA_RD = 400
+ * L2_RQSTS.PF_MISS            = 500
+ * L2_RQSTS.RFO_MISS           = 600
+ *
+ * DCache_L2_All_Hits = 600
+ * DCache_L2_All_Miss = MAX(400 - 100, 0) + 500 + 600 = 1400
+ * DCache_L2_All      = 600 + 1400  = 2000
+ * DCache_L2_Hits     = 600 / 2000  = 0.3
+ * DCache_L2_Misses   = 1400 / 2000 = 0.7
+ */
+static int test_dcache_l2(void)
+{
+	double ratio;
+	struct value vals[] = {
+		{ .event = "L2_RQSTS.DEMAND_DATA_RD_HIT", .val = 100 },
+		{ .event = "L2_RQSTS.PF_HIT",             .val = 200 },
+		{ .event = "L2_RQSTS.RFO_HIT",            .val = 300 },
+		{ .event = "L2_RQSTS.ALL_DEMAND_DATA_RD", .val = 400 },
+		{ .event = "L2_RQSTS.PF_MISS",            .val = 500 },
+		{ .event = "L2_RQSTS.RFO_MISS",           .val = 600 },
+		{ 0 },
+	};
+
+	TEST_ASSERT_VAL("failed to compute metric",
+			compute_metric("DCache_L2_Hits", vals, &ratio) == 0);
+
+	TEST_ASSERT_VAL("DCache_L2_Hits failed, wrong ratio",
+			ratio == 0.3);
+
+	TEST_ASSERT_VAL("failed to compute metric",
+			compute_metric("DCache_L2_Misses", vals, &ratio) == 0);
+
+	TEST_ASSERT_VAL("DCache_L2_Misses failed, wrong ratio",
+			ratio == 0.7);
+	return 0;
+}
+
 int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
 	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
 	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
+	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
 	return 0;
 }
-- 
2.25.4


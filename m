Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BD1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282E522482
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182464;
	bh=eUkQi7abntD2U9UpdWahiUjs60NUjMVQC6+LEmFf2pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D6rFpbWte+ABX6EQo8xoUyhgKwDIllRySUbm9YJKX/AT28O7oOfvFzR+ewiekgKwJ
	 VEJMnoHrsL/CPVVvUK/ZCaYj9YLlg3tDPFVuANAowTGOoOYWbi/knmBotC/t2adoas
	 deRFbB6CuMtAnLvOB4MNWRjGAg+Luhp7V900ZlOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGSSOX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:14:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55366 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbgGSSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:14:21 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Jcxo-tJxP86Y6eC5yBvJeQ-1; Sun, 19 Jul 2020 14:14:13 -0400
X-MC-Unique: Jcxo-tJxP86Y6eC5yBvJeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C59C118A1DF0;
        Sun, 19 Jul 2020 18:14:11 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED583872E1;
        Sun, 19 Jul 2020 18:14:08 +0000 (UTC)
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
Subject: [PATCH 14/19] perf metric: Add DCache_L2 to metric parse test
Date:   Sun, 19 Jul 2020 20:13:15 +0200
Message-Id: <20200719181320.785305-15-jolsa@kernel.org>
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

Adding test that compute DCache_L2 metrics with other related metrics in it.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-metric.c | 71 +++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 28f33893338b..aa4d5a9f09a8 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -36,6 +36,27 @@ static struct pmu_event pme_test[] = {
 	.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
 	.metric_name	= "cache_miss_cycles",
 },
+{
+	.metric_expr	= "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
+	.metric_name	= "DCache_L2_All_Hits",
+},
+{
+	.metric_expr	= "max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + "
+			  "l2_rqsts.pf_miss + l2_rqsts.rfo_miss",
+	.metric_name	= "DCache_L2_All_Miss",
+},
+{
+	.metric_expr	= "dcache_l2_all_hits + dcache_l2_all_miss",
+	.metric_name	= "DCache_L2_All",
+},
+{
+	.metric_expr	= "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
+	.metric_name	= "DCache_L2_Hits",
+},
+{
+	.metric_expr	= "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
+	.metric_name	= "DCache_L2_Misses",
+},
 };
 
 static struct pmu_events_map map = {
@@ -194,10 +215,60 @@ static int test_cache_miss_cycles(void)
 	return 0;
 }
 
+
+/*
+ * DCache_L2_All_Hits = l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hi
+ * DCache_L2_All_Miss = max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) +
+ *                      l2_rqsts.pf_miss + l2_rqsts.rfo_miss
+ * DCache_L2_All      = dcache_l2_all_hits + dcache_l2_all_miss
+ * DCache_L2_Hits     = d_ratio(dcache_l2_all_hits, dcache_l2_all)
+ * DCache_L2_Misses   = d_ratio(dcache_l2_all_miss, dcache_l2_all)
+ *
+ * l2_rqsts.demand_data_rd_hit = 100
+ * l2_rqsts.pf_hit             = 200
+ * l2_rqsts.rfo_hi             = 300
+ * l2_rqsts.all_demand_data_rd = 400
+ * l2_rqsts.pf_miss            = 500
+ * l2_rqsts.rfo_miss           = 600
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
+		{ .event = "l2_rqsts.demand_data_rd_hit", .val = 100 },
+		{ .event = "l2_rqsts.pf_hit",             .val = 200 },
+		{ .event = "l2_rqsts.rfo_hit",            .val = 300 },
+		{ .event = "l2_rqsts.all_demand_data_rd", .val = 400 },
+		{ .event = "l2_rqsts.pf_miss",            .val = 500 },
+		{ .event = "l2_rqsts.rfo_miss",           .val = 600 },
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


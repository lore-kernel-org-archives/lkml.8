Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B880C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669AE21883
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014434;
	bh=C+/cCYAbLbSfODXjU6U0bloWTKM0s6yrjmoSfeGWFZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xO3JdRB6NOOfWPMTk5NnscVtpHZhFfYMrs6PE9cfYstN7NhX4f36+QuaZ/r1Yp7UB
	 0zbQxGCrdVdJSfzhU5NHCcFqyj5VNln/eoO6SF1eD71TpeT2E0nrj1vERXGpnTsiOt
	 Y/C3BGHu6VJ/em8HBIp0yoQFcXKpCDR+218239eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgG2JUd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:20:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728051AbgG2JUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:20:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-18xriGXRMYSIYnkJI_3bGA-1; Wed, 29 Jul 2020 05:20:24 -0400
X-MC-Unique: 18xriGXRMYSIYnkJI_3bGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC6A510059C1;
        Wed, 29 Jul 2020 09:20:21 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC9A969335;
        Wed, 29 Jul 2020 09:20:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 17/19] perf metric: Add metric group test
Date:   Wed, 29 Jul 2020 11:19:06 +0200
Message-Id: <20200729091908.1378911-18-jolsa@kernel.org>
In-Reply-To: <20200729091908.1378911-1-jolsa@kernel.org>
References: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding test for metric group plus compute_metric_group function to get
metrics values within the group.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200719181320.785305-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-metric.c | 48 +++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 5ac32f80f8ea..f2ba5b2c5557 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -18,6 +18,7 @@ static struct pmu_event pme_test[] = {
 {
 	.metric_expr	= "inst_retired.any / cpu_clk_unhalted.thread",
 	.metric_name	= "IPC",
+	.metric_group	= "group1",
 },
 {
 	.metric_expr	= "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
@@ -35,6 +36,7 @@ static struct pmu_event pme_test[] = {
 {
 	.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
 	.metric_name	= "cache_miss_cycles",
+	.metric_group	= "group1",
 },
 {
 	.metric_expr	= "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
@@ -127,7 +129,9 @@ static double compute_single(struct rblist *metric_events, struct evlist *evlist
 	return 0.;
 }
 
-static int compute_metric(const char *name, struct value *vals, double *ratio)
+static int __compute_metric(const char *name, struct value *vals,
+			    const char *name1, double *ratio1,
+			    const char *name2, double *ratio2)
 {
 	struct rblist metric_events = {
 		.nr_entries = 0,
@@ -166,7 +170,10 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
 	load_runtime_stat(&st, evlist, vals);
 
 	/* And execute the metric */
-	*ratio = compute_single(&metric_events, evlist, &st, name);
+	if (name1 && ratio1)
+		*ratio1 = compute_single(&metric_events, evlist, &st, name1);
+	if (name2 && ratio2)
+		*ratio2 = compute_single(&metric_events, evlist, &st, name2);
 
 	/* ... clenup. */
 	metricgroup__rblist_exit(&metric_events);
@@ -177,6 +184,18 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
 	return 0;
 }
 
+static int compute_metric(const char *name, struct value *vals, double *ratio)
+{
+	return __compute_metric(name, vals, name, ratio, NULL, NULL);
+}
+
+static int compute_metric_group(const char *name, struct value *vals,
+				const char *name1, double *ratio1,
+				const char *name2, double *ratio2)
+{
+	return __compute_metric(name, vals, name1, ratio1, name2, ratio2);
+}
+
 static int test_ipc(void)
 {
 	double ratio;
@@ -297,6 +316,30 @@ static int test_recursion_fail(void)
 	return 0;
 }
 
+static int test_metric_group(void)
+{
+	double ratio1, ratio2;
+	struct value vals[] = {
+		{ .event = "cpu_clk_unhalted.thread", .val = 200 },
+		{ .event = "l1d-loads-misses",        .val = 300 },
+		{ .event = "l1i-loads-misses",        .val = 200 },
+		{ .event = "inst_retired.any",        .val = 400 },
+		{ 0 },
+	};
+
+	TEST_ASSERT_VAL("failed to find recursion",
+			compute_metric_group("group1", vals,
+					     "IPC", &ratio1,
+					     "cache_miss_cycles", &ratio2) == 0);
+
+	TEST_ASSERT_VAL("group IPC failed, wrong ratio",
+			ratio1 == 2.0);
+
+	TEST_ASSERT_VAL("group cache_miss_cycles failed, wrong ratio",
+			ratio2 == 1.25);
+	return 0;
+}
+
 int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
@@ -304,5 +347,6 @@ int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
 	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
 	TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
+	TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
 	return 0;
 }
-- 
2.25.4


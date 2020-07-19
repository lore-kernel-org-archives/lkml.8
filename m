Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9329BC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791732176B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182472;
	bh=IbJ7t7j1qeIRKCTrlVtcYWdbD9H36XFTh9kNRjxfCZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KmuV8ndJw8ODnYcnIsL4nz8puFHcYKMPNjB1wYNKVjBq80vdKY6Tyd+55n1TS/moN
	 T18dpQ0wKhTusV4r2a3WB7XVOdX41fD7kttzIO6p/prPoeZICbYoqGHCY+QkrTSEUn
	 pB+/biiqEPIY5j8+/nKwku51xrmOtbLoXjGpbOUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgGSSOb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:14:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbgGSSO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:14:28 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Nx3DWVdNMHmk5xrVC7CJLw-1; Sun, 19 Jul 2020 14:14:23 -0400
X-MC-Unique: Nx3DWVdNMHmk5xrVC7CJLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61CA9800685;
        Sun, 19 Jul 2020 18:14:21 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AD7274F6C;
        Sun, 19 Jul 2020 18:14:18 +0000 (UTC)
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
Subject: [PATCH 17/19] perf metric: Add metric group test
Date:   Sun, 19 Jul 2020 20:13:18 +0200
Message-Id: <20200719181320.785305-18-jolsa@kernel.org>
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

Adding test for metric group plus compute_metric_group
function to get metrics values within the group.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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


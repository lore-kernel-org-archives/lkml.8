Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4899AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17081205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591134503;
	bh=9zPCkIBWuGCn36PkAcKexpAceO/+bzJzIsXtvYvPIXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z0lhEMUNAU3U0o/EeWYZGCFzky/29OvnwAoJrbncN/xxOTmlqUbTbsgyLtO8exRT9
	 ifQywTpHNlF2n1JHgSZPfxlgwSBY5Rgdatlr6U2Z8RVGOb3sqdQpnqmn2bOYQm3eUD
	 GGyHS1PgbKDSWeJ4/ltbnu2+zIXy7CImrdKAevSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgFBVsW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:48:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44638 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728409AbgFBVsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:48:20 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-ev84bhyDMjGl2xmS9K5Lug-1; Tue, 02 Jun 2020 17:47:58 -0400
X-MC-Unique: ev84bhyDMjGl2xmS9K5Lug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1B5580058E;
        Tue,  2 Jun 2020 21:47:56 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 971151BCBE;
        Tue,  2 Jun 2020 21:47:54 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 04/13] perf tests: Add another metric parsing test
Date:   Tue,  2 Jun 2020 23:47:32 +0200
Message-Id: <20200602214741.1218986-5-jolsa@kernel.org>
In-Reply-To: <20200602214741.1218986-1-jolsa@kernel.org>
References: <20200602214741.1218986-1-jolsa@kernel.org>
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

The test goes through all metrics compiled for arch
within pmu events and try to parse them.

This test is different from 'test_parsing' in that
we go through all the events in the current arch,
not just one defined for current CPU model. Using
'fake_pmu' to parse events which do not have PMUs
defined in the system.

Say there's bad change in ivybridge metrics file, like:

  --- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
  +++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
  @@ -8,7 +8,7 @@
  -        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ((
  +        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / / (4 *

the test fails with (on my kabylake laptop):

  $ perf test 'Parsing of PMU event table metrics with fake PMUs' -v
  parsing 'idq_uops_not_delivered.core / / (4 * (( ( cpu_clk_unh...
  syntax error, line 1
  expr__parse failed
  test child finished with -1
  ...

The test also defines its own list of metrics and
tries to parse them. It's handy for developing.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/pmu-events.c | 117 +++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 8d852f6d2092..c745b6e13cbe 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -390,7 +390,8 @@ static bool is_number(const char *str)
 	return errno == 0 && end_ptr != str;
 }
 
-static int check_parse_id(const char *id, struct parse_events_error *error)
+static int check_parse_id(const char *id, struct parse_events_error *error,
+			  bool fake_pmu)
 {
 	struct evlist *evlist;
 	int ret;
@@ -402,7 +403,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error)
 	evlist = evlist__new();
 	if (!evlist)
 		return -ENOMEM;
-	ret = parse_events(evlist, id, error, false);
+	ret = parse_events(evlist, id, error, fake_pmu);
 	evlist__delete(evlist);
 	return ret;
 }
@@ -411,7 +412,7 @@ static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
 {
 	struct parse_events_error error = { 0 };
 
-	int ret = check_parse_id(id, &error);
+	int ret = check_parse_id(id, &error, false);
 	if (ret && same_cpu) {
 		pr_warning("Parse event failed metric '%s' id '%s' expr '%s'\n",
 			pe->metric_name, id, pe->metric_expr);
@@ -429,6 +430,18 @@ static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
 	return ret;
 }
 
+static int check_parse_fake(const char *id)
+{
+	struct parse_events_error error = { 0 };
+	int ret = check_parse_id(id, &error, true);
+
+	free(error.str);
+	free(error.help);
+	free(error.first_str);
+	free(error.first_help);
+	return ret;
+}
+
 static void expr_failure(const char *msg,
 			 const struct pmu_events_map *map,
 			 const struct pmu_event *pe)
@@ -498,6 +511,100 @@ static int test_parsing(void)
 	return ret == 0 ? TEST_OK : TEST_SKIP;
 }
 
+struct test_metric {
+	const char *str;
+};
+
+static struct test_metric metrics[] = {
+	{ "(unc_p_power_state_occupancy.cores_c0 / unc_p_clockticks) * 100." },
+	{ "imx8_ddr0@read\\-cycles@ * 4 * 4", },
+	{ "imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@ * 4", },
+	{ "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100", },
+	{ "(imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@)", },
+};
+
+static int metric_parse_fake(const char *str)
+{
+	struct expr_parse_ctx ctx;
+	struct hashmap_entry *cur;
+	double result;
+	int ret = -1;
+	size_t bkt;
+	int i;
+
+	pr_debug("parsing '%s'\n", str);
+
+	expr__ctx_init(&ctx);
+	if (expr__find_other(str, NULL, &ctx, 0) < 0) {
+		pr_err("expr__find_other failed\n");
+		return -1;
+	}
+
+	/*
+	 * Add all ids with a made up value. The value may
+	 * trigger divide by zero when subtracted and so try to
+	 * make them unique.
+	 */
+	i = 1;
+	hashmap__for_each_entry((&ctx.ids), cur, bkt)
+		expr__add_id(&ctx, strdup(cur->key), i++);
+
+	hashmap__for_each_entry((&ctx.ids), cur, bkt) {
+		if (check_parse_fake(cur->key)) {
+			pr_err("check_parse_fake failed\n");
+			goto out;
+		}
+	}
+
+	if (expr__parse(&result, &ctx, str, 1))
+		pr_err("expr__parse failed\n");
+	else
+		ret = 0;
+
+out:
+	expr__ctx_clear(&ctx);
+	return ret;
+}
+
+/*
+ * Parse all the metrics for current architecture,
+ * or all defined cpus via the 'fake_pmu' bool
+ * in parse_events.
+ */
+static int test_parsing_fake(void)
+{
+	struct pmu_events_map *map;
+	struct pmu_event *pe;
+	unsigned int i, j;
+	int err = 0;
+
+	for (i = 0; i < ARRAY_SIZE(metrics); i++) {
+		err = metric_parse_fake(metrics[i].str);
+		if (err)
+			return err;
+	}
+
+	i = 0;
+	for (;;) {
+		map = &pmu_events_map[i++];
+		if (!map->table)
+			break;
+		j = 0;
+		for (;;) {
+			pe = &map->table[j++];
+			if (!pe->name && !pe->metric_group && !pe->metric_name)
+				break;
+			if (!pe->metric_expr)
+				continue;
+			err = metric_parse_fake(pe->metric_expr);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static const struct {
 	int (*func)(void);
 	const char *desc;
@@ -514,6 +621,10 @@ static const struct {
 		.func = test_parsing,
 		.desc = "Parsing of PMU event table metrics",
 	},
+	{
+		.func = test_parsing_fake,
+		.desc = "Parsing of PMU event table metrics with fake PMUs",
+	},
 };
 
 const char *test__pmu_events_subtest_get_desc(int subtest)
-- 
2.25.4


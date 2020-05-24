Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D54C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102EA207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590360178;
	bh=Fn/YKFC7HHYWHrudAbj1mM886ZQVuLm1EIseeyIaxwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rGiPRxGdJnJT7DcBFTrbjR1V4rDWve2Bqedwoa8ZpMm49cLXsI2IM3Z7ESajtZ35Y
	 SDgamoLlxaI165kfuf3y/TZ/r+4yBV1rm8RPOC7JngoXoWoDtCCCCPA6uJVGpsZWhY
	 QtN98VROVGduLgurIRB+iCZFIxCrzvrC3qnmKivA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbgEXWm5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:42:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21939 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388561AbgEXWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:42:49 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-opWfOEG4NkClZ-GlKWoc0Q-1; Sun, 24 May 2020 18:42:43 -0400
X-MC-Unique: opWfOEG4NkClZ-GlKWoc0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59028835B40;
        Sun, 24 May 2020 22:42:42 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EB4D6ED9C;
        Sun, 24 May 2020 22:42:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 06/14] perf tests: Add another pmu-events tests
Date:   Mon, 25 May 2020 00:42:11 +0200
Message-Id: <20200524224219.234847-7-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 4
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test goes through all metrics compiled for arch
within pmu events and try to parse them.

The test also defines its own list of metrics and
tries to parse them. It's handy for developing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/pmu-events.c | 120 ++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index ab64b4a4e284..f100df025440 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -490,6 +490,122 @@ static int test_parsing(void)
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
+static int check_id(const char *id)
+{
+	struct parse_events_error error;
+	struct evlist *evlist;
+	int ret;
+
+	/* Numbers are always valid. */
+	if (is_number(id))
+		return 0;
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -1;
+
+	memset(&error, 0, sizeof(error));
+	ret = parse_events_fake(evlist, id, &error);
+	if (ret) {
+		pr_debug("str        : %s\n", error.str);
+		pr_debug("help       : %s\n", error.help);
+		pr_debug("first_str  : %s\n", error.first_str);
+		pr_debug("first_help : %s\n", error.first_help);
+	}
+
+	evlist__delete(evlist);
+	free(error.str);
+	free(error.help);
+	free(error.first_str);
+	free(error.first_help);
+	return ret;
+}
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
+	i = 1;
+	hashmap__for_each_entry((&ctx.ids), cur, bkt)
+		expr__add_id(&ctx, strdup(cur->key), i++);
+
+	hashmap__for_each_entry((&ctx.ids), cur, bkt) {
+		if (check_id(cur->key)) {
+			pr_err("check_id failed\n");
+			goto out;
+		}
+	}
+
+	if (!expr__parse(&result, &ctx, str, 1))
+		ret = 0;
+	else
+		pr_err("expr__parse failed\n");
+
+out:
+	expr__ctx_clear(&ctx);
+	return ret;
+
+}
+
+static int test_parsing_fake(void)
+{
+	struct pmu_events_map *map;
+	struct pmu_event *pe;
+	unsigned int i, j;
+	int err = 0;
+
+	for (i = 0; !err && i < ARRAY_SIZE(metrics); i++)
+		err = metric_parse_fake(metrics[i].str);
+
+	if (err)
+		return err;
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
@@ -506,6 +622,10 @@ static const struct {
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


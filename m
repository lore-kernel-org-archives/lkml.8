Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF4DC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3EC207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590360165;
	bh=nkBpJwOmoz5PnxFU22lY4anI816OoJQdx9G8IP4WP3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jr+7pe/jYczjSKHtNJOXpuVabQxhSU2MBovjuBw/b+mKDugr46/2oSVVfOF6jP+3M
	 MEfdLlgE8lanvaVmB1B05gzzcNowhvf5MTT8F9DE6L0D4cndXO3RPorgzRRf0pL3wy
	 Qs98XiRkRhzlrpzENUc4TzHn+/67+j2T0GoJMZ6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbgEXWmk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:42:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387850AbgEXWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:42:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-_CjfpuZLPEeY7cD3Jo16FQ-1; Sun, 24 May 2020 18:42:33 -0400
X-MC-Unique: _CjfpuZLPEeY7cD3Jo16FQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3465800688;
        Sun, 24 May 2020 22:42:31 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15A6C5D788;
        Sun, 24 May 2020 22:42:26 +0000 (UTC)
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
Subject: [PATCH 02/14] perf tools: Do not pass avg to generic_metric
Date:   Mon, 25 May 2020 00:42:07 +0200
Message-Id: <20200524224219.234847-3-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
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

There's no need to pass the given evsel's count to
metric data, because it will be pushed again within
the following metric_events loop.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/stat-shadow.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index c44dc814b377..a7c13a88ecb9 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -737,7 +737,6 @@ static void generic_metric(struct perf_stat_config *config,
 			   const char *metric_name,
 			   const char *metric_unit,
 			   int runtime,
-			   double avg,
 			   int cpu,
 			   struct perf_stat_output_ctx *out,
 			   struct runtime_stat *st)
@@ -750,11 +749,6 @@ static void generic_metric(struct perf_stat_config *config,
 	char *n, *pn;
 
 	expr__ctx_init(&pctx);
-	/* Must be first id entry */
-	n = strdup(name);
-	if (!n)
-		return;
-	expr__add_id(&pctx, n, avg);
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 		struct stats *stats;
@@ -1042,7 +1036,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, name, 0);
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
-				evsel->metric_name, NULL, 1, avg, cpu, out, st);
+				evsel->metric_name, NULL, 1, cpu, out, st);
 	} else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
 		char unit = 'M';
 		char unit_buf[10];
@@ -1071,7 +1065,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				out->new_line(config, ctxp);
 			generic_metric(config, mexp->metric_expr, mexp->metric_events,
 					evsel->name, mexp->metric_name,
-					mexp->metric_unit, mexp->runtime, avg, cpu, out, st);
+					mexp->metric_unit, mexp->runtime, cpu, out, st);
 		}
 	}
 	if (num == 0)
-- 
2.25.4


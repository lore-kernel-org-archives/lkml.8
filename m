Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5974C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851BE206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098715;
	bh=biWfr3pQnS6POQVbnqskwDSx4Ghz4Z+wO10jfwRineU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vRCVOvpeg03hunxxClJbs2rh7MXhyCYLfAadfX1V3FGb++7aTheOkpN3gudmi6rky
	 Myl+AhAFFUfuEp/Lt8G/Z/hnmURitYnePeMqKbl83pk08eG6t0dDv6RhS1DKKLSWMQ
	 imADExIQ/831Oo3SUGTpiucMkp0fSovIWKb2PwFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgFBLvy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36531 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728070AbgFBLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:29 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-gYlz33UBM_2JG7ucv7nfDg-1; Tue, 02 Jun 2020 07:51:25 -0400
X-MC-Unique: gYlz33UBM_2JG7ucv7nfDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA5C80B724;
        Tue,  2 Jun 2020 11:51:23 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAD96100164D;
        Tue,  2 Jun 2020 11:51:20 +0000 (UTC)
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
Subject: [PATCH 09/13] perf tools: Factor out prepare_metric function
Date:   Tue,  2 Jun 2020 13:50:51 +0200
Message-Id: <20200602115055.1168446-10-jolsa@kernel.org>
In-Reply-To: <20200602115055.1168446-1-jolsa@kernel.org>
References: <20200602115055.1168446-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factoring out prepare_metric functio so it can
be used in test interface coming in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/stat-shadow.c | 53 ++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index a7c13a88ecb9..27be7ce2fff4 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -730,25 +730,16 @@ static void print_smi_cost(struct perf_stat_config *config,
 	out->print_metric(config, out->ctx, NULL, "%4.0f", "SMI#", smi_num);
 }
 
-static void generic_metric(struct perf_stat_config *config,
-			   const char *metric_expr,
-			   struct evsel **metric_events,
-			   char *name,
-			   const char *metric_name,
-			   const char *metric_unit,
-			   int runtime,
-			   int cpu,
-			   struct perf_stat_output_ctx *out,
-			   struct runtime_stat *st)
+static int prepare_metric(struct evsel **metric_events,
+			  struct expr_parse_ctx *pctx,
+			  int cpu,
+			  struct runtime_stat *st)
 {
-	print_metric_t print_metric = out->print_metric;
-	struct expr_parse_ctx pctx;
-	double ratio, scale;
-	int i;
-	void *ctxp = out->ctx;
+	double scale;
 	char *n, *pn;
+	int i;
 
-	expr__ctx_init(&pctx);
+	expr__ctx_init(pctx);
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 		struct stats *stats;
@@ -771,7 +762,7 @@ static void generic_metric(struct perf_stat_config *config,
 
 		n = strdup(metric_events[i]->name);
 		if (!n)
-			return;
+			return -ENOMEM;
 		/*
 		 * This display code with --no-merge adds [cpu] postfixes.
 		 * These are not supported by the parser. Remove everything
@@ -782,11 +773,35 @@ static void generic_metric(struct perf_stat_config *config,
 			*pn = 0;
 
 		if (metric_total)
-			expr__add_id(&pctx, n, metric_total);
+			expr__add_id(pctx, n, metric_total);
 		else
-			expr__add_id(&pctx, n, avg_stats(stats)*scale);
+			expr__add_id(pctx, n, avg_stats(stats)*scale);
 	}
 
+	return i;
+}
+
+static void generic_metric(struct perf_stat_config *config,
+			   const char *metric_expr,
+			   struct evsel **metric_events,
+			   char *name,
+			   const char *metric_name,
+			   const char *metric_unit,
+			   int runtime,
+			   int cpu,
+			   struct perf_stat_output_ctx *out,
+			   struct runtime_stat *st)
+{
+	print_metric_t print_metric = out->print_metric;
+	struct expr_parse_ctx pctx;
+	double ratio, scale;
+	int i;
+	void *ctxp = out->ctx;
+
+	i = prepare_metric(metric_events, &pctx, cpu, st);
+	if (i < 0)
+		return;
+
 	if (!metric_events[i]) {
 		if (expr__parse(&ratio, &pctx, metric_expr, runtime) == 0) {
 			char *unit;
-- 
2.25.4


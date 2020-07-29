Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9506221883
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014408;
	bh=naH+3SvyetwUSl2cx/iz+lecdN9nDA1x8uuRn50Iww0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WfgSTpJB/x0puzMND82ElySjBsN+cHx7HU3qgMPtNT4pY7wmXTej+VjmCvk25lAne
	 nvLoR107pfMM5m4oQtHYZ7qeU0Cs01PcyodpgzqTdvTKz7zRsPIoLmH50QdKwq1Y5H
	 zzQbR82K2qFU0uLQFZdBcluxi0sn26ygYb52HmfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgG2JUH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:20:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40726 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728195AbgG2JUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:20:06 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-H4aIQLXRPBeTA11LrF0Y8Q-1; Wed, 29 Jul 2020 05:19:58 -0400
X-MC-Unique: H4aIQLXRPBeTA11LrF0Y8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D0751800D4A;
        Wed, 29 Jul 2020 09:19:56 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A9116932D;
        Wed, 29 Jul 2020 09:19:52 +0000 (UTC)
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
Subject: [PATCH 11/19] perf metric: Compute referenced metrics
Date:   Wed, 29 Jul 2020 11:19:00 +0200
Message-Id: <20200729091908.1378911-12-jolsa@kernel.org>
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

Adding computation (expr__parse call) of referenced metric at
the point when it needs to be resolved during the parent metric
computation.

Once the inner metric is computed, the result is stored and
used if there's another usage of that metric.

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
Link: http://lore.kernel.org/lkml/20200719181320.785305-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/expr.h |  3 +++
 tools/perf/util/expr.y |  4 ++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index d3997c2b4a90..a346ca590513 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -112,6 +112,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 	 */
 	data_ptr->ref.metric_name = ref->metric_name;
 	data_ptr->ref.metric_expr = ref->metric_expr;
+	data_ptr->ref.counted = false;
 	data_ptr->is_ref = true;
 
 	ret = hashmap__set(&ctx->ids, name, data_ptr,
@@ -133,6 +134,34 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
 }
 
+int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
+		     struct expr_id_data **datap)
+{
+	struct expr_id_data *data;
+
+	if (expr__get_id(ctx, id, datap) || !*datap) {
+		pr_debug("%s not found\n", id);
+		return -1;
+	}
+
+	data = *datap;
+
+	pr_debug2("lookup: is_ref %d, counted %d, val %f: %s\n",
+		  data->is_ref, data->ref.counted, data->val, id);
+
+	if (data->is_ref && !data->ref.counted) {
+		data->ref.counted = true;
+		pr_debug("processing metric: %s ENTRY\n", id);
+		if (expr__parse(&data->val, ctx, data->ref.metric_expr, 1)) {
+			pr_debug("%s failed to count\n", id);
+			return -1;
+		}
+		pr_debug("processing metric: %s EXIT: %f\n", id, data->val);
+	}
+
+	return 0;
+}
+
 void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
 {
 	struct expr_id_data *old_val = NULL;
@@ -173,6 +202,8 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	void *scanner;
 	int ret;
 
+	pr_debug2("parsing metric: %s\n", expr);
+
 	ret = expr_lex_init_extra(&scanner_ctx, &scanner);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 81d04ff7f857..9ed208d93418 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -23,6 +23,7 @@ struct expr_id_data {
 		struct {
 			const char *metric_name;
 			const char *metric_expr;
+			bool counted;
 		} ref;
 	};
 
@@ -42,6 +43,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data);
+int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
+		     struct expr_id_data **datap);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime);
 int expr__find_other(const char *expr, const char *one,
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 0d4f5d324be7..d34b370391c6 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -88,11 +88,11 @@ expr:	  NUMBER
 	| ID			{
 					struct expr_id_data *data;
 
-					if (expr__get_id(ctx, $1, &data) || !data) {
-						pr_debug("%s not found\n", $1);
+					if (expr__resolve_id(ctx, $1, &data)) {
 						free($1);
 						YYABORT;
 					}
+
 					$$ = data->val;
 					free($1);
 				}
-- 
2.25.4


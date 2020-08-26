Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73A3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6FC2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rQJ//icK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHZPbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgHZPbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:31:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D4CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:31:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a14so3208191ybm.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mzKKe77gcndMkQNf4MF3k/YQrrsZVftq4C5SmPUheSk=;
        b=rQJ//icKBYopWY3Ean1w54/P4w5ruKvIUiMPrdgupMy6PtolyM2FpChhSZe5fJgm2N
         vKtinlg+V45NJVuVM9ckw1cJI5rZcTu9MAFEbP1dgiKA0EOxHIZpHL2U7FGM05Wfa3xV
         xy7/Do8wqTSeQZcZC7IB0M958P9uQs42YBEg7xzoqnY/inNeBjfT9TACfopS3C86Qgya
         dBfAjMO5utidzLcto9QIFiqcjAoCOKc54BrnkWigPLcDNo5CII3QKqCo5C+wxU4J1iIr
         0hoagyVteqcgIPivLBZFkc3ghYbczMPai6qNdR/bYM3NvoXZZd37Vtwfk2s17QYpUDHZ
         +gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mzKKe77gcndMkQNf4MF3k/YQrrsZVftq4C5SmPUheSk=;
        b=imVGoA5lujzIrIiT/zVtK4kmagNjvACnGpFQySVrzrCY5WgzAyCTtNTAv8W+Jy76kW
         RUxf7R3iJcU7xzfBKoMlmGER8o1ovOkPk1nm21ydIoTAPeFSYOZbqJCIwFx+8bA9UCe4
         +I8lsj8GxsjTj3ooMrgxL2NioqPnYTl+cA5JNFpC1c/k+o+oPwrg1HjRiJANsi0BuQg6
         PvBkCZd9vkccOlN3C7coXdMXSgODry2cDcHumUsBVIpRF7AhOo/YKIWtnqPoOmCggnYT
         x4rKLR3/Mw/EtCWyltg879R96413qJ1CF0M/xg3jyx6iDwcyKeQRaChAR/DhICEBKR3A
         T7FQ==
X-Gm-Message-State: AOAM5335kap1nbuqAW7EXCaT0kT2ol/XzxH62X2NOU8k0eW/bf5nC9fo
        wnH7jNAc8irpCE0NVam27nUbjiYLEy5/
X-Google-Smtp-Source: ABdhPJwS371SnThrQOmwMtrYI9xYjZ+RR52wYwzBIKnt6fT0/lE/NkQk6N239rjZq8/DMljH/mLMf1QIklKQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:cb8d:: with SMTP id
 b135mr22916028ybg.381.1598455865534; Wed, 26 Aug 2020 08:31:05 -0700 (PDT)
Date:   Wed, 26 Aug 2020 08:30:55 -0700
Message-Id: <20200826153055.2067780-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2] perf expr: Force encapsulation on expr_id_data
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves some undefined behavior where variables in
expr_id_data were accessed (for debugging) without being defined. To
better enforce the tagged union behavior, the struct is moved into
expr.c and accessors provided. Tag values (kinds) are explicitly
identified.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c        | 68 ++++++++++++++++++++++++++++++-----
 tools/perf/util/expr.h        | 17 +++------
 tools/perf/util/expr.y        |  2 +-
 tools/perf/util/metricgroup.c |  4 +--
 4 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 53482ef53c41..a850fd0be3ee 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -17,6 +17,29 @@
 extern int expr_debug;
 #endif
 
+struct expr_id_data {
+	union {
+		double val;
+		struct {
+			double val;
+			const char *metric_name;
+			const char *metric_expr;
+		} ref;
+		struct expr_id	*parent;
+	};
+
+	enum {
+		/* Holding a double value. */
+		EXPR_ID_DATA__VALUE,
+		/* Reference to another metric. */
+		EXPR_ID_DATA__REF,
+		/* A reference but the value has been computed. */
+		EXPR_ID_DATA__REF_VALUE,
+		/* A parent is remembered for the recursion check. */
+		EXPR_ID_DATA__PARENT,
+	} kind;
+};
+
 static size_t key_hash(const void *key, void *ctx __maybe_unused)
 {
 	const char *str = (const char *)key;
@@ -48,6 +71,7 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
 		return -ENOMEM;
 
 	data_ptr->parent = ctx->parent;
+	data_ptr->kind = EXPR_ID_DATA__PARENT;
 
 	ret = hashmap__set(&ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
@@ -69,7 +93,7 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	if (!data_ptr)
 		return -ENOMEM;
 	data_ptr->val = val;
-	data_ptr->is_ref = false;
+	data_ptr->kind = EXPR_ID_DATA__VALUE;
 
 	ret = hashmap__set(&ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
@@ -114,8 +138,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 	 */
 	data_ptr->ref.metric_name = ref->metric_name;
 	data_ptr->ref.metric_expr = ref->metric_expr;
-	data_ptr->ref.counted = false;
-	data_ptr->is_ref = true;
+	data_ptr->kind = EXPR_ID_DATA__REF;
 
 	ret = hashmap__set(&ctx->ids, name, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
@@ -148,17 +171,30 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 
 	data = *datap;
 
-	pr_debug2("lookup: is_ref %d, counted %d, val %f: %s\n",
-		  data->is_ref, data->ref.counted, data->val, id);
-
-	if (data->is_ref && !data->ref.counted) {
-		data->ref.counted = true;
+	switch (data->kind) {
+	case EXPR_ID_DATA__VALUE:
+		pr_debug2("lookup(%s): val %f\n", id, data->val);
+		break;
+	case EXPR_ID_DATA__PARENT:
+		pr_debug2("lookup(%s): parent %s\n", id, data->parent->id);
+		break;
+	case EXPR_ID_DATA__REF:
+		pr_debug2("lookup(%s): ref metric name %s\n", id,
+			data->ref.metric_name);
 		pr_debug("processing metric: %s ENTRY\n", id);
-		if (expr__parse(&data->val, ctx, data->ref.metric_expr, 1)) {
+		data->kind = EXPR_ID_DATA__REF_VALUE;
+		if (expr__parse(&data->ref.val, ctx, data->ref.metric_expr, 1)) {
 			pr_debug("%s failed to count\n", id);
 			return -1;
 		}
 		pr_debug("processing metric: %s EXIT: %f\n", id, data->val);
+		break;
+	case EXPR_ID_DATA__REF_VALUE:
+		pr_debug2("lookup(%s): ref val %f metric name %s\n", id,
+			data->ref.val, data->ref.metric_name);
+		break;
+	default:
+		assert(0);  /* Unreachable. */
 	}
 
 	return 0;
@@ -241,3 +277,17 @@ int expr__find_other(const char *expr, const char *one,
 
 	return ret;
 }
+
+double expr_id_data__value(const struct expr_id_data *data)
+{
+	if (data->kind == EXPR_ID_DATA__VALUE)
+		return data->val;
+	assert(data->kind == EXPR_ID_DATA__REF_VALUE);
+	return data->ref.val;
+}
+
+struct expr_id *expr_id_data__parent(struct expr_id_data *data)
+{
+	assert(data->kind == EXPR_ID_DATA__PARENT);
+	return data->parent;
+}
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index fc2b5e824a66..dcf8d19b83c8 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -23,19 +23,7 @@ struct expr_parse_ctx {
 	struct expr_id	*parent;
 };
 
-struct expr_id_data {
-	union {
-		double val;
-		struct {
-			const char *metric_name;
-			const char *metric_expr;
-			bool counted;
-		} ref;
-		struct expr_id	*parent;
-	};
-
-	bool is_ref;
-};
+struct expr_id_data;
 
 struct expr_scanner_ctx {
 	int start_token;
@@ -57,4 +45,7 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 int expr__find_other(const char *expr, const char *one,
 		struct expr_parse_ctx *ids, int runtime);
 
+double expr_id_data__value(const struct expr_id_data *data);
+struct expr_id *expr_id_data__parent(struct expr_id_data *data);
+
 #endif
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index d34b370391c6..b2ada8f8309a 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -93,7 +93,7 @@ expr:	  NUMBER
 						YYABORT;
 					}
 
-					$$ = data->val;
+					$$ = expr_id_data__value(data);
 					free($1);
 				}
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..339bfb19a10b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -786,7 +786,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
 	if (ret)
 		return ret;
 
-	p = data->parent;
+	p = expr_id_data__parent(data);
 
 	while (p->parent) {
 		if (!strcmp(p->id, id)) {
@@ -807,7 +807,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
 	}
 
 	p->id     = strdup(id);
-	p->parent = data->parent;
+	p->parent = expr_id_data__parent(data);
 	*parent   = p;
 
 	return p->id ? 0 : -ENOMEM;
-- 
2.28.0.297.g1956fa8f8d-goog


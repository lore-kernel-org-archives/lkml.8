Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA38C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D626520702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560461;
	bh=i5rQBXCAa+ouq9ElHkoSLVOv5jsy255xFh4Lcwj7dI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cm9CnAJHl98vEN2+7kojMcNsUCgR56hnf980Mk0K2J2RCNNubA9pKxrub/DmvvFJV
	 6szkPgRj1Id5pb7ITY6qPq63lVgmRjQ3zHimsqR8oPZmGpriAhrmcIkwX6UUGnV/69
	 kSNyrQCFFeYBiulTsgc+qqsQrGdiB6Soq7mWma64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgGLN1j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49370 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729009AbgGLN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:25 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-P2ZGzDMpNgqqGRBC6hUiDA-1; Sun, 12 Jul 2020 09:27:20 -0400
X-MC-Unique: P2ZGzDMpNgqqGRBC6hUiDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 941B31800D42;
        Sun, 12 Jul 2020 13:27:18 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7610C7EFB6;
        Sun, 12 Jul 2020 13:27:15 +0000 (UTC)
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
Subject: [PATCH 12/18] perf metric: Compute referenced metrics
Date:   Sun, 12 Jul 2020 15:26:28 +0200
Message-Id: <20200712132634.138901-13-jolsa@kernel.org>
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

Adding computation (expr__parse call) of referenced metric at
the point when it needs to be resolved during the 'master'
metric computation.

Once the inner metric is computed, the result is stored and
used if there's another usage of that metric.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/expr.h |  3 +++
 tools/perf/util/expr.y |  4 ++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 6bf8a21f5c53..2784df38f8c2 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -91,6 +91,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 
 	data_ptr->ref.metric_name = ref->metric_name;
 	data_ptr->ref.metric_expr = ref->metric_expr;
+	data_ptr->ref.counted = false;
 	data_ptr->is_ref = true;
 
 	ret = hashmap__set(&ctx->ids, name, data_ptr,
@@ -110,6 +111,34 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
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
@@ -150,6 +179,8 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	void *scanner;
 	int ret;
 
+	pr_debug2("parsing metric: %s\n", expr);
+
 	ret = expr_lex_init_extra(&scanner_ctx, &scanner);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index d19e66915228..b6d1fba64eaa 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -25,6 +25,7 @@ struct expr_id_data {
 		struct {
 			const char *metric_name;
 			const char *metric_expr;
+			bool counted;
 		} ref;
 	};
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


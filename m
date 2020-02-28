Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB8C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E64246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582882605;
	bh=FrkLFhGUATgzOwBIMp/L46IR9VZhQ9gHHKsFhkBPD0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zG1ZyhxG2gXHBMgE5ZJCp/Opk1GxT0eYp7v0NIDBaSBy6591tBeDCeSzptKULhcEK
	 vSe4ot0jFUrJxFcsCqB6SrxJxdyHRs4VNf3OKItZx1dl6Y8eyDIPhv3DkQiO4qq7kn
	 tMMAX41UgN0dHK2Op5aS187IzRY8YD02IOmHzYfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgB1Jgo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:36:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34027 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726583AbgB1Jgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:36:43 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-0WdE756HPP6INQr3DWdRHA-1; Fri, 28 Feb 2020 04:36:38 -0500
X-MC-Unique: 0WdE756HPP6INQr3DWdRHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B53D8017CC;
        Fri, 28 Feb 2020 09:36:36 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.36.118.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2519F8D542;
        Fri, 28 Feb 2020 09:36:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 4/5] perf expr: Straighten expr__parse/expr__find_other interface
Date:   Fri, 28 Feb 2020 10:36:15 +0100
Message-Id: <20200228093616.67125-5-jolsa@kernel.org>
In-Reply-To: <20200228093616.67125-1-jolsa@kernel.org>
References: <20200228093616.67125-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now with flex parser we don't need to update parsed string
pointer, so the interface can just passed the pointer to the
expression instead of pointer to pointer.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/expr.c       | 6 +++---
 tools/perf/util/expr.c        | 8 ++++----
 tools/perf/util/expr.h        | 4 ++--
 tools/perf/util/stat-shadow.c | 4 +---
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 87843af4c118..755d73c86c68 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -10,7 +10,7 @@ static int test(struct parse_ctx *ctx, const char *e, double val2)
 {
 	double val;
 
-	if (expr__parse(&val, ctx, &e))
+	if (expr__parse(&val, ctx, e))
 		TEST_ASSERT_VAL("parse test failed", 0);
 	TEST_ASSERT_VAL("unexpected value", val == val2);
 	return 0;
@@ -44,11 +44,11 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 		return ret;
 
 	p = "FOO/0";
-	ret = expr__parse(&val, &ctx, &p);
+	ret = expr__parse(&val, &ctx, p);
 	TEST_ASSERT_VAL("division by zero", ret == 1);
 
 	p = "BAR/";
-	ret = expr__parse(&val, &ctx, &p);
+	ret = expr__parse(&val, &ctx, p);
 	TEST_ASSERT_VAL("missing operand", ret == 1);
 
 	TEST_ASSERT_VAL("find other",
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index b39fd39f10ec..45b25530db5b 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -52,9 +52,9 @@ __expr__parse(double *val, struct parse_ctx *ctx, const char *expr,
 	return ret;
 }
 
-int expr__parse(double *final_val, struct parse_ctx *ctx, const char **pp)
+int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr)
 {
-	return __expr__parse(final_val, ctx, *pp, EXPR_PARSE);
+	return __expr__parse(final_val, ctx, expr, EXPR_PARSE);
 }
 
 static bool
@@ -71,14 +71,14 @@ already_seen(const char *val, const char *one, const char **other,
 	return false;
 }
 
-int expr__find_other(const char *p, const char *one, const char ***other,
+int expr__find_other(const char *expr, const char *one, const char ***other,
 		     int *num_other)
 {
 	int err, i = 0, j = 0;
 	struct parse_ctx ctx;
 
 	expr__ctx_init(&ctx);
-	err = __expr__parse(NULL, &ctx, p, EXPR_OTHER);
+	err = __expr__parse(NULL, &ctx, expr, EXPR_OTHER);
 	if (err)
 		return -1;
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index df0a17df0cef..9377538f4097 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -17,8 +17,8 @@ struct parse_ctx {
 
 void expr__ctx_init(struct parse_ctx *ctx);
 void expr__add_id(struct parse_ctx *ctx, const char *id, double val);
-int expr__parse(double *final_val, struct parse_ctx *ctx, const char **pp);
-int expr__find_other(const char *p, const char *one, const char ***other,
+int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr);
+int expr__find_other(const char *expr, const char *one, const char ***other,
 		int *num_other);
 
 #endif
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2c41d47f6f83..854d6abf2993 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -779,9 +779,7 @@ static void generic_metric(struct perf_stat_config *config,
 	}
 
 	if (!metric_events[i]) {
-		const char *p = metric_expr;
-
-		if (expr__parse(&ratio, &pctx, &p) == 0) {
+		if (expr__parse(&ratio, &pctx, metric_expr) == 0) {
 			char *unit;
 			char metric_bf[64];
 
-- 
2.24.1


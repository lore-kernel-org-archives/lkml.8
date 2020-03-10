Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C39C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFFD24692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583839020;
	bh=XsbZZA2FL7eD/t4M0XX353ItBmmm1Id5TJgqSc2GpAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rNn5ttBztXEHAk+G55TI6zdb2G1ASAkYlSZrQxoa0jKCiJ8db9q+S5h2u+Cp6Ge4r
	 q3R2EyKyxu4qOCmEbsD6DST+HcM0gHxSW9QGE+Qo3INp6kBNJdTqdCNLrxa/Xg5NmC
	 gmRXeK2PHqLyVFwhEvsfYxiUrVI6DwJ48OQ220Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCJLRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgCJLQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:16:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5142468D;
        Tue, 10 Mar 2020 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583839015;
        bh=XsbZZA2FL7eD/t4M0XX353ItBmmm1Id5TJgqSc2GpAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BIrjPQgC/i9n6tF6AjtUBZFR7i5f0REsmIfUUU13hUXLHbDSBM4J5ZH7ADMMp80Qh
         naYW8Wn+WX2ro1PZEqQpq03oPHILcHPcFuJgC+Y/Tnd2KWmWS7czsqB5DAteFzKJZe
         f+U3Q0thwIzL947rfkTAAEX3iUv8qNEENrO+EsWM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/19] perf expr: Straighten expr__parse()/expr__find_other() interface
Date:   Tue, 10 Mar 2020 08:15:46 -0300
Message-Id: <20200310111551.25160-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Now that we have a flex parser we don't need to update the parsed string
pointer, so the interface can just be passed the pointer to the
expression instead of a pointer to pointer.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200228093616.67125-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 90d23cc3c8d4..0fd713d3674f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -777,9 +777,7 @@ static void generic_metric(struct perf_stat_config *config,
 	}
 
 	if (!metric_events[i]) {
-		const char *p = metric_expr;
-
-		if (expr__parse(&ratio, &pctx, &p) == 0) {
+		if (expr__parse(&ratio, &pctx, metric_expr) == 0) {
 			char *unit;
 			char metric_bf[64];
 
-- 
2.21.1


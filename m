Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAEBC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FE32166E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgCSOLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:11:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32889 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgCSOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsz-0002EC-FO; Thu, 19 Mar 2020 15:11:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F128A1C22A7;
        Thu, 19 Mar 2020 15:10:50 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:50 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf expr: Straighten
 expr__parse()/expr__find_other() interface
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200228093616.67125-5-jolsa@kernel.org>
References: <20200228093616.67125-5-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <158462705069.28353.9906239911903408424.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0f9b1e124bb29719eb1572db74b7893bd616f938
Gitweb:        https://git.kernel.org/tip/0f9b1e124bb29719eb1572db74b7893bd616f938
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Fri, 28 Feb 2020 10:36:15 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 09 Mar 2020 21:43:24 -03:00

perf expr: Straighten expr__parse()/expr__find_other() interface

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
index 87843af..755d73c 100644
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
index b39fd39..45b2553 100644
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
index df0a17d..9377538 100644
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
index 90d23cc..0fd713d 100644
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
 

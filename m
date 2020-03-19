Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D8BC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6372137B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgCSOMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:12:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgCSOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsu-0002DH-Ve; Thu, 19 Mar 2020 15:10:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 96F6C1C22AA;
        Thu, 19 Mar 2020 15:10:50 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:50 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf expr: Make expr__parse() return -1 on error
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
In-Reply-To: <20200228093616.67125-6-jolsa@kernel.org>
References: <20200228093616.67125-6-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <158462705032.28353.2819488994049030835.tip-bot2@tip-bot2>
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

Commit-ID:     d942815a76463fa53b81d3d1c064f76bb3f80ead
Gitweb:        https://git.kernel.org/tip/d942815a76463fa53b81d3d1c064f76bb3f80ead
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Fri, 28 Feb 2020 10:36:16 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 09 Mar 2020 21:43:25 -03:00

perf expr: Make expr__parse() return -1 on error

To match the error value of the expr__find_other function, so all
exported expr functions return the same values:
0 on success, -1 on error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200228093616.67125-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/expr.c | 4 ++--
 tools/perf/util/expr.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 755d73c..28313e5 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -45,11 +45,11 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	p = "FOO/0";
 	ret = expr__parse(&val, &ctx, p);
-	TEST_ASSERT_VAL("division by zero", ret == 1);
+	TEST_ASSERT_VAL("division by zero", ret == -1);
 
 	p = "BAR/";
 	ret = expr__parse(&val, &ctx, p);
-	TEST_ASSERT_VAL("missing operand", ret == 1);
+	TEST_ASSERT_VAL("missing operand", ret == -1);
 
 	TEST_ASSERT_VAL("find other",
 			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO", &other, &num_other) == 0);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 45b2553..fd192dd 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -54,7 +54,7 @@ __expr__parse(double *val, struct parse_ctx *ctx, const char *expr,
 
 int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr)
 {
-	return __expr__parse(final_val, ctx, expr, EXPR_PARSE);
+	return __expr__parse(final_val, ctx, expr, EXPR_PARSE) ? -1 : 0;
 }
 
 static bool

Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C8C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13402098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgDVMU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728800AbgDVMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AF2C03C1A8;
        Wed, 22 Apr 2020 05:17:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJp-0007tb-DZ; Wed, 22 Apr 2020 14:17:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E355D1C0813;
        Wed, 22 Apr 2020 14:17:28 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:28 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf expr: Add expr_scanner_ctx object
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401203340.31402-3-kjain@linux.ibm.com>
References: <20200401203340.31402-3-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158755784848.28353.17588548435578970529.tip-bot2@tip-bot2>
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

Commit-ID:     871f9f599db8d9d2387c0717e712af405290edea
Gitweb:        https://git.kernel.org/tip/871f9f599db8d9d2387c0717e712af405290edea
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 02 Apr 2020 02:03:35 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:13 -03:00

perf expr: Add expr_scanner_ctx object

Add the expr_scanner_ctx object to hold user data for the expr scanner.
Currently it holds only start_token, Kajol Jain will use it to hold 24x7
runtime param.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20200401203340.31402-3-kjain@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.c |  6 ++++--
 tools/perf/util/expr.h |  4 ++++
 tools/perf/util/expr.l | 10 +++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c8ccc54..c3382d5 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -3,7 +3,6 @@
 #include <assert.h>
 #include "expr.h"
 #include "expr-bison.h"
-#define YY_EXTRA_TYPE int
 #include "expr-flex.h"
 
 #ifdef PARSER_DEBUG
@@ -30,11 +29,14 @@ static int
 __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	      int start)
 {
+	struct expr_scanner_ctx scanner_ctx = {
+		.start_token = start,
+	};
 	YY_BUFFER_STATE buffer;
 	void *scanner;
 	int ret;
 
-	ret = expr_lex_init_extra(start, &scanner);
+	ret = expr_lex_init_extra(&scanner_ctx, &scanner);
 	if (ret)
 		return ret;
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index b9e53f2..0938ad1 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -15,6 +15,10 @@ struct expr_parse_ctx {
 	struct expr_parse_id ids[MAX_PARSE_ID];
 };
 
+struct expr_scanner_ctx {
+	int start_token;
+};
+
 void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__add_id(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr);
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index eaad292..2582c24 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -76,13 +76,13 @@ sym		[0-9a-zA-Z_\.:@]+
 symbol		{spec}*{sym}*{spec}*{sym}*
 
 %%
-	{
-		int start_token;
+	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
 
-		start_token = expr_get_extra(yyscanner);
+	{
+		int start_token = sctx->start_token;
 
-		if (start_token) {
-			expr_set_extra(NULL, yyscanner);
+		if (sctx->start_token) {
+			sctx->start_token = 0;
 			return start_token;
 		}
 	}

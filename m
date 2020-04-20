Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D850C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272DB21744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383724;
	bh=6wrPEIoM9YaePAw3gUAanS3QlSnerW821ZjtRcMHPTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cOd6XwEgW1xmCbIKFo+BopacDZn3YFTxGNTspqte/Dk4mc/lHxW966jNxYAB1JicM
	 l+PSqvR825lCV7WSQq6EI0WprwhSca6T2lLPGp7BQcrPmII6uTWhudIkCJ6RG2gLp/
	 nzDwAaA3pF7oRIlUCcXemsxYI7c8n7l+H3hysfHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgDTLzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgDTLzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:55:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BBB620724;
        Mon, 20 Apr 2020 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383719;
        bh=6wrPEIoM9YaePAw3gUAanS3QlSnerW821ZjtRcMHPTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekxw3HM6NI+rDNtXQAF/vFxPPCHJVPmEJVKPgwmw+f/swuO0tmk+pjKK3/j8NTp9C
         7zttxvTqoPGvj+90XhYLb24Ov3Eqgm2kCuhi+tu94npauFrBix9lHyl2bUCmCHKTZ2
         ZuEb3O/f27FBc7hwzSf6q0Rs9mZIHh/ancAD9HS8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Petlan <mpetlan@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/60] perf expr: Add expr_scanner_ctx object
Date:   Mon, 20 Apr 2020 08:52:38 -0300
Message-Id: <20200420115316.18781-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
index c8ccc548a585..c3382d58cf40 100644
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
index b9e53f2b5844..0938ad166ece 100644
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
index eaad29243c23..2582c2464938 100644
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
-- 
2.21.1


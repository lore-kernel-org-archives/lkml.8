Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A4C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DB524693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583839009;
	bh=ZEATF7lg8IEO+3kI6cvjyWku5CBK3+qv/i0ORVCd99k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UW5SN6Ier7QDlOpv/r021SkrAkinbKaWrsA2QUR0JYrN5wqH3PLdRlPUnNXimsl7B
	 InXHRCKsPAM3UtY74ij0TS/OBk04/lj+lokNEV9lT18/bL3x4cbis2ledt0DSuH492
	 O15JsAVL7ea7GGLP7oLJwJi2EHzlLu/yYNjrPYHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgCJLQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCJLQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:16:45 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 719222468D;
        Tue, 10 Mar 2020 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583839003;
        bh=ZEATF7lg8IEO+3kI6cvjyWku5CBK3+qv/i0ORVCd99k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1FKz4fdEXvafBmPy91dnmYex3f9nYzeNkemBCQz/pJI5Wd1s/LY1EyD+kgRul7YZt
         8lfI0havIcitdE9U2BzM+pxVjmucV2H6KEGoyDy6EC+sSplvgjjDM9D9jwSAC2LtZ9
         qR2pznX9cYsreZCiWKR+yvIt2IMcYypnAfKkdnPk=
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
Subject: [PATCH 11/19] perf expr: Add expr.c object
Date:   Tue, 10 Mar 2020 08:15:43 -0300
Message-Id: <20200310111551.25160-12-acme@kernel.org>
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

Add generic expr code into new expr.c object.

The expr.c object will be mainly used in following change that will get
rid of the manual flex code,

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200228093616.67125-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build  |  1 +
 tools/perf/util/expr.c | 19 +++++++++++++++++++
 tools/perf/util/expr.y | 16 ----------------
 3 files changed, 20 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/util/expr.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 07da6c790b63..6fdf073093a6 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -122,6 +122,7 @@ perf-y += vsprintf.o
 perf-y += units.o
 perf-y += time-utils.o
 perf-y += expr-bison.o
+perf-y += expr.o
 perf-y += branch.o
 perf-y += mem2node.o
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
new file mode 100644
index 000000000000..816b23b2068a
--- /dev/null
+++ b/tools/perf/util/expr.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
+#include "expr.h"
+
+/* Caller must make sure id is allocated */
+void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
+{
+	int idx;
+
+	assert(ctx->num_ids < MAX_PARSE_ID);
+	idx = ctx->num_ids++;
+	ctx->ids[idx].name = name;
+	ctx->ids[idx].val = val;
+}
+
+void expr__ctx_init(struct parse_ctx *ctx)
+{
+	ctx->num_ids = 0;
+}
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 7d226241f1d7..7cea8b7c3a5c 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -6,7 +6,6 @@
 #define IN_EXPR_Y 1
 #include "expr.h"
 #include "smt.h"
-#include <assert.h>
 #include <string.h>
 
 #define MAXIDLEN 256
@@ -169,21 +168,6 @@ static int expr__lex(YYSTYPE *res, const char **pp)
 	return tok;
 }
 
-/* Caller must make sure id is allocated */
-void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
-{
-	int idx;
-	assert(ctx->num_ids < MAX_PARSE_ID);
-	idx = ctx->num_ids++;
-	ctx->ids[idx].name = name;
-	ctx->ids[idx].val = val;
-}
-
-void expr__ctx_init(struct parse_ctx *ctx)
-{
-	ctx->num_ids = 0;
-}
-
 static bool already_seen(const char *val, const char *one, const char **other,
 			 int num_other)
 {
-- 
2.21.1


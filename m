Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BEFC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C005B20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582532975;
	bh=kOqKZLkZEVaCFtOkgbl+k6GGuTFB/LL2SA04jEQK3ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gHXJ8VmVQeooJmeYUR6rDB2/6PnuU/OfBsnW0QBu4C1iHRX3yyqulvoBq6Wp17sMC
	 dBEqMLzen1+gCOAV7dVNgj9kWD1AMD4P25yhoSz/9gKb0R3ZRBVddYzA+icCMsvPAo
	 09aSqZiaZPaUjIf83fcLFU3DbNFX6Mm6cwxQ1gtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgBXI3e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:29:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56060 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbgBXI3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:29:34 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-AM3G2bOIMy6bGP49SxUsNQ-1; Mon, 24 Feb 2020 03:29:28 -0500
X-MC-Unique: AM3G2bOIMy6bGP49SxUsNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7618D800D53;
        Mon, 24 Feb 2020 08:29:26 +0000 (UTC)
Received: from krava.redhat.com (ovpn-205-68.brq.redhat.com [10.40.205.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B8985781;
        Mon, 24 Feb 2020 08:29:23 +0000 (UTC)
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
Subject: [PATCH 1/5] perf expr: Add expr.c object
Date:   Mon, 24 Feb 2020 09:29:14 +0100
Message-Id: <20200224082918.58489-2-jolsa@kernel.org>
In-Reply-To: <20200224082918.58489-1-jolsa@kernel.org>
References: <20200224082918.58489-1-jolsa@kernel.org>
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

Add generic expr code into new expr.c object.

The expr.c object will be mainly used in following
change that will get rid of the manual flex code,

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.24.1


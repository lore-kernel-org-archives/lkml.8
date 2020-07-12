Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA52C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26FA20702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560425;
	bh=FIia8I/ZqN3vFzpbExrFQuhnRlQgUKbTuko8zD/8Re4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1zTOKCxwYRDKYsSytb0RmHVz1qaswQnVG9cg7FgUF76WkdiY1fGLJEHKcGPqCw3UU
	 a7aoe0l8F7fZFBkUUC/k1KK9OBdInHmvUfgJ3EMsfdcT/0Al6lfonmVePVS/uJjxuf
	 a41NUwYDghvzOCxOKZfdZkZSLQVuxfcwMuqWdNZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgGLN1E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728907AbgGLN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:00 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-4aZKawQ8N2CdTO_4Fgt4Tw-1; Sun, 12 Jul 2020 09:26:54 -0400
X-MC-Unique: 4aZKawQ8N2CdTO_4Fgt4Tw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B10DE80183C;
        Sun, 12 Jul 2020 13:26:52 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF6DF7EFB6;
        Sun, 12 Jul 2020 13:26:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 04/18] perf metric: Change expr__get_id to return struct expr_id_data
Date:   Sun, 12 Jul 2020 15:26:20 +0200
Message-Id: <20200712132634.138901-5-jolsa@kernel.org>
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

Changing expr__get_id to use and return struct expr_id_data
pointer as value for the ID. This way we can access data other
than value for given ID in following changes.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 10 +++-------
 tools/perf/util/expr.h |  3 ++-
 tools/perf/util/expr.y | 14 +++++++++-----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 4b8953605aed..7d02d29286bc 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -69,14 +69,10 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	return ret;
 }
 
-int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
+int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
+		 struct expr_id_data **data)
 {
-	struct expr_id_data *data;
-
-	if (!hashmap__find(&ctx->ids, id, (void **)&data))
-		return -1;
-	*val_ptr = (data == NULL) ?  0.0 : data->val;
-	return 0;
+	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
 }
 
 void expr__ctx_init(struct expr_parse_ctx *ctx)
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index ac32cda42006..f38292fdab19 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -28,7 +28,8 @@ void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
-int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
+int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
+		 struct expr_id_data **data);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime);
 int expr__find_other(const char *expr, const char *one,
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 8befe4a46f87..0d4f5d324be7 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -85,12 +85,16 @@ if_expr:
 	;
 
 expr:	  NUMBER
-	| ID			{ if (expr__get_id(ctx, $1, &$$)) {
-					pr_debug("%s not found\n", $1);
+	| ID			{
+					struct expr_id_data *data;
+
+					if (expr__get_id(ctx, $1, &data) || !data) {
+						pr_debug("%s not found\n", $1);
+						free($1);
+						YYABORT;
+					}
+					$$ = data->val;
 					free($1);
-					YYABORT;
-				  }
-				  free($1);
 				}
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
 	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
-- 
2.25.4


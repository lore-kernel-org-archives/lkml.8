Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0EFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A4E22B42
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014375;
	bh=yQub8ZXewZaUtDkTd75eUkG2X2CRp6vl1p9UflALruU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tph8hd4ByCi3t5UsODaVmEB//Tty4qyUPh6JRVw13bOnUSrfKXUQh2iW1dsRR7cAt
	 Nqc9lF7h73sh1+scMoyaHA2PQh9M6LBA2OgQgW15IT38NBPoZce6ba6h7OQMNMdfRQ
	 pHNj7tnDx/5gXzND4pxwPMXqD10R6cBBP7ElH6Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgG2JTe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:19:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20712 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727846AbgG2JTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:19:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-9K4Rt95MPG6OOQa9jDuT0Q-1; Wed, 29 Jul 2020 05:19:26 -0400
X-MC-Unique: 9K4Rt95MPG6OOQa9jDuT0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 777FA801504;
        Wed, 29 Jul 2020 09:19:24 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DD456931E;
        Wed, 29 Jul 2020 09:19:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 03/19] perf metric: Change expr__get_id to return struct expr_id_data
Date:   Wed, 29 Jul 2020 11:18:52 +0200
Message-Id: <20200729091908.1378911-4-jolsa@kernel.org>
In-Reply-To: <20200729091908.1378911-1-jolsa@kernel.org>
References: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200719181320.785305-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.c | 10 +++-------
 tools/perf/util/expr.h |  3 ++-
 tools/perf/util/expr.y | 14 +++++++++-----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 9228f60e2a20..4e5a6533dfce 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -73,14 +73,10 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
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


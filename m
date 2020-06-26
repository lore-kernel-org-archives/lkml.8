Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94DFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9557E207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200872;
	bh=UVUGDD015bXeFP32qwSAeDkwTfMQ11D5ZNWWeL3atAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pk1fLuH6q2m6j63Omwi2rKnu7+LxFVQCiCpbOoSdLyNlBK8WqI/ZSdl/l5VEsx0ex
	 ajV3iHLmlY2RFkqvCQCnZUoK9efwg2fCq1OcTFf7mipggZYqT/InciNVqpHd1xmtiA
	 vgGXjTd56Qj1aWFrDl/vIbasmrb6swKv/0bGoTSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFZTrv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:47:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37396 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbgFZTrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:47:48 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-e59kq2S5OuG26Kcs6TCcyw-1; Fri, 26 Jun 2020 15:47:43 -0400
X-MC-Unique: e59kq2S5OuG26Kcs6TCcyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36E6887950C;
        Fri, 26 Jun 2020 19:47:41 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 607231944D;
        Fri, 26 Jun 2020 19:47:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 04/10] perf tools: Change expr__get_id to return struct expr_parse_data
Date:   Fri, 26 Jun 2020 21:47:14 +0200
Message-Id: <20200626194720.2915044-5-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-1-jolsa@kernel.org>
References: <20200626194720.2915044-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing expr__get_id to use and return struct expr_parse_data
pointer as value for the ID. This way we can access data other
than value for given ID in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 10 +++-------
 tools/perf/util/expr.h |  3 ++-
 tools/perf/util/expr.y | 14 +++++++++-----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 0b6d3a6ce88e..29cdef18849c 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -69,14 +69,10 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
 	return ret;
 }
 
-int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
+int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
+		 struct expr_parse_data **data)
 {
-	struct expr_parse_data *data;
-
-	if (!hashmap__find(&ctx->ids, id, (void **)&data))
-		return -1;
-	*val_ptr = (data == NULL) ?  0.0 : data->val;
-	return 0;
+	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
 }
 
 void expr__ctx_init(struct expr_parse_ctx *ctx)
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 5452e641acf4..0af5b887b6c7 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -28,7 +28,8 @@ void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *name);
 int expr__add_val(struct expr_parse_ctx *ctx, const char *id, double val);
-int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
+int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
+		 struct expr_parse_data **data);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime);
 int expr__find_other(const char *expr, const char *one,
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index ac4b119877e0..6252d9f6cfc8 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -87,12 +87,16 @@ if_expr:
 	;
 
 expr:	  NUMBER
-	| ID			{ if (expr__get_id(ctx, $1, &$$)) {
-					pr_debug("%s not found\n", $1);
+	| ID			{
+					struct expr_parse_data *data;
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


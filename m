Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ADAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC0821744
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014379;
	bh=/+kmzo5EZkBouq1Rht0TDKsMXmt9Cn5IdZlVBxAoSQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Ue+5iTr9MRS++Bwc3+ja2DQTyDMsylo2Nj+5g1WjRAxnoHK5/EJUWUDhJ3D60KZq
	 +K+popgkDQ8Qp1l8WLmjE+DxPcI5L7qCuvtvw9uT91BRtBi6ALkUlwDSmChoM2WRsU
	 TdDKcFQnKPt5vPFyE8UHBI1Cc9nzUmLIghvFb1Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgG2JTi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:19:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41990 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727846AbgG2JTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:19:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-fsTo_W7-PreETM1hYGOoaQ-1; Wed, 29 Jul 2020 05:19:30 -0400
X-MC-Unique: fsTo_W7-PreETM1hYGOoaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D90AC59;
        Wed, 29 Jul 2020 09:19:27 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D66576932D;
        Wed, 29 Jul 2020 09:19:24 +0000 (UTC)
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
Subject: [PATCH 04/19] perf metric: Add expr__del_id function
Date:   Wed, 29 Jul 2020 11:18:53 +0200
Message-Id: <20200729091908.1378911-5-jolsa@kernel.org>
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

Adding expr__del_id function to remove ID from hashmap.  It will save us
few lines in following changes.

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
Link: http://lore.kernel.org/lkml/20200719181320.785305-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.c | 21 +++++++++++++--------
 tools/perf/util/expr.h |  1 +
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 4e5a6533dfce..f726211f49d4 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -79,6 +79,17 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
 }
 
+void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
+{
+	struct expr_id_data *old_val = NULL;
+	char *old_key = NULL;
+
+	hashmap__delete(&ctx->ids, id,
+			(const void **)&old_key, (void **)&old_val);
+	free(old_key);
+	free(old_val);
+}
+
 void expr__ctx_init(struct expr_parse_ctx *ctx)
 {
 	hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
@@ -136,16 +147,10 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 int expr__find_other(const char *expr, const char *one,
 		     struct expr_parse_ctx *ctx, int runtime)
 {
-	struct expr_id_data *old_val = NULL;
-	char *old_key = NULL;
 	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
 
-	if (one) {
-		hashmap__delete(&ctx->ids, one,
-				(const void **)&old_key, (void **)&old_val);
-		free(old_key);
-		free(old_val);
-	}
+	if (one)
+		expr__del_id(ctx, one);
 
 	return ret;
 }
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index f38292fdab19..2462abd0ac65 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -26,6 +26,7 @@ struct expr_scanner_ctx {
 
 void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
+void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
-- 
2.25.4


Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B128C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D29320C09
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200876;
	bh=kRrDoWO1JJjeTGWkRViLEtxVT0GPOB8iMagLNEIBfiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJpZKkaC3Ualhg0ozDK2y6KZYzP05bcpRyX1AG4zzvUV0hyWsgSCLoXR+UpapDApR
	 l32FlF20aTMGDrM9UHJhKIRq+VZ5yp+ZybEPAy5UzHEgbQfgg6Y2qDUvMOFNQN7y4F
	 Hg/MAEqLWxDO/84lrrVCWFY/vIKVoBtOzhCoJSkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgFZTrz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:47:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38214 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgFZTrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:47:53 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-_1S3YdHEO5KtHScB5tEozA-1; Fri, 26 Jun 2020 15:47:46 -0400
X-MC-Unique: _1S3YdHEO5KtHScB5tEozA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6414718A8220;
        Fri, 26 Jun 2020 19:47:44 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9310A5BAD2;
        Fri, 26 Jun 2020 19:47:41 +0000 (UTC)
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
Subject: [PATCH 05/10] perf tools: Add expr__del_id function
Date:   Fri, 26 Jun 2020 21:47:15 +0200
Message-Id: <20200626194720.2915044-6-jolsa@kernel.org>
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

Adding expr__del_id function to remove ID from hashmap.
It will save us few lines in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 21 +++++++++++++--------
 tools/perf/util/expr.h |  1 +
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 29cdef18849c..aa14c7111ecc 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -75,6 +75,17 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
 }
 
+void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
+{
+	struct expr_parse_data *old_val = NULL;
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
@@ -132,16 +143,10 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 int expr__find_other(const char *expr, const char *one,
 		     struct expr_parse_ctx *ctx, int runtime)
 {
-	struct expr_parse_data *old_val = NULL;
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
index 0af5b887b6c7..1a76b002c576 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -26,6 +26,7 @@ struct expr_scanner_ctx {
 
 void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
+void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *name);
 int expr__add_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
-- 
2.25.4


Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE87C433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77C7206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560426;
	bh=Awo32tr/VSH+3qMA1uEkHaDJ65fsCpwJgwdOY/X7Cv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsS0cH29pr9AnbVk46F8nGC8FyUv3WCRaRwvbHG0dUCPKS40KNOoscMkWfyPvVA3K
	 t+f93LFTov/bpxEfU8QAAcY4dAzItWrEP3r7N2vt1poqFTzXJzz78M4FPHGTN7tjNA
	 Hxs2ct2oAMsQeniiLESGlCEKMhs/a1ZAQ+zEl2DU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgGLN1F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45980 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728890AbgGLN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:03 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-nHtDZSEtOh-GFg1uZiUUYg-1; Sun, 12 Jul 2020 09:26:57 -0400
X-MC-Unique: nHtDZSEtOh-GFg1uZiUUYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD5E31081;
        Sun, 12 Jul 2020 13:26:55 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11F207EFB6;
        Sun, 12 Jul 2020 13:26:52 +0000 (UTC)
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
Subject: [PATCH 05/18] perf metric: Add expr__del_id function
Date:   Sun, 12 Jul 2020 15:26:21 +0200
Message-Id: <20200712132634.138901-6-jolsa@kernel.org>
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

Adding expr__del_id function to remove ID from hashmap.
It will save us few lines in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 21 +++++++++++++--------
 tools/perf/util/expr.h |  1 +
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7d02d29286bc..91142d4c3419 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -75,6 +75,17 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
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
@@ -132,16 +143,10 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
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


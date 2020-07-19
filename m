Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63266C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEBB20684
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182422;
	bh=0Po+jh4mBdhOC8OjpU9OLJe/BNbpH9lixgpoS5WFoLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HfltLbhmJNOxJ8xvkRcE0PLymv+DbjSBmB0sHJdpkM+jG9JtljEVVkbTMjBb4dN0Y
	 zMK0HXfvRZ9z3SgVupuijbfHBkJJAlQwnYnJjuD1N8cMKlqbFi6J5f3y+z2GIa/UIa
	 PIzI3UT0DOEGgCXma6guKFR1fxf/eDFsieRlF7p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGSSNl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:13:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57783 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725783AbgGSSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:13:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-sdrB2i0MPDqsKOhmozjksQ-1; Sun, 19 Jul 2020 14:13:33 -0400
X-MC-Unique: sdrB2i0MPDqsKOhmozjksQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9583C106B242;
        Sun, 19 Jul 2020 18:13:31 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EB8974F6C;
        Sun, 19 Jul 2020 18:13:28 +0000 (UTC)
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
Subject: [PATCH 02/19] perf metric: Add expr__add_id function
Date:   Sun, 19 Jul 2020 20:13:03 +0200
Message-Id: <20200719181320.785305-3-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding expr__add_id function to data for ID
with zero value, which is used when scanning
the expression for IDs.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 31 +++++++++++++++++++++++++------
 tools/perf/util/expr.h |  1 +
 tools/perf/util/expr.y |  2 +-
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 578a173d4873..9228f60e2a20 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -32,6 +32,26 @@ static bool key_equal(const void *key1, const void *key2,
 	return !strcmp((const char *)key1, (const char *)key2);
 }
 
+/* Caller must make sure id is allocated */
+int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
+{
+	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
+	char *old_key = NULL;
+	int ret;
+
+	data_ptr = malloc(sizeof(*data_ptr));
+	if (!data_ptr)
+		return -ENOMEM;
+
+	ret = hashmap__set(&ctx->ids, id, data_ptr,
+			   (const void **)&old_key, (void **)&old_data);
+	if (ret)
+		free(data_ptr);
+	free(old_key);
+	free(old_data);
+	return ret;
+}
+
 /* Caller must make sure id is allocated */
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 {
@@ -39,12 +59,11 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	char *old_key = NULL;
 	int ret;
 
-	if (val != 0.0) {
-		data_ptr = malloc(sizeof(*data_ptr));
-		if (!data_ptr)
-			return -ENOMEM;
-		data_ptr->val = val;
-	}
+	data_ptr = malloc(sizeof(*data_ptr));
+	if (!data_ptr)
+		return -ENOMEM;
+	data_ptr->val = val;
+
 	ret = hashmap__set(&ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
 	if (ret)
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 21fe5bd85718..ac32cda42006 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -26,6 +26,7 @@ struct expr_scanner_ctx {
 
 void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
+int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index b2b3420ea6ec..8befe4a46f87 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -69,7 +69,7 @@ all_other: all_other other
 
 other: ID
 {
-	expr__add_id_val(ctx, $1, 0.0);
+	expr__add_id(ctx, $1);
 }
 |
 MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
-- 
2.25.4


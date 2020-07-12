Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731D1C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5292920702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560421;
	bh=sBv7szlRuwT5l4jgRfVZiKdWHqICEDHAkcmfWWbg8zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZmJf6y4AUhmw0JAQcMdRZMI/+j0VEK+67DEBSNrexZTkkTD6QeprjI7oTXXRLRkQB
	 12fYQCTssLqt/CdqeapmS4+ZcqET1N3dRlZkjIbETAQJiKcTLAzb4yVyClprkE4H1u
	 dtk5u+MeRePVYJGs8NZDz7RLnY7WQy3u3dhvvJsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgGLN1A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35067 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728890AbgGLN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:26:58 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-c4uFGvqMOpmZU3MNUpb60Q-1; Sun, 12 Jul 2020 09:26:51 -0400
X-MC-Unique: c4uFGvqMOpmZU3MNUpb60Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 864731009440;
        Sun, 12 Jul 2020 13:26:49 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B50411944D;
        Sun, 12 Jul 2020 13:26:46 +0000 (UTC)
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
Subject: [PATCH 03/18] perf metric: Add expr__add_id function
Date:   Sun, 12 Jul 2020 15:26:19 +0200
Message-Id: <20200712132634.138901-4-jolsa@kernel.org>
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

Adding expr__add_id function to data for ID
with zero value, which is used when scanning
the expression for IDs.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 29 +++++++++++++++++++++++------
 tools/perf/util/expr.h |  1 +
 tools/perf/util/expr.y |  2 +-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 5d05f9765ed8..4b8953605aed 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -32,6 +32,24 @@ static bool key_equal(const void *key1, const void *key2,
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
+	free(old_key);
+	free(old_data);
+	return ret;
+}
+
 /* Caller must make sure id is allocated */
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 {
@@ -39,12 +57,11 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
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
 	free(old_key);
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


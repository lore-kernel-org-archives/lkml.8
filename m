Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EE0C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDB020725
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560416;
	bh=WX2Y0lBhtkrehCUlc/p/Hb7qHbPyxcI9yFrUQ0SBYiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fc924RBKqB2KlXLyaaRNptMyaKSoa5MEQzSSFj0XrDJoTUeLcf7KV/mCx5JjBokvS
	 Am3DBKG5uZi8R4G8sGxImJiYF16aiSbcKjWncrcgiO84TR1EX60osaYq28Rr96ZHA2
	 mlVwrxYxqijEr6Ni9+ex0SyolKbhxHOYec6L8dbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgGLN0z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:26:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728890AbgGLN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:26:53 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-oKGpHWC0PjCfxCOLQ5BCTw-1; Sun, 12 Jul 2020 09:26:48 -0400
X-MC-Unique: oKGpHWC0PjCfxCOLQ5BCTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6178E80183C;
        Sun, 12 Jul 2020 13:26:46 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5488E1944D;
        Sun, 12 Jul 2020 13:26:43 +0000 (UTC)
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
Subject: [PATCH 02/18] perf metric: Add struct expr_id_data to keep expr value
Date:   Sun, 12 Jul 2020 15:26:18 +0200
Message-Id: <20200712132634.138901-3-jolsa@kernel.org>
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

Adding struct expr_id_data to keep expr value
instead of just simple double pointer, so we can
store more data for ID in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/expr.c       |  3 ++-
 tools/perf/util/expr.c        | 22 +++++++++++-----------
 tools/perf/util/expr.h        |  4 ++++
 tools/perf/util/metricgroup.c |  2 +-
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index d13fc1dfd5ef..4d01051951cd 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -18,8 +18,9 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 
 int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
+	struct expr_id_data *val_ptr;
 	const char *p;
-	double val, *val_ptr;
+	double val;
 	int ret;
 	struct expr_parse_ctx ctx;
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 9116a3a01eea..5d05f9765ed8 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -33,32 +33,32 @@ static bool key_equal(const void *key1, const void *key2,
 }
 
 /* Caller must make sure id is allocated */
-int expr__add_id_val(struct expr_parse_ctx *ctx, const char *name, double val)
+int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 {
-	double *val_ptr = NULL, *old_val = NULL;
+	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
 	int ret;
 
 	if (val != 0.0) {
-		val_ptr = malloc(sizeof(double));
-		if (!val_ptr)
+		data_ptr = malloc(sizeof(*data_ptr));
+		if (!data_ptr)
 			return -ENOMEM;
-		*val_ptr = val;
+		data_ptr->val = val;
 	}
-	ret = hashmap__set(&ctx->ids, name, val_ptr,
-			   (const void **)&old_key, (void **)&old_val);
+	ret = hashmap__set(&ctx->ids, id, data_ptr,
+			   (const void **)&old_key, (void **)&old_data);
 	free(old_key);
-	free(old_val);
+	free(old_data);
 	return ret;
 }
 
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
 {
-	double *data;
+	struct expr_id_data *data;
 
 	if (!hashmap__find(&ctx->ids, id, (void **)&data))
 		return -1;
-	*val_ptr = (data == NULL) ?  0.0 : *data;
+	*val_ptr = (data == NULL) ?  0.0 : data->val;
 	return 0;
 }
 
@@ -119,7 +119,7 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 int expr__find_other(const char *expr, const char *one,
 		     struct expr_parse_ctx *ctx, int runtime)
 {
-	double *old_val = NULL;
+	struct expr_id_data *old_val = NULL;
 	char *old_key = NULL;
 	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index bb6bac836b48..21fe5bd85718 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -15,6 +15,10 @@ struct expr_parse_ctx {
 	struct hashmap ids;
 };
 
+struct expr_id_data {
+	double	val;
+};
+
 struct expr_scanner_ctx {
 	int start_token;
 	int runtime;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 82fecb5a302d..df0356ec120d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -138,7 +138,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      unsigned long *evlist_used)
 {
 	struct evsel *ev, *current_leader = NULL;
-	double *val_ptr;
+	struct expr_id_data *val_ptr;
 	int i = 0, matched_events = 0, events_to_match;
 	const int idnum = (int)hashmap__size(&pctx->ids);
 
-- 
2.25.4


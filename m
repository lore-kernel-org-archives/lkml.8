Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCFDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14C2206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200864;
	bh=i4QSOFElPpNCXpNJPe6lj7RoO8FgFqF3DkfTNa01wNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n0c4P6R5Z57wBB88SAUMaPk1wOtDjFaEDUKiSEYhALFnZR2FjE0vIqsvqM5mrlC3l
	 0AycNqpWu8dwb/lRs5dPgBHnibRYbJ2ostYd7lMIsChqsjGgBIHFknVs2PlFvBP6ud
	 4l7MlM6GqbweJ8kCWs4kSQSF59sqk+rbBF8GFrrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgFZTrn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:47:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43126 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725781AbgFZTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:47:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-olH46WMLNzOXUpKqv1w7-A-1; Fri, 26 Jun 2020 15:47:35 -0400
X-MC-Unique: olH46WMLNzOXUpKqv1w7-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD9C418A8223;
        Fri, 26 Jun 2020 19:47:32 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57C2A1944D;
        Fri, 26 Jun 2020 19:47:28 +0000 (UTC)
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
Subject: [PATCH 02/10] perf tools: Add struct expr_parse_data to keep expr value
Date:   Fri, 26 Jun 2020 21:47:12 +0200
Message-Id: <20200626194720.2915044-3-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-1-jolsa@kernel.org>
References: <20200626194720.2915044-1-jolsa@kernel.org>
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

Adding struct expr_parse_data to keep expr value
instead of just simple double pointer, so we can
store more data for ID in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/expr.c       |  3 ++-
 tools/perf/util/expr.c        | 20 ++++++++++----------
 tools/perf/util/expr.h        |  4 ++++
 tools/perf/util/metricgroup.c |  2 +-
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 82aa32fcab64..e64461f1a24c 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -18,8 +18,9 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 
 int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
+	struct expr_parse_data *val_ptr;
 	const char *p;
-	double val, *val_ptr;
+	double val;
 	int ret;
 	struct expr_parse_ctx ctx;
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index a02937e5f3ac..7573b21e73df 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -35,30 +35,30 @@ static bool key_equal(const void *key1, const void *key2,
 /* Caller must make sure id is allocated */
 int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
 {
-	double *val_ptr = NULL, *old_val = NULL;
+	struct expr_parse_data *data_ptr = NULL, *old_data = NULL;
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
+	ret = hashmap__set(&ctx->ids, name, data_ptr,
+			   (const void **)&old_key, (void **)&old_data);
 	free(old_key);
-	free(old_val);
+	free(old_data);
 	return ret;
 }
 
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
 {
-	double *data;
+	struct expr_parse_data *data;
 
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
+	struct expr_parse_data *old_val = NULL;
 	char *old_key = NULL;
 	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 35bdc609cf55..f9f16efe76bc 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -15,6 +15,10 @@ struct expr_parse_ctx {
 	struct hashmap ids;
 };
 
+struct expr_parse_data {
+	double	val;
+};
+
 struct expr_scanner_ctx {
 	int start_token;
 	int runtime;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 82fecb5a302d..85e7fa2e2707 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -138,7 +138,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      unsigned long *evlist_used)
 {
 	struct evsel *ev, *current_leader = NULL;
-	double *val_ptr;
+	struct expr_parse_data *val_ptr;
 	int i = 0, matched_events = 0, events_to_match;
 	const int idnum = (int)hashmap__size(&pctx->ids);
 
-- 
2.25.4


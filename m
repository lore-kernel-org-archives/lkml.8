Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E274C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D775920707
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200868;
	bh=qwqNMz9uSZZsxWUkhNdeNXCr6+onC8Rj4PnsNKGzDiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WN/H35o9jIvbski3i9W5rp2sExRSAlMSoBYpLQytU57ljF2eZuqns6zYtgvnd3tZo
	 /K2EqOEQHcEFUBboC3+T1qbLqQ/CNVlPlvWI/J0wNGp2e3FGkN59bXSepx89ZLH/Zf
	 8rGNReE8si5WTYCftU2lvyfzyONj9QCg13wvQ+gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgFZTrr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:47:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31397 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbgFZTrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:47:46 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-Ss_EICmRN5yks1ZYxNp0Gw-1; Fri, 26 Jun 2020 15:47:39 -0400
X-MC-Unique: Ss_EICmRN5yks1ZYxNp0Gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06196464;
        Fri, 26 Jun 2020 19:47:38 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F2FC7FEA5;
        Fri, 26 Jun 2020 19:47:32 +0000 (UTC)
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
Subject: [PATCH 03/10] perf tools: Add expr__add_id function
Date:   Fri, 26 Jun 2020 21:47:13 +0200
Message-Id: <20200626194720.2915044-4-jolsa@kernel.org>
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

Adding expr__add_id function to data for ID
with zero value, which is used when scanning
the expression for IDs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 29 +++++++++++++++++++++++------
 tools/perf/util/expr.h |  1 +
 tools/perf/util/expr.y |  2 +-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7573b21e73df..0b6d3a6ce88e 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -32,6 +32,24 @@ static bool key_equal(const void *key1, const void *key2,
 	return !strcmp((const char *)key1, (const char *)key2);
 }
 
+/* Caller must make sure id is allocated */
+int expr__add_id(struct expr_parse_ctx *ctx, const char *name)
+{
+	struct expr_parse_data *data_ptr = NULL, *old_data = NULL;
+	char *old_key = NULL;
+	int ret;
+
+	data_ptr = malloc(sizeof(*data_ptr));
+	if (!data_ptr)
+		return -ENOMEM;
+
+	ret = hashmap__set(&ctx->ids, name, data_ptr,
+			   (const void **)&old_key, (void **)&old_data);
+	free(old_key);
+	free(old_data);
+	return ret;
+}
+
 /* Caller must make sure id is allocated */
 int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
 {
@@ -39,12 +57,11 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
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
 	ret = hashmap__set(&ctx->ids, name, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
 	free(old_key);
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index f9f16efe76bc..5452e641acf4 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -26,6 +26,7 @@ struct expr_scanner_ctx {
 
 void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
+int expr__add_id(struct expr_parse_ctx *ctx, const char *name);
 int expr__add_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index ff5e5f6e170d..ac4b119877e0 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -71,7 +71,7 @@ all_other: all_other other
 
 other: ID
 {
-	expr__add_val(ctx, $1, 0.0);
+	expr__add_id(ctx, $1);
 }
 |
 MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
-- 
2.25.4


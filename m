Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1620AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E000F207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200888;
	bh=hBKJqOaVfKl+TIHjJpv3vRbE/TYHLJXxUCT6dtXLg2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SLtgkFW/7x9SvaIyXl8uGqVaCAhIrXutao7PV9JcQpJCIA93tzli1FabXlccp6u0f
	 Ynu56i4OH8wO/RVDrAa4enlAQBTW/1+TXz4odiQ9BuT9MK4UB/XDtvCnRDTPBkRwCG
	 emokWU8gJPQEpr1s910AFj/0ZQ7iefhRwARXMP1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFZTsG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:48:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgFZTsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:48:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-ozILFOtBMlKJjgxBQ-o1Ig-1; Fri, 26 Jun 2020 15:48:00 -0400
X-MC-Unique: ozILFOtBMlKJjgxBQ-o1Ig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE283800D5C;
        Fri, 26 Jun 2020 19:47:58 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCF491944D;
        Fri, 26 Jun 2020 19:47:55 +0000 (UTC)
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
Subject: [PATCH 09/10] perf tools: Compute other metrics
Date:   Fri, 26 Jun 2020 21:47:19 +0200
Message-Id: <20200626194720.2915044-10-jolsa@kernel.org>
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

Adding computation (expr__parse call) of 'other' metric at
the point when it needs to be resolved during the 'master'
metric computation.

Once the inner metric is computed, the result is stored and
used if there's another usage of that metric.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c |  3 +++
 tools/perf/util/expr.h |  1 +
 tools/perf/util/expr.y | 20 +++++++++++++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 32f7acac7c19..1b6d550cec5f 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -91,6 +91,7 @@ int expr__add_other(struct expr_parse_ctx *ctx, struct metric_other *other)
 
 	data_ptr->other.metric_name = other->metric_name;
 	data_ptr->other.metric_expr = other->metric_expr;
+	data_ptr->other.counted = false;
 	data_ptr->is_other = true;
 
 	ret = hashmap__set(&ctx->ids, name, data_ptr,
@@ -150,6 +151,8 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	void *scanner;
 	int ret;
 
+	pr_debug2("parsing metric: %s\n", expr);
+
 	ret = expr_lex_init_extra(&scanner_ctx, &scanner);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index ed60f9227b43..f85f3941eda5 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -25,6 +25,7 @@ struct expr_parse_data {
 		struct {
 			const char *metric_name;
 			const char *metric_expr;
+			bool counted;
 		} other;
 	};
 };
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 6252d9f6cfc8..cca423331f65 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -89,12 +89,30 @@ if_expr:
 expr:	  NUMBER
 	| ID			{
 					struct expr_parse_data *data;
+					char *lookup = $1;
+					const char *name;
 
-					if (expr__get_id(ctx, $1, &data) || !data) {
+					if (expr__is_metric($1, &name))
+						lookup = name;
+
+					if (expr__get_id(ctx, lookup, &data) || !data) {
 						pr_debug("%s not found\n", $1);
 						free($1);
 						YYABORT;
 					}
+
+					pr_debug2("lookup: is_other %d, counted %d: %s\n",
+						  data->is_other, data->other.counted, lookup);
+
+					if (data->is_other && !data->other.counted) {
+						data->other.counted = true;
+						if (expr__parse(&data->val, ctx, data->other.metric_expr, 1)) {
+							pr_debug("%s failed to count\n", $1);
+							free($1);
+							YYABORT;
+						}
+					}
+
 					$$ = data->val;
 					free($1);
 				}
-- 
2.25.4

